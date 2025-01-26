// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
class packet;
  rand bit[6:0] odd;
  rand bit[6:0] even;
  constraint numrange{ odd >=1 && odd<=20 && odd%2==0;
                     even>=1 && even<=20 && even%2==1;
                     }
endclass

module random_range;
   packet pkt=new();
  initial begin
    repeat(6) begin
      pkt.randomize();
      $display("\t odd=%0d and even=%0d",pkt.odd,pkt.even);
    end
  end
endmodule
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4747 kB (elbread=455 elab2=4149 kernel=142 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: 	 odd=8 and even=7
# KERNEL: 	 odd=6 and even=11
# KERNEL: 	 odd=16 and even=5
# KERNEL: 	 odd=4 and even=3
# KERNEL: 	 odd=4 and even=9
# KERNEL: 	 odd=8 and even=5
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
