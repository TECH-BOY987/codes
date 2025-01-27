class packet;
  rand bit[4:0]a[10];
  int i=0;
    constraint b{
            foreach (a[i]) {
                  (a[i] + a[i+1] + a[i+2])%2==0;
                }
        }
endclass
module testbench;
  packet pkt;
initial begin
pkt=new();
  repeat(2) begin
  pkt.randomize();
    $display("the value of the consecutive sum is even:%0p",pkt.a);
    #5;
  end
end
endmodule
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4748 kB (elbread=455 elab2=4150 kernel=142 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: the value of the consecutive sum is even:4 8 2 26 22 26 24 14 20 4
# KERNEL: the value of the consecutive sum is even:0 18 14 16 6 30 6 18 22 26
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
