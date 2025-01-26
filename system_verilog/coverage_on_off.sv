module tb;
  reg[1:0]a=0;
  reg rst=0;
  integer i=0;
  initial begin
    rst=1;
    #30;
    rst=0;
  end
  covergroup c;
    option.per_instance=1;
    coverpoint a iff(!rst);
  endgroup
  initial begin
    c ci=new();
    for(i=0;i<10;i++)
      begin
        a=$urandom();
        ci.sample();
        #10;
      end
  end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #100;
    end
endmodule
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4712 kB (elbread=455 elab2=4120 kernel=135 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# ACDB: Covergroup Coverage data has been saved to "fcover.acdb" database.
# VSIM: Simulation has finished.
Finding VCD file...
./dump.vcd
[2024-11-26 06:47:15 UTC] Opening EPWave...
Done
