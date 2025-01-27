module example();
semaphore sem;
initial begin
    sem=new(1);
fork
   display();
   display();
join
end
task automatic display();
sem.get();
$display($time,"\taquires resources");
#30;
sem.put();
endtask
endmodule

# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4699 kB (elbread=451 elab2=4112 kernel=135 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL:                    0	aquires resources
# KERNEL:                   30	aquires resources
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
