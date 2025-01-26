task packet;
input a,c,clk;
initial begin
    a=0;
    c=1;
    clk=1;
    forever begin
        clk=clk;
        #10;
    end
end
initial begin
    #10; a=1;
    c=0;
    @(posedge clk)
    #2;a=#5 c;
    c=#3 c;
end
initial
begin
    #70;
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    a=1'hx;
    @(negedge clk)
    c=1'hx;
end
initial
begin
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    a=;
    @(negedge clk)
    c=0;
end
endtask
initial begin
    packet;
end
endmodule
