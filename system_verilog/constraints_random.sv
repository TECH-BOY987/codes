class packet;
rand bit[3:0]addr;
rand bit[3:0]start_addr;
rand bit[3:0]end_addr;
constraint addr_range{addr inside{1,3,5,7,9};}
endclass
module constr_inside;
initial begin
    packet pkt;
    pkt=new();
    $display("........................");
    repeat(3) begin
        pkt.randomize();
        $display("\t start_addr=%0d and end_addr=%0d",pkt.start_addr,pkt.end_addr);
        $display("\t addr=%0d",pkt.addr);
        $display(".....................");
    end
end
endmodule
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4747 kB (elbread=455 elab2=4149 kernel=142 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: ........................
# KERNEL: 	 start_addr=5 and end_addr=11
# KERNEL: 	 addr=1
# KERNEL: .....................
# KERNEL: 	 start_addr=14 and end_addr=2
# KERNEL: 	 addr=5
# KERNEL: .....................
# KERNEL: 	 start_addr=5 and end_addr=6
# KERNEL: 	 addr=7
# KERNEL: .....................
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
