class parent;
int f1=2;
virtual function void display();
$display("first value of data:%0d",f1);
endfunction
endclass
class child extends parent;
int temp=30;
function  void add();
$display("display addition:%0d",temp+4);
endfunction
function void display();
$display("first value of data:%0d",f1);
endfunction
endclass
module tb;
parent p;
child c;
initial begin
    p=new();
    c=new();
    p=c;
    p.display();
end
endmodule
