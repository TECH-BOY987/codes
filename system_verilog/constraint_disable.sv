class my_class;
rand int a,b;
constraint a_constraint{a>5;}
constraint b_constraint{b<10;}
function void disable_a_constraint();
a_constraint.constraint_mode(0);
endfunction
function void enable_a_constraint();
a_constraint.constraint_mode(1);
endfunction
endclass

module testbench;
initial begin
    my_class obj=new();
    obj.disable_a_constraint();
    if(obj.randomize()) begin
        $display("randomization sucessful");
    end
    else begin
        $display("randomization failed");
    end
end
endmodule
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4751 kB (elbread=455 elab2=4152 kernel=144 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: randomization sucessful
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
