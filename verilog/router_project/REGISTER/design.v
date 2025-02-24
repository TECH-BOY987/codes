`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2025 21:47:38
// Design Name: 
// Module Name: router_register
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


module router_register(
input clk,rst,pkt_valid,fifo_full,detect_add,ld_state,laf_state,full_state,lfd_state,rst_int_reg,
input [7:0]d_in,
output reg [7:0]dout,
output reg err,parity_done,low_pkt_valid);
reg [7:0]header,fifo_full_state,int_parity,pkt_parity_byte;
always@(posedge clk)
begin if(!rst)
parity_done<=0;
else if(detect_add)
parity_done<=0;
else if((ld_state &&(~fifo_full)&&(~pkt_valid))||(laf_state&&low_pkt_valid&&(~parity_done)))
parity_done<=1;
end
//low_pkt_valid
always@(posedge clk)
begin
if(!rst)
low_pkt_valid<=0;
else if(rst_int_reg)
low_pkt_valid<=0;
else if(ld_state&&~pkt_valid)
low_pkt_valid<=1;
end
always@(posedge clk)
begin 
if(!rst) begin
dout<=0;
header<=0;
fifo_full_state<=0;
end
else if(detect_add&& pkt_valid&&d_in[1:0]!=2'b11)
header<=d_in;
else if(lfd_state)
dout<=header;
else if(ld_state&&~fifo_full)
dout<=d_in;
else if(ld_state&&fifo_full)
fifo_full_state<=d_in;
else if(laf_state)
dout<=fifo_full_state;
end
always@(posedge clk)
begin if(!rst)
int_parity<=0;
else if(detect_add)
int_parity<=0;
else if(lfd_state&&pkt_valid)
int_parity<=int_parity^header;
else if(ld_state&&pkt_valid&&~full_state)
int_parity<=int_parity^d_in;
else
int_parity<=int_parity;
end
always@(posedge clk)
begin if(!rst)
err<=0;
else if(parity_done) begin
if(int_parity==pkt_parity_byte)
err<=0;
else
err<=1;
end
else err<=0;
end
always@(posedge clk)
begin if(!rst)
pkt_parity_byte<=0;
else if (detect_add) 
pkt_parity_byte <= 0;  
else if((ld_state&&!fifo_full&&!pkt_valid)||(laf_state&&~parity_done&&low_pkt_valid))
pkt_parity_byte<=d_in;
end
endmodule
