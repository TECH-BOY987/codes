class first;
int data=12;
endclass
class second;
first f;
int ds=1;
function new();
f=new();
endfunction
endclass
module shallow_copy();
second s1,s2;
initial begin
    s1=new();
    s1.ds=10;
    s2=new s1;
    $display("value of data s2:%0d",s2.ds);
    s2.ds=40;
    $display("value of data s1:%0d",s1.ds);
    s2.f.data=20;
$display("value of data s1_ds:%0d,s1_f1_data:%0d",s1.ds,s1.f.data);
end
endmodule
