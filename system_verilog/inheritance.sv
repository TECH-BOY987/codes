class first;
int data=12;
function void print();
        $display("generator: %0d",data);
    endfunction
endclass
class second extends first;
int temp=34;
function void add();
$display("the value by adding:%0d",temp+4);
endfunction
endclass
module test;
    second s;
    initial begin
        s=new();
        $display("value of data:%0d",s.data);
        s.print();
        $display("value of temp:%0d",s.temp);
        s.add();
    end
endmodule
