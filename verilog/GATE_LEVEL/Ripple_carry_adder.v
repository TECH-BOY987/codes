//fulladder
module full_adder(s,co,a,b,c);
input a,b,c;
output s,co;
assign s=a^b^c;
assign co=(a&b|((a^b)&c));
endmodule
//ripple_carry_adder
module ripple_carry_adder(s,co,a,b,c);
input [3:0]a,b;
input c;
output [3:0]s;
output co;
wire c1,c2,c3;
full_adder G1(s[0],c1,a[0],b[0],c);
full_adder G2(s[1],c2,a[1],b[1],c1);
full_adder G3(s[2],c3,a[2],b[2],c2);
full_adder G4(s[3],co,a[3],b[3],c3);
endmodule
//testbench
module ripple_carrt_adder_tb;
wire [3:0]s;
wire co;
reg [3:0]a,b;
reg c;
ripple_carry_adder dut(s,co,a,b,c);
initial
begin
#10 a=4'b0;b=4'b0;c=1'b0;
#10 a=4'b0;b=4'b1;
#10 a=4'b1;b=4'b0;
#10 a=4'b1;b=4'b1;
end
endmodule
