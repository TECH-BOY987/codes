`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2025 21:47:58
// Design Name: 
// Module Name: router_synchronizer
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


module router_synchronizer(
input clk,rst,detect_add,full_0,full_1,full_2,
input empty_0,empty_1,empty_2,wr_en_reg,rd_en_0,rd_en_1,rd_en_2,
input [1:0]d_in,
output vld_out_0,vld_out_1,vld_out_2,
output reg fifo_full,soft_rst_0,soft_rst_1,soft_rst_2,
output reg [2:0]wr_en);
reg[1:0]temp;
reg[5:0]count0,count1,count2;
always@(posedge clk) begin
if(!rst)
temp<=0;
else if(detect_add)
temp<=d_in;
end
always@(*)
begin
case(temp)
2'b00:begin
fifo_full<=full_0;
if(wr_en_reg) 
wr_en<=3'b001;
else
wr_en<=3'b000;
end
2'b01:begin
fifo_full<=full_1;
if(wr_en_reg) 
wr_en<=3'b010;
else
wr_en<=3'b000;
end
2'b10:begin
fifo_full<=full_2;
if(wr_en_reg) 
wr_en<=3'b100;
else
wr_en<=3'b000;
end
default: begin
fifo_full<=0;
wr_en<=0;
end
endcase
end
assign vld_out_0=(~empty_0);
assign vld_out_1=(~empty_1);
assign vld_out_2=(~empty_2);
always@(posedge clk) begin
if(!rst) begin
count0<=0;
soft_rst_0<=0;
end
else if(vld_out_0) begin
if(!rd_en_0) begin
if(count0==29) begin
soft_rst_0<=1;
count0<=0;
end else begin
soft_rst_0<=0;
count0<=count0+1;
end
end 
else
count0<=0;
end
end
always@(posedge clk) begin
if(!rst) begin
count1<=0;
soft_rst_1<=0;
end
else if(vld_out_1) begin
if(!rd_en_1) begin
if(count1==29) begin
soft_rst_1<=1;
count1<=0;
end else begin
soft_rst_1<=0;
count1<=count1+1;
end
end
else
count1<=0;
end
end
always@(posedge clk) begin
if(!rst) begin
count2<=0;
soft_rst_2<=0;
end
else if(vld_out_2) begin
if(!rd_en_2) begin
if(count2==29) begin
soft_rst_2<=1;
count2<=0;
end else begin
soft_rst_2<=0;
count2<=count2+1;
end
end
else
count2<=0;
end
end
endmodule
