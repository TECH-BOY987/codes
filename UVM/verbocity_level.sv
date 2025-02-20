`include "uvm_macros.svh"
import uvm_pkg::*;
module tb;
  int verbosity=0;
  initial begin    uvm_top.set_report_verbosity_level(UVM_HIGH);
    `uvm_info("TB_TOP","This is information message",UVM_HIGH);
  end
endmodule