module basic_gates_gatelevel(a,b,t,u,v,w,x,y,z);
input a,b;
output t,u,v,w,x,y,z;
and G1(t,a,b);
or G2(u,a,b);
not G3(v,a);
nand G4(w,a,b);
nor G5(x,a,b);
xor G6(y,a,b);
xnor G7(z,a,b);
endmodule

//testbench
module basic_gates_gatelevel_tb;
reg a,b;
wire t,u,v,w,x,y,z;
basic_gates_gatelevel dut(a,b,t,u,v,w,x,y,z);
initial
begin
#10 a=1'b0;b=1'b0;
#10 a=1'b0;b=1'b1;
#10 a=1'b1;b=1'b0;
#10 a=1'b1;b=1'b1;
end 
endmodule
