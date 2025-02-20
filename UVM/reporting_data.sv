// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;
module tb;
  int data=235;
  initial begin
    `uvm_info("TB_TOP",$sformatf("value of data:%h",data),UVM_NONE);
  end
endmodule