class first;
int data=10;
function new(input int data);
this.data=data;
endfunction
endclass
class second extends first;
int temp=20;
function new(int data,int temp);
super.new(data);
this.temp=temp;
endfunction
endclass
module tb;
second s;
initial begin
    s=new(67,45);
    $display("value of data:%0d and temp:%0d",s.data,s.temp);
end
endmodule                                     
