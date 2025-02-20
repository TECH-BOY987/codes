`include "uvm_macros.svh"
import uvm_pkg::*;
class transaction extends uvm_sequence_item;
rand bit [3:0] data;
function new(string inst="transaction");
super.new(inst);
endfunction

`uvm_object_utils_begin(transaction)
`uvm_field_int(data,UVM_DEFAULT|UVM_DEC)
`uvm_object_utils_end
endclass

module tb;
transaction trans;
initial begin
    trans=new("t");
    trans.randomize();
    trans.print(uvm_default_line_printer);
end
endmodule