class first;
  rand bit[1:0]rst,ce;
  rand bit[3:0]wr_addr,rd_addr;
  constraint data{
  rst dist{0:=80,1:=20};
  ce dist{1:=80,0:=20};
    (rst==1)<->(ce==0);
  }
  constraint d{
    if(rst==1){
      wr_addr inside{[11:15]};
      rd_addr==0;}
      else {
        rd_addr inside{[11:15]};
        wr_addr==0;
           }}
      
endclass
module testbench;
  first f1;
  initial begin
    f1=new();
    repeat(5) begin
      f1.randomize();
      $display("display the value of rst:%0d ce:%0d",f1.rst,f1.ce);
      $display("display the address of wr_addr:%0d and rd_addr:%0d",f1.wr_addr,f1.rd_addr);
      #5;
    end
  end
  endmodule 
  # KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4759 kB (elbread=455 elab2=4159 kernel=144 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: display the value of rst:0 ce:1
# KERNEL: display the address of wr_addr:0 and rd_addr:14
# KERNEL: display the value of rst:0 ce:1
# KERNEL: display the address of wr_addr:0 and rd_addr:12
# KERNEL: display the value of rst:1 ce:0
# KERNEL: display the address of wr_addr:12 and rd_addr:0
# KERNEL: display the value of rst:0 ce:1
# KERNEL: display the address of wr_addr:0 and rd_addr:13
# KERNEL: display the value of rst:0 ce:1
# KERNEL: display the address of wr_addr:0 and rd_addr:12
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
