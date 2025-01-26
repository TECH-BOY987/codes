//design
module top(
    input [1:0]a,
    output [1:0]b);
    assign b=a;
endmodule

//testbench

module top_tb();
reg [1:0]a;
wire [1:0]b;
integer i;
top dut(.a(a),.b(b));
covergroup cvr_a;
coverpoint a;
coverpoint b;
endgroup
cvr_a ci=new();
initial begin
    for(i=0;i<10;i=i+1)
    begin
        a=$urandom();
        ci.sample();
        #10;
    end
end
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #500;
    $finish();
end
endmodule

# MODULE - work.top_tb
# 
# 
#     SUMMARY
#     =============================================
#     |    Coverage Type    | Weight | Hits/Total |
#     =============================================
#     | Covergroup Coverage |      1 |   100.000% |
#     |---------------------|--------|------------|
#     | Types               |        |      1 / 1 |
#     =============================================
#     WEIGHTED AVERAGE: 100.000%
# 
# 
#     COVERGROUP COVERAGE
#     ======================================================
#     |     Covergroup     |   Hits   |  Goal /  | Status  |
#     |                    |          | At Least |         |
#     ======================================================
#     | TYPE /top_tb/cvr_a | 100.000% | 100.000% | Covered |
#     ======================================================
# 
exit
# VSIM: Simulation has finished.
Finding VCD file...
./dump.vcd
[2024-11-28 12:42:43 UTC] Opening EPWave...
Done
