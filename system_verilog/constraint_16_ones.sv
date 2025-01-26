class packet;
  randc bit[31:0] number;
  constraint range{$countones(number)==16;
                   foreach(number[i]) {
                     if(i<31) number[i]+ number[i+1]<=1;}}
endclass
module random_range;
  packet pkt=new();
  initial begin
    repeat(6) begin
     pkt.randomize();
    $display("number=%b",pkt.number);
  end
  end
 endmodule
 # KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4751 kB (elbread=455 elab2=4153 kernel=142 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: number=10101010010101010101010101010101
# KERNEL: number=10101010101010101010101010101001
# KERNEL: number=10101010101010101010101010101010
# KERNEL: number=10101010101010101010101010100101
# KERNEL: number=10101010101010101010101010010101
# KERNEL: number=10101010101010101010101001010101
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
