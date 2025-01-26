// Code your testbench here
// or browse Examples
class packet;
  rand bit[8:0] number;
  constraint num_range{number inside{[135:257]};}
endclass

module random_range;
   packet pkt=new();
  initial begin
    repeat(8) begin
      pkt.randomize();
      $display("\t number=%0d",pkt.number);
    end
  end
endmodule
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4744 kB (elbread=455 elab2=4147 kernel=142 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: 	 number=220
# KERNEL: 	 number=215
# KERNEL: 	 number=181
# KERNEL: 	 number=194
# KERNEL: 	 number=240
# KERNEL: 	 number=234
# KERNEL: 	 number=156
# KERNEL: 	 number=138
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
