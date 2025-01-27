class first;
int data;
endclass
module tb;
first f1;
first f2;
initial begin
    f1=new();
    f1.data=20;
    f2=new f1;
    f2.data=30;
    $display("display the value of:%0d",f1.data);
    f1.data=50;
    $display("display the value of:%0d",f1.data);
    $display("display the value of:%0d",f2.data);
end
endmodule
