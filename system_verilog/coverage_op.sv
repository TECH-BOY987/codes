module ex_tb;
  reg [1:0]a;
  reg [1:0]b;
  integer i;
  ex dut(.a(a),.b(b));
  covergroup c;
    option.per_instance=1;
    coverpoint a
    {
      option.weight=5;
    }
    coverpoint b
    {
      option.weight=3;
    }
  endgroup
  initial begin
    c ci=new();
    for(i=0;i<5;i=i+1)
      begin
        a=$urandom;
        b=$urandom;
        ci.sample();
        $display("a=%d ; b=%d ; coverage =%.2f",a,b,ci.get_inst_coverage());
        #5;
      end
  end
  initial begin
     $dumpfile("dump.vcd");
    $dumpvars;
    #500;
    $finish();
  end
endmodule
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 6447 kB (elbread=455 elab2=5855 kernel=136 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: a=2 ; b=1 ; coverage =25.00
# KERNEL: a=1 ; b=3 ; coverage =50.00
# KERNEL: a=2 ; b=2 ; coverage =59.38
# KERNEL: a=3 ; b=3 ; coverage =75.00
# KERNEL: a=1 ; b=3 ; coverage =75.00
# RUNTIME: Info: RUNTIME_0068 testbench.sv (34): $finish called.
# KERNEL: Time: 500 ns,  Iteration: 0,  Instance: /ex_tb,  Process: @INITIAL#30_1@.
# KERNEL: stopped at time: 500 ns
# VSIM: Simulation has finished. There are no more test vectors to simulate.
# ACDB: Covergroup Coverage data has been saved to "fcover.acdb" database.
# VSIM: Simulation has finished.
Finding VCD file...
./dump.vcd
[2024-11-21 18:02:04 UTC] Opening EPWave...
Done
