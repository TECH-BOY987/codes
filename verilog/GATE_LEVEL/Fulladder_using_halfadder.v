module half_adder(s,co,a,b);
input a,b;
output s,co;
assign s=a^b;
assign co=a&b;
endmodule

//fulladder
module full_adder_halfadder(s,co,a,b,c);
input a,b,c;
output s,co;
wire t1,t2,t3;
half_adder G1(t1,t2,a,b);
half_adder G2(s,t3,t1,c);
assign co=t2|t3;
endmodule
//testbench
module full_adder_halfadder_tb;
wire s,co;
reg a,b,c;
full_adder_halfadder dut(s,co,a,b,c);
initial
begin
#10 a=1'b0;b=1'b0;c=1'b0;
#10 a=1'b0;b=1'b0;c=1'b1;
#10 a=1'b0;b=1'b1;c=1'b0;
#10 a=1'b0;b=1'b1;c=1'b1;
#10 a=1'b1;b=1'b0;c=1'b0;
#10 a=1'b1;b=1'b0;c=1'b1;
#10 a=1'b1;b=1'b1;c=1'b0;
#10 a=1'b1;b=1'b1;c=1'b1;
end
endmodule
