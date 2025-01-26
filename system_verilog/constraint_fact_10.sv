// class packet;
// randc logic [31:0] factorial;
// constraint range{factorial inside{1,1,2,6,24,120,720,5040,40320,362880};}
// endclass
// module random_range;
// packet pkt=new();
//   initial begin
//     repeat(8) begin
//       pkt.randomize();
//       $display("\t factorial number=%0d",pkt.factorial);
//     end
//   end
// endmodule
class packet;
randc int fact;
  constraint  num{fact>=0 && fact<=10 && fact;}
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
    $display("display the factorial of %0d that is %0d",pkt.fact,result);
  end
  end
endmodule
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4749 kB (elbread=455 elab2=4151 kernel=142 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: display the factorial of 7 that is 5040
# KERNEL: display the factorial of 10 that is 3628800
# KERNEL: display the factorial of 4 that is 24
# KERNEL: display the factorial of 8 that is 40320
# KERNEL: display the factorial of 6 that is 720
# KERNEL: display the factorial of 2 that is 2
# KERNEL: display the factorial of 3 that is 6
# KERNEL: display the factorial of 9 that is 362880
# KERNEL: display the factorial of 5 that is 120
# KERNEL: display the factorial of 1 that is 1
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
