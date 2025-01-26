class first;
  rand bit[1:0]rst,ce;
  constraint data{
  rst dist{0:=80,1:=20};
  ce dist{1:=80,0:=20};
  (rst==1)->(ce==0);
  }
endclass
module testbench;
  first f1;
  initial begin
    f1=new();
    repeat(5) begin
      f1.randomize();
      $display("display the value of rst:%0d ce:%0d",f1.rst,f1.ce);
    end
  end
  endmodule 
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4748 kB (elbread=455 elab2=4150 kernel=142 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: display the value of rst:0 ce:0
# KERNEL: display the value of rst:1 ce:0
# KERNEL: display the value of rst:0 ce:1
# KERNEL: display the value of rst:0 ce:1
# KERNEL: display the value of rst:0 ce:0
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
