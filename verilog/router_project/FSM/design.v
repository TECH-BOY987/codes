module router_fsm(clk,rst,soft_rst_0,soft_rst_1,soft_rst_2,
                  pkt_valid,fifo_full,fifo_empty_0,fifo_empty_1,fifo_empty_2,
                  parity_done,low_pkt_valid,d_in,wr_en_reg,detect_add,ld_state,laf_state
                  ,lfd_state,full_state,rst_int_reg,busy);
input clk,rst,soft_rst_0,soft_rst_1,soft_rst_2,pkt_valid,fifo_full;
input fifo_empty_0,fifo_empty_1,fifo_empty_2,parity_done,low_pkt_valid;
input [1:0]d_in;
output reg wr_en_reg,detect_add,ld_state,laf_state,lfd_state,full_state,rst_int_reg,busy;
parameter DECODE_ADDRESS=3'b000;
parameter LOAD_FIRST_DATA=3'b001;
parameter WAIT_TILL_EMPTY=3'b010;
parameter LOAD_DATA=3'b011;
parameter CHECK_PARITY_ERROR=3'b100;
parameter LOAD_PARITY=3'b101;
parameter FIFO_FULL_STATE=3'b110;
parameter LOAD_AFTER_FULL=3'b111;
reg [3:0]ps,ns;
//reg [1:0]temp;
always@(posedge clk) begin
if(!rst)
ps<=DECODE_ADDRESS;
else if(soft_rst_0&&(d_in==2'b00)||soft_rst_1&&(d_in==2'b01)||soft_rst_2&&(d_in==2'b10))
ps<=DECODE_ADDRESS;
else
ps<=ns;
end
always@(*)
begin
case(ps)
DECODE_ADDRESS:
begin
if((pkt_valid&&(d_in==2'b00)&&fifo_empty_0)||(pkt_valid&&(d_in==2'b01)&&fifo_empty_1)||(pkt_valid&&(d_in==2'b10)&&fifo_empty_2))
ns<=LOAD_FIRST_DATA;
else if((pkt_valid &&(d_in==2'b00)&&!fifo_empty_0)||
(pkt_valid &&(d_in==2'b01)&&!fifo_empty_1)||
(pkt_valid &&(d_in==2'b10) &&!fifo_empty_2))
ns<=WAIT_TILL_EMPTY;
else
ns<=DECODE_ADDRESS;
end
LOAD_FIRST_DATA:ns<=LOAD_DATA;
LOAD_DATA:
begin
if(fifo_full)
ns<=FIFO_FULL_STATE;
else begin
if(!fifo_full && !pkt_valid)
ns<=LOAD_PARITY;
else
ns<=LOAD_DATA;
end
end
WAIT_TILL_EMPTY:
begin
if(fifo_empty_0||fifo_empty_1||fifo_empty_2)
ns<=LOAD_FIRST_DATA;
else
ns<=WAIT_TILL_EMPTY;
end
FIFO_FULL_STATE:
begin
if(!fifo_full)
ns<=LOAD_AFTER_FULL;
else
ns<=FIFO_FULL_STATE;
end
LOAD_AFTER_FULL:
begin
if(!parity_done&&!low_pkt_valid)
ns<=LOAD_DATA;
else if(!parity_done&&low_pkt_valid)
ns<=LOAD_PARITY;
else if(parity_done)
ns<=DECODE_ADDRESS;
end
LOAD_PARITY:ns<=CHECK_PARITY_ERROR;
CHECK_PARITY_ERROR: begin
if(fifo_full)
ns<=FIFO_FULL_STATE;
else
ns<=DECODE_ADDRESS;
end
default:
ns<=DECODE_ADDRESS;
endcase
end
always@(*) begin
detect_add<=0;
wr_en_reg<=0;
full_state<=0;
lfd_state<=0;
busy<=0;
ld_state<=0;
laf_state<=0;
rst_int_reg<=0;
case(ps) 
DECODE_ADDRESS:begin
detect_add<=1'b1;
end
LOAD_FIRST_DATA: begin
lfd_state<=1'b1;
busy<=1'b1;
end
LOAD_DATA: begin
wr_en_reg<=1'b1;
ld_state<=1'b1;
end
WAIT_TILL_EMPTY: begin
busy<=1'b1;
end
FIFO_FULL_STATE: begin
full_state<=1'b1;
busy<=1'b1;
end
LOAD_AFTER_FULL: begin
wr_en_reg<=1'b1;
busy<=1'b1;
laf_state<=1'b1;
end
LOAD_PARITY: begin
wr_en_reg<=1'b1;
busy<=1'b1;
end
CHECK_PARITY_ERROR: begin
rst_int_reg<=1'b1;
busy<=1'b1;
end
endcase
end
endmodule
