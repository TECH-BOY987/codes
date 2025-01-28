module half_subtractor_gatelevel(a,b,d,bo);
input a,b;
output d,bo;
wire t1;
xor G1(d,a,b);
not G2(t1,a);
and G3(bo,t1,b);
endmodule
//testbench
module half_subtractor_gatelevel_tb;
reg a,b;
wire d,bo;
half_subtractor_gatelevel dut(a,b,d,bo);
initial
begin
#10 a=1'b0;b=1'b0;
#10 a=1'b0;b=1'b1;
#10 a=1'b1;b=1'b0;
#10 a=1'b1;b=1'b1;
end
endmodule
