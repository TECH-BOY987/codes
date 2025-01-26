module test;
int array[512];
logic [8:0]addr;
initial begin
    array[511]=5;
    addr=511;
    my_task(array,addr);
end
task my_task(input int array[512],input logic [8:0]addr);
  if(addr>0)begin
      print_int(array[addr]);
    end
    else begin
      $display("Error: Address out of bounds");
    end
endtask
function void print_int(input integer value);
$display("simulation time:%0t,value:%0d",$time,value);
endfunction
endmodule
