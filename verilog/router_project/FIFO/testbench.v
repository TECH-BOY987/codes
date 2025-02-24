
module router_fifo_tb();
reg clk=0,rst,soft_rst,wr_en,rd_en,lfd_state;
reg [7:0] d_in;
wire [7:0] dout;
wire full,empty;
router_fifo dut(clk,rst,soft_rst,wr_en,rd_en,lfd_state,d_in,dout,full,empty);
always #5 clk=~clk;
integer i,j;
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
for(i=0;i<16;i=i+1)
begin
d_in=$urandom_range(0,255);
#10;
lfd_state=0;
end
wr_en=1'b0;
rd_en=1'b1;
for(j=0;j<16;j=j+1) begin
$display("D[%d]: %h",j,dout);
#10;
end
end
endmodule
