class generator;
rand bit[3:0]a,b;
bit[3:0]y;
function void prerandomize();
$display("inside prerandomize:initialize y to 15");
y=4'b1111;
endfunction
function void postrandom();
$display("inside postrand:ensuring b is less than 8");
if(b>=8) begin
    b=b%8;
end
endfunction
endclass
module testbench;
generator g;
int i=0;
initial begin
    g=new();
    for(i=0;i<5;i=i+1) begin
        if(g.randomize()) begin
            $display("value of a:%0d,b:%0d,y:%0d",g.a,g.b,g.y);
        end else begin
            $display("randomizatioon failed at the iteration %0d",i);
        end
        #10;
    end
end
endmodule
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4735 kB (elbread=455 elab2=4138 kernel=141 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: value of a:4,b:8,y:0
# KERNEL: value of a:3,b:11,y:0
# KERNEL: value of a:6,b:11,y:0
# KERNEL: value of a:8,b:15,y:0
# KERNEL: value of a:5,b:5,y:0
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
