class packet #(parameter int ADD_WIDTH=32,DATA_WIDTH=12)
bit[ADD_WIDTH-1:0]address;
bit[DATA_WIDTH-1:0]data;
function new();
address=10;
data=20;
endfunction
function void display();
$display("display the value of address:%0d and data:%0d",address,data);
endfunction
endclass
module test_bench;
initial begin
    packet #(32,12) pkt_custom=new();
    pkt_custom.display();
end
endmodule
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4732 kB (elbread=455 elab2=4134 kernel=142 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: display the value of add:12 and data:20
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
