module mux_2x1_dataflow(y,a,b,s);
input a,b,s;
output y;
assign y=(a&(~s)|b&s);
endmodule
//4x1mux_using_2x1mux
module mux_4x1_using_2x1(y,a,b,c,d,s0,s1);
input a,b,c,d,s0,s1;
output y;
wire t1,t2;
mux_2x1_dataflow G1(t1,a,b,s0);
mux_2x1_dataflow G2(t2,c,d,s0);
mux_2x1_dataflow G3(y,t1,t2,s1);
endmodule
//testbench
module mux_4x1_using_2x1_tb;
wire y;
reg a,b,c,d,s0,s1;
mux_4x1_using_2x1 dut(y,a,b,c,d,s0,s1);
initial
begin
#2 a=1'b0;b=1'b1;c=1'b1;d=1'b1;s0=1'b0;s1=1'b0;
#5 s1=1'b1;
#5 s0=1'b1;s1=1'b0;
#5 s1=1'b1;
end
endmodule
