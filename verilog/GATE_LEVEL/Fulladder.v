module full_adder_gatelevel(a,b,c,s,co);
input a,b,c;
output s,co;
wire t1,t2,t3;
xor G1(t1,a,b);
and G2(t2,a,b);
xor G3(s,t1,c);
and G4(t3,t1,c);
or G5(co,t2,t3);
endmodule
//testbench
module full_adder_gatelevel_tb;
reg a,b,c;
wire s,co;
full_adder_gatelevel dut(a,b,c,s,co);
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
