module tb;
  reg[3:0]a;
  integer i=0;
  covergroup c;
    option.per_instance=1;
    coverpoint a{
      bins zero={0};
      bins odd_a=a with((item>0)&&(item%2==1));
      bins even_a=a with((item>0)&&(item%2==0));
      bins muls=a with((item>0)&&(item%3)==0);
    }
  endgroup
  c ci=new();
  initial begin
    for(i=0;i<20;i++) begin
      a=$urandom();
      $display("value of a:%0d",a);
      ci.sample();
      #10;
    end
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #200;
    $finish();
  end
endmodule
