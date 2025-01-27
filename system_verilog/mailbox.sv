//packet
class packet;
rand bit[7:0]addr;
rand bit[7:0]data;
function void post_randomize();
$dispaly("packet::packet generated");
$display("packet::addr=%0d and data=%0d",addr,data);
endfunction
endclass

//generator
class generator;
packet pkt;
mailbox m_box;
    function new(mailbox m_box);
        this.m_box=m_box;
    endfunction //new()
    task run;
    repeat(2) begin
        pkt=new();
        pkt.randomize();
        m_box.put(pkt);
        $display("generator pkt put into mailbox");
        #5;
    end
    endtask
endclass //generator

//driver
class driver;
packet pkt;
mailbox m_box;
function new(mailbox m_box);
this.m_box=m_box;
endfunction
task run;
repeat(2) begin
    pkt=new();
    pkt.randomize();
    m_box.get(pkt);
    $display("driver into mail");
    $display("driver::addr=%0d,data=%0d",pkt.addr,pkt.data);
end
endtask
endclass
//testbench

`include "packet.sv"
`include "generator.sv"
`include "driver.sv"
module testbench;
mailbox m_box;
generator gen;
driver dri;
initial begin
    m_box=new();
    gen=new(m_box);
    dri=new(m_box);
    $display("................");
    fork
        gen.run();
        dri.run();
    join
    $dispaly(".................");
end
endmodule
# KERNEL: Warning: Contact Aldec for available upgrade options - sales@aldec.com.
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4786 kB (elbread=459 elab2=4177 kernel=149 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: ................
# KERNEL: packet::addr=0 and data=183
# KERNEL: generator:: pkt put into mailbox
# KERNEL: packet::addr=2 and data=1
# KERNEL: driver into mail
# KERNEL: driver::addr=0,data=183
# KERNEL: 
# KERNEL: packet::addr=48 and data=233
# KERNEL: packet::addr=90 and data=11
# KERNEL: generator:: pkt put into mailbox
# KERNEL: driver into mail
# KERNEL: driver::addr=90,data=11
# KERNEL: 
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
