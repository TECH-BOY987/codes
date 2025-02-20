`include "uvm_macros.svh"
import uvm_pkg::*;
class test extends uvm_test;
`uvm_component_utils(test)
function new(string path="test",uvm_component parent=null);
super.new(path,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
`uvm_info("test","build phase executed",UVM_NONE);
endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
`uvm_info("test","connect phase executed",UVM_NONE);
endfunction

virtual function void start_of_simulation_phase(uvm_phase phase);
super.start_of_simulation_phase(phase);
`uvm_info("test","start of simulation phase executed",UVM_NONE);
endfunction

virtual task run_phase(uvm_phase phase);
`uvm_info("test","Run phase executed",UVM_NONE);
endtask 

virtual function void extract_phase(uvm_phase phase);
super.extract_phase(phase);
`uvm_info("test","extract phase",UVM_NONE);
endfunction

virtual function void check_phase(uvm_phase phase);
super.check_phase(phase);
`uvm_info("test","check phase",UVM_NONE);
endfunction

virtual function void report_phase(uvm_phase phase);
super.report_phase(phase);
`uvm_info("test","Report phase",UVM_NONE);
endfunction

virtual function void final_phase(uvm_phase phase);
super.final_phase(phase);
`uvm_info("test","Final phase",UVM_NONE);
endfunction
endclass

module tb;
initial begin
run_test("test");
end
endmodule