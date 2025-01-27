module router_synchronizer_tb();
reg clk,rst,detect_add,full_0,full_1,full_2,empty_0,empty_1,empty_2,wr_en_reg,rd_en_0,rd_en_1,rd_en_2;
reg [1:0]d_in;
wire vld_out_0,vld_out_1,vld_out_2,fifo_full,soft_rst_0,soft_rst_1,soft_rst_2;
wire [2:0]wr_en;
router_synchronizer dut(.clk(clk),.rst(rst),.detect_add(detect_add),.full_0(full_0),
.full_1(full_1),.full_2(full_2),.empty_0(empty_0),.empty_1(empty_1),.empty_2(empty_2),.wr_en_reg(wr_en_reg),.rd_en_0(rd_en_0),
.rd_en_1(rd_en_1),.rd_en_2(rd_en_2),.d_in(d_in),.vld_out_0(vld_out_0),.vld_out_1(vld_out_1),.vld_out_2(vld_out_2),.fifo_full(fifo_full),.soft_rst_0(soft_rst_0),.soft_rst_1(soft_rst_1),.soft_rst_2(soft_rst_2),.wr_en(wr_en));
always #5 clk=~clk;
initial begin
clk=1'b0;
rst=1'b0;
#10; rst=1'b1;
end
task task1();
begin
detect_add=1;
d_in=2'b00;
rd_en_0=1'b0;
rd_en_1=1'b1;
rd_en_2=1'b0;
wr_en_reg=1'b1;
full_0=0;
full_1=1;
full_2=1;
empty_0=0;
empty_1=0;
empty_2=0;
end
endtask
initial
begin
task1();
#300;
end
endmodule
