module events_tb();
event ev_1;
initial begin
fork
begin
    #40;
    $display($time,"\t triggering the event");
    -> ev_1;
end
begin
    $display($time,"\t waiting for the event to trigger");
    #60;
    wait(ev_1);
    $display($time,"\t event triggerd");
end
join
end
initial begin
    #100;
    $display($time,"\t ending the simulation");
    $finish;
end
endmodule
