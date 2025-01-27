module router_register(
input clk,rst,pkt_valid,fifo_full,detect_add,ld_state,laf_state,full_state,lfd_state,rst_int_reg,
input [7:0]d_in,
output reg [7:0]dout,
output reg err,parity_done,low_pkt_valid);
reg [7:0]header,fifo_full_state,int_parity,pkt_parity_byte;
always@(posedge clk)
begin if(!rst)
parity_done<=1'b0;
else begin
if((ld_state &&!fifo_full&&!pkt_valid)||(laf_state&&low_pkt_valid&&!parity_done))
parity_done<=1'b1;
else if(detect_add)
parity_done<=1'b0;
end
end
//low_pkt_valid
always@(posedge clk)
begin
if(!rst)
low_pkt_valid<=1'b0;
else if(rst_int_reg)
low_pkt_valid<=1'b0;
else if(ld_state&&!pkt_valid)
low_pkt_valid<=1'b1;
end
always@(posedge clk)
begin if(!rst)
begin
dout<=0;
header<=0;
fifo_full_state<=0;
end
else if(detect_add&& pkt_valid)
header<=d_in;
else if(lfd_state)
dout<=header;
else if(ld_state&&!fifo_full)
dout<=d_in;
else if(ld_state&&fifo_full)
fifo_full_state<=d_in;
else if(laf_state)
dout<=fifo_full_state;
end
always@(posedge clk)
begin if(!rst)
int_parity<=8'b0;
else if(lfd_state)
int_parity<=int_parity^header;
else if(ld_state&&pkt_valid&&!full_state)
int_parity<=int_parity^d_in;
else if(laf_state)
int_parity<=int_parity^fifo_full_state;
end
always@(posedge clk)
begin if(!rst)
err<=1'b0;
else if(parity_done)
if(int_parity!=pkt_parity_byte)
err<=0;
else
err<=1;
else err<=0;
end
always@(posedge clk)
begin if(!rst)
pkt_parity_byte<=8'b0;
else if((ld_state&&!pkt_valid))
pkt_parity_byte<=d_in;
end
endmodule
