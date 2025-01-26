module fork_join();
initial  begin
   fork
    task1();
    task2();
    task3();
   join 
   $display($time,"\t all task is completed");
end
initial  begin
   fork
    task1();
    task2();
    task3();
   join_any
   $display($time,"\t at least one task is completed");
end
initial  begin
   fork
    task1();
    task2();
    task3();
   join_none 
   $display($time,"\t there is no need to wait for the task to be completed ");
end
task task1();
#5;
$display("t1 completed");
endtask
task task2();
#2;
$display("t2 completed");
endtask
task task3();
#7;
$display("t3 completed");
endtask
endmodule
