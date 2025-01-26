class packet;
  rand bit[31:0] a;
  bit[31:0]b;
  constraint bit_randomize{
    a[18:0]==b[18:0];
    a[31:20]==b[31:20];
  }
endclass
module randomize_20th_bit_tb;
  bit[31:0]b;
  packet pkt;
  initial begin
      b = 32'b11011010101011100101101010010101;
    $display("display the value of b:%b",b);
    pkt=new();
    repeat(5) begin
      pkt.b=b;
      if(pkt.randomize()) begin
        $display("display the value of a:%b",pkt.a);
      end
      else
        begin
          $display("randomization failed");
        end
  end
  end
endmodule
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4749 kB (elbread=455 elab2=4151 kernel=142 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: display the value of b:11011010101011100101101010010101
# KERNEL: display the value of a:11011010101001100101101010010101
# KERNEL: display the value of a:11011010101011100101101010010101
# KERNEL: display the value of a:11011010101011100101101010010101
# KERNEL: display the value of a:11011010101001100101101010010101
# KERNEL: display the value of a:11011010101011100101101010010101
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
