module mux_4x1_gatelevel(y,a,b,c,d,s0,s1);
input a,b,c,d,s0,s1;
output y;
assign y=((~s0)&(~s0)&a)|((~s1)&(s0)&b)|((~s0)&(s1)&c)|((s1)&(s0)&d);
endmodule
//testbench
module mux_4x1_gatelevel_tb;
wire y;
reg a,b,c,d,s0,s1;
mux_4x1_gatelevel dut(y,a,b,c,d,s0,s1);
initial
begin
#2 a=1'b0;b=1'b1;c=1'b1;d=1'b1;s0=1'b0;s1=1'b0;
#5 s1=1'b1;
#5 s0=1'b1;s1=1'b0;
#5 s1=1'b1;
end
endmodule

