module mux2x1(i0,i1,s,y);
input logic i0,i1,s;
output logic y;
assign y=s? i0:i1;
endmodule 
//testbench
module mux2x1_tb;
logic i0,i1,s;
logic y;
mux2x1 dut(i0,i1,s,y);
initial
begin
    $monitor("i0=%0d,i1=%0d,s=%0d,y=%0d",i0,i1,s,y);
    i0=1;i1=1;
    s=0;
    #5;s=1;
end
endmodule
