module half_adder_gatelevel(a,b,s,c);
input a,b;
output s,c;
xor G1(s,a,b);
and G2(c,a,b);
endmodule
//testbench
module half_adder_dataflow_tb;
reg a,b;
wire s,c;
half_adder_dataflow dut(a,b,s,c);
initial
begin
#10 a=1'b0;b=1'b0;
#10 a=1'b0;b=1'b1;
#10 a=1'b1;b=1'b0;
#10 a=1'b1;b=1'b1;
end
endmodule
