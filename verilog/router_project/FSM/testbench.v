module router_fsm_tb();
reg clk=0,rst,soft_rst_0,soft_rst_1,soft_rst_2,pkt_valid,fifo_full,fifo_empty_0,fifo_empty_1,fifo_empty_2,parity_done,low_pkt_valid;
reg [1:0]d_in;
wire wr_en_reg,detect_add,ld_state,laf_state,lfd_state,full_state,rst_int_reg,busy;
router_fsm dut(.clk(clk),.rst(rst),.soft_rst_0(soft_rst_0),.soft_rst_1(soft_rst_1),.soft_rst_2(soft_rst_2),.pkt_valid(pkt_valid),.fifo_full(fifo_full),
.fifo_empty_0(fifo_empty_0),.fifo_empty_1(fifo_empty_1),.fifo_empty_2(fifo_empty_2),.parity_done(parity_done),.low_pkt_valid(low_pkt_valid),.d_in(d_in),.wr_en_reg(wr_en_reg),
.detect_add(detect_add),.ld_state(ld_state),.laf_state(laf_state),.lfd_state(lfd_state),.full_state(full_state),.rst_int_reg(rst_int_reg),.busy(busy));
always #5 clk=~clk;
task reset;
begin
rst=1'b0;              
pkt_valid = 0;
fifo_full = 0;
fifo_empty_0 = 0;
fifo_empty_1 = 0;
fifo_empty_2 = 0;
soft_rst_0 = 0;
soft_rst_1 = 0;
soft_rst_2 = 0;
parity_done = 0;
low_pkt_valid = 0;
d_in = 0;
#10;
rst=1'b1;
end
endtask
task t1;
begin
pkt_valid=1'b1;
fifo_empty_0=1'b1;
d_in=2'b00;
#10;
fifo_full=0;
pkt_valid=0;
#10;
fifo_full=0;
end
endtask
task t2;
begin
pkt_valid=1'b1;
fifo_empty_0=1'b1;
d_in=2'b00;
#10;
fifo_full=1;
pkt_valid=0;
#10;
fifo_full=0;
end
endtask
task t3;
begin
pkt_valid=1'b1;
fifo_empty_0=1'b1;
d_in=2'b00;
#10;
fifo_full=0;
pkt_valid=0;
#10;
fifo_full=1;
end
endtask
initial
begin
reset;
#20;
t1;
#30;
t2;
#30;
t3;
#30;
$finish;
end
endmodule
