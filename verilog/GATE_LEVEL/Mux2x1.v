module mux_2x1_dataflow(a,b,s,y);
input a,b,s;
output y;
assign y=(a&(~s)|b&s);
endmodule
//testbench
module mux_2x1_dataflow_tb;
reg a,b,s;
wire y;
mux_2x1_dataflow dut(a,b,s,y);
initial
begin
#10 s=1'b0;a=1'b0;b=1'b0;
#10 s=1'b0;a=1'b0;b=1'b1;
#10 s=1'b0;a=1'b1;b=1'b0;
#10 s=1'b0;a=1'b1;b=1'b1;
#10 s=1'b1;a=1'b0;b=1'b0;
#10 s=1'b1;a=1'b0;b=1'b1;
#10 s=1'b1;a=1'b1;b=1'b0;
#10 s=1'b1;a=1'b1;b=1'b1;
end
endmodule
