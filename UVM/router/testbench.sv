`include "uvm_macros.svh"
import uvm_pkg::*;

// Interface
interface router_if(input bit clk,input logic rst);
    logic [7:0] d_in;
  logic  pkt_valid, rd_en_0, rd_en_1, rd_en_2;
  logic vld_out_0, vld_out_1, vld_out_2, err, busy;
  logic [7:0] dout_0, dout_1, dout_2;
endinterface

// Transaction Class
class transaction extends uvm_sequence_item;
  rand logic [7:0] d_in;
  rand logic pkt_valid;
  logic  rd_en_0=1, rd_en_1=1, rd_en_2=1;
  logic vld_out_0, vld_out_1, vld_out_2, err, busy;
  logic [7:0] dout_0, dout_1, dout_2;
  
 `uvm_object_utils_begin(transaction)
        `uvm_field_int(d_in, UVM_DEFAULT);
        `uvm_field_int(pkt_valid, UVM_DEFAULT);
        `uvm_field_int(rd_en_0, UVM_DEFAULT);
        `uvm_field_int(rd_en_1, UVM_DEFAULT);
        `uvm_field_int(rd_en_2, UVM_DEFAULT);
        `uvm_field_int(vld_out_0, UVM_DEFAULT);
        `uvm_field_int(vld_out_1, UVM_DEFAULT);
        `uvm_field_int(vld_out_2, UVM_DEFAULT);
        `uvm_field_int(err, UVM_DEFAULT);
        `uvm_field_int(busy, UVM_DEFAULT);
        `uvm_field_int(dout_0, UVM_DEFAULT);
        `uvm_field_int(dout_1, UVM_DEFAULT);
        `uvm_field_int(dout_2, UVM_DEFAULT);
    `uvm_object_utils_end
  
  function new(string name = "router_transaction");
    super.new(name);
  endfunction
endclass

// Sequence
class router_sequence extends uvm_sequence#(transaction);
  transaction tx;
  `uvm_object_utils(router_sequence)
  
  function new(string name = "router_sequence");
    super.new(name);
  endfunction

  virtual task body();
    repeat (20) begin
      tx = transaction::type_id::create("tx");
      start_item(tx);
      assert(tx.randomize());
      finish_item(tx);
    end
  endtask
endclass

// Driver
class router_driver extends uvm_driver #(transaction);
  `uvm_component_utils(router_driver)
  virtual router_if vif;
  transaction tx;
    int addr=0;
    function new(string name="DRIVER", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tx=transaction::type_id::create("tx",this);
    if(!uvm_config_db#(virtual router_if)::get(this, "", "vif", vif))
      `uvm_error("ROUTER_DRIVER", "Virtual interface not set")
  endfunction
  
  task run_phase(uvm_phase phase);
    int count=0;@(negedge vif.clk);
    vif.pkt_valid=1;
    forever begin
      @(negedge vif.clk);
      wait(vif.busy==0);
      @(negedge vif.clk);
      seq_item_port.get_next_item(tx);
      vif.d_in = tx.d_in;
      vif.rd_en_0 = tx.rd_en_0;
      vif.rd_en_1 = tx.rd_en_1;
      vif.rd_en_2 = tx.rd_en_2;
      seq_item_port.item_done();
      count=count+1;
    end
  endtask
endclass

// Monitor
class router_monitor extends uvm_monitor;
  `uvm_component_utils(router_monitor)
  virtual router_if vif;
  transaction tx;
  uvm_analysis_port #(transaction) mon_ap;
  
  function new(string name="MONITOR", uvm_component parent=null);
    super.new(name, parent);
    mon_ap = new("mon_ap", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tx=transaction::type_id::create("tx");
    if(!uvm_config_db#(virtual router_if)::get(this," ", "vif", vif))
      `uvm_error("ROUTER_MONITOR", "Virtual interface not set")
  endfunction
  
  task run_phase(uvm_phase phase);
    forever begin
      @(negedge vif.clk);
      #1;
      tx.vld_out_0 = vif.vld_out_0;
      tx.vld_out_1 = vif.vld_out_1;
      tx.vld_out_2 = vif.vld_out_2;
      tx.err = vif.err;
      tx.busy = vif.busy;
      tx.dout_0 = vif.dout_0;
      tx.dout_1 = vif.dout_1;
      tx.dout_2 = vif.dout_2;
      `uvm_info("MONITOR",$sformatf("received o/p:dout_0=%0h,dout_1=%0h, dout_2=%0h", tx.dout_0, tx.dout_1, tx.dout_2), UVM_NONE);
      mon_ap.write(tx);
    end
  endtask
endclass

// Agent
class router_agent extends uvm_agent;
  `uvm_component_utils(router_agent)
  uvm_sequencer #(transaction) sequencer;
  router_driver driver;
  router_monitor monitor;
  
  function new(string name="AGENT", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = uvm_sequencer #(transaction)::type_id::create("sequencer", this);
    driver = router_driver::type_id::create("driver", this);
    monitor = router_monitor::type_id::create("monitor", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction
endclass

//Scoreboard
class router_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(router_scoreboard)
transaction tx;
  uvm_analysis_imp #(transaction, router_scoreboard) mon_imp;
  function new(string name="SCOREBOARD", uvm_component parent=null);
    super.new(name, parent);
mon_imp=new("mon_ap",this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
tx=transaction::type_id::create("trans",this);
  endfunction
  virtual function void write(input transaction t);
tx=t;
`uvm_info("SCOREBOARD",$sformatf("received o/p:dout_0=%0h,dout_1=%0h,dout_2=%0h",tx.dout_0,tx.dout_1,tx.dout_2),UVM_MEDIUM)
  endfunction
endclass

// Environment
class router_env extends uvm_env;
  `uvm_component_utils(router_env)
  router_agent agent;
  router_scoreboard sb;
  
  function new(string name="ENVIRONMENT", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = router_agent::type_id::create("agent", this);
    sb = router_scoreboard::type_id::create("sb", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor.mon_ap.connect(sb.mon_imp);
  endfunction
endclass

// Test
class router_test extends uvm_test;
  `uvm_component_utils(router_test)
  router_env env;
  router_sequence seq;
  
  function new(string name="TEST", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = router_env::type_id::create("env", this);
    seq = router_sequence::type_id::create("seq");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
//     router_sequence seq = router_sequence::type_id::create("seq");
    phase.raise_objection(this);
    seq.start(env.agent.sequencer);
    #100;
    phase.drop_objection(this);
  endtask
endclass
                                    
module tb_top;
  logic clk=0;
  logic rst;
  
  always #5 clk=~clk;
  
  router_if tb_if(clk,rst);
  
  router_topmodule dut(tb_if.clk,tb_if.rst,tb_if.d_in,tb_if.pkt_valid,tb_if.rd_en_0,tb_if.rd_en_1,tb_if.rd_en_2,tb_if.vld_out_0,tb_if.vld_out_1,tb_if.vld_out_2,tb_if.err,tb_if.busy,tb_if.dout_0,tb_if.dout_1,tb_if.dout_2);
  
  initial begin
    uvm_config_db#(virtual router_if)::set(null,"uvm_test_top.env.agent*","vif",tb_if);
    run_test("router_test");
  end
  initial begin
    rst=0;
    #10 rst=1;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #1000;
    $finish;
  end
endmodule