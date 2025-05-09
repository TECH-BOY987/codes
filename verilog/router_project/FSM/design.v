`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2025 21:47:18
// Design Name: 
// Module Name: router_fsm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module router_fsm(clk,rst,soft_rst_0,soft_rst_1,soft_rst_2,
                  pkt_valid,fifo_full,fifo_empty_0,fifo_empty_1,fifo_empty_2,
                  parity_done,low_pkt_valid,d_in,wr_en_reg,detect_add,ld_state,laf_state
                  ,lfd_state,full_state,rst_int_reg,busy);
input clk,rst,soft_rst_0,soft_rst_1,soft_rst_2,pkt_valid,fifo_full;
input fifo_empty_0,fifo_empty_1,fifo_empty_2,parity_done,low_pkt_valid;
input [1:0]d_in;
output wr_en_reg,detect_add,ld_state,laf_state,lfd_state,full_state,rst_int_reg,busy;
parameter DECODE_ADDRESS=3'b000;
parameter LOAD_FIRST_DATA=3'b001;
parameter WAIT_TILL_EMPTY=3'b010;
parameter LOAD_DATA=3'b011;
parameter CHECK_PARITY_ERROR=3'b100;
parameter LOAD_PARITY=3'b101;
parameter FIFO_FULL_STATE=3'b110;
parameter LOAD_AFTER_FULL=3'b111;
reg [2:0]ps,ns;
always@(posedge clk) begin
if(!rst)
ps<=DECODE_ADDRESS;
else if(soft_rst_0||soft_rst_1||soft_rst_2)
ps<=DECODE_ADDRESS;
else
ps<=ns;
end
always@(*)
begin
ns=DECODE_ADDRESS;
case(ps)
DECODE_ADDRESS:
begin
if((pkt_valid&&d_in==0&&fifo_empty_0)||(pkt_valid&&d_in==1&&fifo_empty_1)||(pkt_valid&&d_in==2&&fifo_empty_2))
ns=LOAD_FIRST_DATA;
else if((pkt_valid &&d_in==0&&~fifo_empty_0)||
(pkt_valid &&d_in==1&&!fifo_empty_1)||
(pkt_valid &&d_in==2&&!fifo_empty_2))
ns=WAIT_TILL_EMPTY;
else
ns=DECODE_ADDRESS;
end
LOAD_FIRST_DATA:ns<=LOAD_DATA;
WAIT_TILL_EMPTY:
begin
if(fifo_empty_0||fifo_empty_1||fifo_empty_2)
ns=LOAD_FIRST_DATA;
else
ns=WAIT_TILL_EMPTY;
end
LOAD_DATA:
begin
if(fifo_full)
ns<=FIFO_FULL_STATE;
else 
if(!fifo_full && !pkt_valid)
ns=LOAD_PARITY;
else
ns=LOAD_DATA;
end
CHECK_PARITY_ERROR: begin
if(fifo_full)
ns=FIFO_FULL_STATE;
else
ns=DECODE_ADDRESS;
end
LOAD_PARITY: ns<=CHECK_PARITY_ERROR;
FIFO_FULL_STATE:
begin
if(!fifo_full)
ns=LOAD_AFTER_FULL;
else
ns=FIFO_FULL_STATE;
end
LOAD_AFTER_FULL:
begin
if(!parity_done&&!low_pkt_valid)
ns=LOAD_DATA;
else if(!parity_done&&low_pkt_valid)
ns=LOAD_PARITY;
else if(parity_done)
ns=DECODE_ADDRESS;
end
endcase
end
assign detect_add = (ps == DECODE_ADDRESS); 
  assign wr_en_reg = (ps == LOAD_DATA || ps == LOAD_PARITY || ps == LOAD_AFTER_FULL);
  assign full_state = (ps == FIFO_FULL_STATE); 
  assign lfd_state = (ps == LOAD_FIRST_DATA); 
  assign busy = (ps == LOAD_FIRST_DATA || ps == LOAD_PARITY || ps == FIFO_FULL_STATE || ps == LOAD_AFTER_FULL || ps == WAIT_TILL_EMPTY || ps == CHECK_PARITY_ERROR);
  assign ld_state = (ps == LOAD_DATA); 
  assign laf_state = (ps == LOAD_AFTER_FULL);
  assign rst_int_reg = (ps == CHECK_PARITY_ERROR); 
endmodule
