
class packet;
bit [31:0]addr;
  bit [31:0]data;
// extern function void display();
extern task display();
endclass
// function void packet::display();
//   $display("address:%0d,data:%0d",addr,data);
// endfunction
task packet::display();
$display("addr=%0d and data=%0d",addr,data);
endtask
  module extern_methord;
    initial begin
      packet pkt;
      pkt=new();
      pkt.addr=10;
      pkt.data=20;
      pkt.display();
    end
  endmodule

# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4734 kB (elbread=459 elab2=4134 kernel=140 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: addr=10 and data=20
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
