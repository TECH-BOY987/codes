module top_module(
input clk,rst,pkt_valid,rd_en_0,rd_en_1,rd_en_2,
input [7:0]d_in,
output vld_out_0,vld_out_1,vld_out_2,err,busy,
output [7:0]dout_0,dout_1,dout_2);
wire[2:0]wr_en;
wire soft_rst_0,soft_rst_1,soft_rst_2,empty_0,empty_1,empty_2,full_0,full_1,full_2;
wire lfd_state_t,fifo_full,low_pkt_valid;
wire rst_int_reg,parity_done,wr_en_reg,detect_add,ld_state,laf_state,full_state,lfd_state;
wire[7:0]in;
fifo_router f0(.clk(clk),.rst(rst),.soft_rst(soft_rst_0),.wr_en(wr_en[0]),.rd_en(rd_en_0),.lfd_state(lfd_state_t),.d_in(d_in),.dout(dout_0),.full(full_0),.empty(empty_0));
fifo_router f1(.clk(clk),.rst(rst),.soft_rst(soft_rst_1),.wr_en(wr_en[1]),.rd_en(rd_en_1),.lfd_state(lfd_state_t),.d_in(d_in),.dout(dout_1),.full(full_1),.empty(empty_1));
fifo_router f2(.clk(clk),.rst(rst),.soft_rst(soft_rst_2),.wr_en(wr_en[2]),.rd_en(rd_en_2),.lfd_state(lfd_state_t),.d_in(d_in),.dout(dout_2),.full(full_2),.empty(empty_2));
router_synchronizer sync(.clk(clk),.rst(rst),.detect_add(detect_add),.full_0(full_0),.full_1(full_1),.full_2(full_2),.empty_0(empty_0),.empty_1(empty_1)
,.empty_2(empty_2),.wr_en_reg(wr_en_reg),.rd_en_0(rd_en_0),.rd_en_1(rd_en_1),.rd_en_2(rd_en_2),.d_in(d_in[1:0]),.vld_out_0(vld_out_0),.vld_out_1(vld_out_1),.vld_out_2(vld_out_2),.fifo_full(fifo_full),.soft_rst_0(soft_rst_0),.soft_rst_1(soft_rst_1),.soft_rst_2(soft_rst_2),.wr_en(wr_en));
router_register reg_0(.clk(clk),.rst(rst),.pkt_valid(pkt_valid),.fifo_full(fifo_full),.detect_add(detect_add),
.ld_state(ld_state),.laf_state(laf_state),.full_state(full_state),.lfd_state(lfd_state),.rst_int_reg(rst_int_reg),.d_in(d_in),.dout(in),.err(err),.parity_done(parity_done),.low_pkt_valid(low_pkt_valid));
router_fsm fsm(.clk(clk),.rst(rst),.soft_rst_0(soft_rst_0),.soft_rst_1(soft_rst_1),.soft_rst_2(soft_rst_2),.pkt_valid(pkt_valid),.fifo_full(fifo_full),.fifo_empty_0(empty_0),.fifo_empty_1(empty_1),.fifo_empty_2(empty_2),.parity_done(parity_done),.low_pkt_valid(low_pkt_valid),.d_in(d_in[1:0]),.wr_en_reg(wr_en_reg),.detect_add(detect_add),.ld_state(ld_state),.laf_state(laf_state),.lfd_state(lfd_state),.full_state(full_state),.rst_int_reg(rst_int_reg),.busy(busy));
endmodule
