class first;
rand bit[1:0] var1,var2;
constraint data{
var1 dist{0:=30,[1:3]:=90};
var2 dist{0:/30,[1:3]:/90};
}
endclass
module testbench;
first f1;
initial begin
    f1=new();
for(int i=0;i<6;i=i+1)
begin
    f1.randomize();
    $display("the value of var1(:=):%0d and var2(:/):%0d",f1.var1,f1.var2);
end
end
endmodule
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4748 kB (elbread=455 elab2=4150 kernel=142 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: the value of var1(:=):0 and var2(:/):3
# KERNEL: the value of var1(:=):3 and var2(:/):3
# KERNEL: the value of var1(:=):2 and var2(:/):2
# KERNEL: the value of var1(:=):2 and var2(:/):3
# KERNEL: the value of var1(:=):2 and var2(:/):2
# KERNEL: the value of var1(:=):3 and var2(:/):2
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
