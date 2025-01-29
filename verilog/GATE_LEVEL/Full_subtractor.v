module full_subtractor_gatelevel(a,b,c,d,bo);
input a,b,c;
output d,bo;
wire t1,t2,t3,t4,t5;
xor G0(t1,a,b);
xnor G1(t2,a,b);
not G2(t3,a);
and G3(t4,t3,b);
xor G4(d,t1,c);
and G5(t5,t2,c);
or G6(bo,t4,t5);
endmodule
//testbench
module full_subtractor_gatelevel_tb;
reg a,b,c;
wire d,bo;
full_subtractor_gatelevel dut(a,b,c,d,bo);
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
