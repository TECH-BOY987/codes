module example();
semaphore sem;
initial begin
    sem=new(2);
fork
    process("p1");
    process("p2");
    process("p3");
join_none
end
task process(string name);
$display("[%0t] %s is trying to acquire resource",$time,name);
sem.get(1);
$display("[%0t] %s aquires resources",$time,name);
#10;
$display("[%0t] %s releasing resources",$time,name);
sem.put(1);
endtask
endmodule

Loading snapshot worklib.example:sv .................... Done
xcelium> source /xcelium23.09/tools/xcelium/files/xmsimrc
xcelium> run
[0] p1 is trying to acquire resource
[0] p1 aquires resources
[0] p2 is trying to acquire resource
[0] p2 aquires resources
[0] p3 is trying to acquire resource
[10] p3 releasing resources
[10] p3 releasing resources
[10] p3 aquires resources
[20] p3 releasing resources
