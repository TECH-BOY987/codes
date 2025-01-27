module fifo_router_tb();
reg clk,rst,soft_rst,wr_en,rd_en,lfd_state;
reg [7:0] d_in;
wire [7:0] dout;
wire full,empty;
fifo_router dut(clk,rst,soft_rst,wr_en,rd_en,lfd_state,d_in,dout,full,empty);
initial begin
clk=1;
forever
#5 clk=~clk;
end
initial begin
rst=1'b0;
#10;rst=1'b1;
//first
soft_rst=1;
rd_en=0;
wr_en=0;
d_in=8'd0;
#10;
wr_en=1'b1;
soft_rst=1'b0;
lfd_state=1'b1;
#10;
repeat(10)
begin
d_in=$urandom_range(0,255);
#10;
lfd_state=0;
end
wr_en=1'b0;
rd_en=1'b1;
#100;
end
endmodule
