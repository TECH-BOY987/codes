module ex_2;
semaphore sem=new(6);
initial begin:BEGIN_1
$display("in first initial block at time=[%0t]",$time);
sem.get(4);
$display("threads1::acessing 4 keys from semaphore at time=[%0t]",$time);
#5;
sem.put(4);
$display("thread1::done using 4 keys at time=[%0t]",$time);
end
initial begin:BEGIN_2
$display("in first initial block at time=[%0t]",$time);
sem.get(2);
$display("threads1::acessing 4 keys from semaphore at time=[%0t]",$time);
#10;
sem.put(2);
$display("thread1::done using 4 keys at time=[%0t]",$time);
end
endmodule
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4698 kB (elbread=451 elab2=4111 kernel=135 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: in first initial block at time=[0]
# KERNEL: threads1::acessing 4 keys from semaphore at time=[0]
# KERNEL: in first initial block at time=[0]
# KERNEL: threads2::acessing 2 keys from semaphore at time=[0]
# KERNEL: thread1::done using 4 keys at time=[5]
# KERNEL: thread2::done using 2 keys at time=[10]
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
