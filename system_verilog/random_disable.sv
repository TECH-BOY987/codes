class generator;
  rand bit[3:0]a,b;
  bit[3:0]y;
endclass
module tb;
  generator g;
  int i=0;
  initial begin
    g=new();
    g.a.rand_mode(0);
    for(i=0;i<10;i=i+1)
      begin
    g.randomize();
        $display("the value of a:%0d and b:%0d",g.a,g.b);
        #10;
  end
  end
endmodule
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4736 kB (elbread=455 elab2=4140 kernel=141 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: the value of a:0 and b:1
# KERNEL: the value of a:0 and b:15
# KERNEL: the value of a:0 and b:3
# KERNEL: the value of a:0 and b:0
# KERNEL: the value of a:0 and b:13
# KERNEL: the value of a:0 and b:7
# KERNEL: the value of a:0 and b:9
# KERNEL: the value of a:0 and b:5
# KERNEL: the value of a:0 and b:12
# KERNEL: the value of a:0 and b:8
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
