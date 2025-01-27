class generator;
  randc bit[3:0]a,b;
  bit[3:0]y;
endclass
module tb;
  generator g;
  int i=0;
  initial begin
    g=new();
    for(i=0;i<10;i=i+1)
      begin
    g.randomize();
        $display("the value of a:%0d and b:%0d",g.a,g.b);
        #10;
  end
  end
endmodule
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4736 kB (elbread=455 elab2=4139 kernel=141 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: the value of a:1 and b:8
# KERNEL: the value of a:15 and b:5
# KERNEL: the value of a:3 and b:0
# KERNEL: the value of a:0 and b:15
# KERNEL: the value of a:13 and b:13
# KERNEL: the value of a:7 and b:2
# KERNEL: the value of a:9 and b:9
# KERNEL: the value of a:5 and b:10
# KERNEL: the value of a:12 and b:11
# KERNEL: the value of a:8 and b:6
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
