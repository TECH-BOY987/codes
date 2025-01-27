class transaction;
int data;
endclass:transaction
transaction trans_h1;
transaction trans_h2;
module transaction_tb();
initial
begin
    trans_h1=new();
    trans_h1.data=10;
    $display("the value of handler1:%0d",trans_h1.data);
    trans_h2=new();
    trans_h2.data=20;
    $display("the value of handler2:%0d",trans_h2.data);
    trans_h2=trans_h1;
    trans_h2.data=50;
    $display("the value of handler1:%0d",trans_h1.data);
end
endmodule
