// class packet;
// randc logic[31:0]factorial;
//constraint numbers{}
// constraint num_even{factorial inside {2,24,720,40320,3628800};}
// endclass
// module random_range_tb;
//    packet pkt=new();
//   initial begin
//     repeat(8) begin
//       pkt.randomize();
//       pkt.randomize() with{2,4,6,8,10}
//       $display("\t even factorial number=%0d",pkt.factorial);
//     end
//   end
// endmodule
class packet;
randc int fact;
  constraint  num{fact>=1 && fact<=10 && fact%2==0;}
function int factorial(int num);
      if(num==0)
        return 1;
      else
        return num*factorial(num-1);
endfunction
endclass
module tb;
  int result;
  packet pkt=new();
  initial begin
    repeat(10) begin
    pkt.randomize();
    result=pkt.factorial(pkt.fact);
    $display("display the factorial even number  %0d that is %0d",pkt.fact,result);
  end
  end
endmodule

# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4750 kB (elbread=455 elab2=4151 kernel=142 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: display the factorial even number  6 that is 720
# KERNEL: display the factorial even number  4 that is 24
# KERNEL: display the factorial even number  2 that is 2
# KERNEL: display the factorial even number  8 that is 40320
# KERNEL: display the factorial even number  10 that is 3628800
# KERNEL: display the factorial even number  8 that is 40320
# KERNEL: display the factorial even number  4 that is 24
# KERNEL: display the factorial even number  2 that is 2
# KERNEL: display the factorial even number  10 that is 3628800
# KERNEL: display the factorial even number  6 that is 720
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
