module datatypes;
logic[7:0]a,b;
logic[7:0]c,d;
string e,g;
bit[31:0]f=128;
typedef struct packed {
    int RED;
    int GREEN;
    int YELLOW;}traffic;
typedef struct{
    int RED;
    int GREEN;
    int YELLOW;
    string ROAD;}traffic_l;
    typedef union packed{int i;
    int s;}something;
    class printer;
    function void log(string msg);
    $display(msg);
    endfunction
    function void error(string msg);
    $display(msg);
    endfunction
    endclass
    traffic t1;
    traffic_l t2;
    something s1;
    printer p1;
    initial begin
        a=2;b=4;
        c=a+b;
        d=c-b;
        g="hello";
        t1.RED=111;
        t1.GREEN=222;
        t1.YELLOW=333;
        t2.RED=111;
        t2.GREEN=222;
        t2.YELLOW=333;
        t2.ROAD="120";
        s1.i=0;
        e=$sformatf("%0d",f);
        $display("a=%0d b=%0d c=%0d d=%0d e=%0s f=0x%0h",a,b,c,d,e,f);
        $display("len:%0d",e.len());
    end
endmodule
