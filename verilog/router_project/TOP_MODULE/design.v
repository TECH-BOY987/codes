`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2025 21:48:16
// Design Name: 
// Module Name: router_topmodule
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


module router_topmodule(
input clk,rst,pkt_valid,rd_en_0,rd_en_1,rd_en_2,
input [7:0]d_in,
output vld_out_0,vld_out_1,vld_out_2,err,busy,
output [7:0]dout_0,dout_1,dout_2);
wire[2:0]wr_en;
wire soft_rst_0,soft_rst_1,soft_rst_2,empty_0,empty_1,empty_2,full_0,full_1,full_2;
wire fifo_full,low_pkt_valid;
wire rst_int_reg,parity_done,wr_en_reg,detect_add,ld_state,laf_state,full_state,lfd_state;
wire[7:0]in;
router_fifo f0(clk,rst,soft_rst_0,wr_en[0],rd_en_0,lfd_state,in,dout_0,full_0,empty_0);
router_fifo f1(clk,rst,soft_rst_1,wr_en[1],rd_en_1,lfd_state,in,dout_1,full_1,empty_1);
router_fifo f2(clk,rst,soft_rst_2,wr_en[2],rd_en_2,lfd_state,in,dout_2,full_2,empty_2);
router_synchronizer sync(clk,rst,detect_add,full_0,full_1,full_2,empty_0,empty_1
,empty_2,wr_en_reg,rd_en_0,rd_en_1,rd_en_2,d_in[1:0],vld_out_0,vld_out_1,vld_out_2,fifo_full,soft_rst_0,soft_rst_1,soft_rst_2,wr_en);
router_register reg_0(clk,rst,pkt_valid,fifo_full,detect_add,
ld_state,laf_state,full_state,lfd_state,rst_int_reg,d_in,in,err,parity_done,low_pkt_valid);
router_fsm fsm(clk,rst,soft_rst_0,soft_rst_1,soft_rst_2,pkt_valid,fifo_full,empty_0,empty_1,empty_2,parity_done,low_pkt_valid,d_in[1:0],wr_en_reg,detect_add,ld_state,laf_state,lfd_state,full_state,rst_int_reg,busy);
endmodule
