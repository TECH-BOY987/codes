// Code your testbench here
// or browse Examples
class add;
  bit [3:0] a;
  bit [3:0]b;
  bit [4:0] c;
  function new(bit [3:0] a,bit [3:0] b);
    this.a=a;
    this.b=b;
    this.c=a+b;
  endfunction
endclass

class mul extends add;
  bit [3:0] p;
  bit [3:0] q;
  bit [7:0] r;
  function new(bit [3:0] p,bit [3:0] q);
    super.new(p,q);
    this.r=p*q;
  endfunction
endclass

module tb;
  mul t;
  int a,m;
  initial begin
    t=new(4'b0001,4'b0010);
    a=t.c;
    m=t.r;
    $display("add:%0d and mul:%0d",a,m);
  end
endmodule