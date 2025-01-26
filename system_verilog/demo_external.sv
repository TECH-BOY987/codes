// Code your testbench here
// or browse Examples
class packet;
  bit [31:0]addr=10;
  bit [31:0]data=20;
extern function void display();
endclass
function void packet::display();
  $display("address:%0d,data:%0d",addr,data);
endfunction
class packet2 extends packet;
int temp=30;
function  void add();
$display("display addition:%0d",temp+4);
endfunction
extern function void display();
endclass
  function void packet2::display();
    $display("address2:%0d,data2:%0d",addr,data);
endfunction
  module extern_methord;
    initial begin
      packet pkt;
      packet2 pkt2;
      pkt=new();
      pkt2=new();
      pkt=pkt2;
      pkt2.display();
      pkt.display();
      pkt2.add();
    end
  endmodule
  
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4747 kB (elbread=455 elab2=4148 kernel=144 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: address2:10,data2:20
# KERNEL: address:10,data:20
# KERNEL: display addition:34
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
