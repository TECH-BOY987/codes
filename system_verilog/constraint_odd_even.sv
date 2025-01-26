// Code your testbench here
// or browse Examples
class packet;
rand bit[7:0] num;          
constraint numrange{ odd >=20 && odd<=100 && odd%2==1;
                     even>=20 && even<=100 && even%2==0;
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
# KERNEL: 	 odd=51 and even=54
# KERNEL: 	 odd=43 and even=68
# KERNEL: 	 odd=99 and even=26
# KERNEL: 	 odd=27 and even=38
# KERNEL: 	 odd=65 and even=80
# KERNEL: 	 odd=35 and even=40
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
