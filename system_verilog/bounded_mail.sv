module mail_box();
  mailbox mb=new(3);
  task process_A();
    int value=5;
    string name="string";
    mb.put(value);
    $display("put data=%0d",value);
    mb.put("string");//or name
    $display("put data=%s",name);
  endtask
    task process_B();
    int value;
    string name;
    mb.get(value);
      $display("get data=%0d",value);
      mb.get(name);
      $display("get data=%s",name);
  endtask
  initial begin
    fork
      process_A();
      process_B();
    join
  end
endmodule
  
# KERNEL: Kernel process initialization done.
# Allocation: Simulator allocated 4705 kB (elbread=451 elab2=4118 kernel=136 sdf=0)
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: put data=5
# KERNEL: put data=string
# KERNEL: get data=5
# KERNEL: get data=string
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
