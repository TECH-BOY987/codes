
`include "uvm_macros.svh"
import uvm_pkg::*;

interface intf(input logic clk,input logic rst);
  logic [7:0] d_in; 
  logic pkt_valid;
  logic rd_en_0,rd_en_1,rd_en_2;
  logic vld_out_0,vld_out_1,vld_out_2;
  logic err;
  logic busy;
  logic [7:0] dout_0,dout_1,dout_2;
endinterface

class transaction extends uvm_sequence_item;
  rand bit [7:0] d_in; 
    bit pkt_valid;
    rand bit rd_en_0=1,rd_en_1=1,rd_en_2=1;
    
    logic vld_out_0,vld_out_1,vld_out_2; 
    logic err, busy; 
  logic [7:0] dout_0,dout_1,dout_2;

  function  new(string obj="transaction");
    super.new(obj);
  endfunction
  
  rand bit[7:0] header;
  rand bit[7:0] payload[];
  logic [7:0] parity=0;
  
  constraint header_con{header[1:0] inside {2'b00,2'b01,2'b10};}
 constraint payload_con{payload.size()==header[7:2] && header[7:0]!=0;}
  
       `uvm_object_utils_begin(transaction)
        `uvm_field_int(d_in, UVM_DEFAULT);
        `uvm_field_int(header, UVM_DEFAULT);
        `uvm_field_int(parity, UVM_DEFAULT);
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
  
endclass

class sequences extends uvm_sequence#(transaction);
  `uvm_object_utils(sequences)

  function  new(string obj="sequences");
    super.new(obj);
  endfunction
  
  task body();
     transaction t;
    int payload_len;
    byte unsigned payload_data[$];
    byte unsigned parity;
    
    repeat(5) begin
      t=transaction::type_id::create("t");
      
      payload_len=$urandom_range(1,5);
      t.header={payload_len[5:0],$urandom_range(0,2)};
      parity=t.header;
      
      start_item(t);
      t.d_in=t.header;
      t.pkt_valid=1;
      finish_item(t);
      
      for(int i=0;i<payload_len;i++) begin
        start_item(t);
        t.d_in=$urandom_range(0,50);
        t.pkt_valid=1;
        finish_item(t);
        parity^=t.d_in;
      end
      
      start_item(t);
      t.d_in=parity;
      t.pkt_valid=0;
      finish_item(t);
    end
  endtask
endclass

class driver extends uvm_driver#(transaction);
  `uvm_component_utils(driver)
    virtual intf vif;
     int count=0;
      transaction t;
  
  function new(string comp="driver",uvm_component parent=null);
    super.new(comp,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual intf)::get(this,"","vif",vif))
      `uvm_fatal("DRV","virtual interface not set")
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    vif.pkt_valid<=0;
    vif.d_in<=0;
    vif.rd_en_0<=0;
    vif.rd_en_1<=0;
    vif.rd_en_2<=0;
        forever begin
            seq_item_port.get_next_item(t);
          @(negedge vif.clk);
            vif.pkt_valid = t.pkt_valid;
            vif.d_in = t.d_in;
            vif.rd_en_0 = t.rd_en_0;
            vif.rd_en_1 = t.rd_en_1;
            vif.rd_en_2 = t.rd_en_2;
            seq_item_port.item_done();
          
            
            count = count + 1;
    end
  endtask
endclass

class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  
  virtual intf vif;
  transaction t;
  uvm_analysis_port #(transaction) wr_port;
  
   function  new(string comp="monitor",uvm_component parent);
    super.new(comp,parent);
     wr_port=new("wr_port",this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    t=transaction::type_id::create("t",this);
    if(!uvm_config_db#(virtual intf)::get(this,"","vif",vif))
      `uvm_fatal("MON","virtual interface not set")
  endfunction
  
  task run_phase(uvm_phase phase);
    forever begin
      @(negedge vif.clk);
      t.d_in=vif.d_in;
      t.dout_0=vif.dout_0;
      t.dout_1=vif.dout_1;
      t.dout_2=vif.dout_2;
      t.vld_out_0=vif.vld_out_0;
      t.vld_out_1=vif.vld_out_1;
      t.vld_out_2=vif.vld_out_2;
      t.err=vif.err;
      t.busy=vif.busy;
      
      wr_port.write(t);
    end
  endtask
endclass


class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  int in_stream[$],out_stream[$];
  bit [7:0] header=0;
  int parity=0;
  int prev_d_in=0,prev_d_out=0;
  
  uvm_analysis_imp#(transaction,scoreboard) wr_fifo;
  
  transaction t;
  
  function new(string comp="sco",uvm_component parent);
    super.new(comp,parent);
    wr_fifo=new("wr_port",this);
  endfunction
  
  
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
      wr_fifo=new("wr_fifo",this);
       t = transaction::type_id::create("t", this);
    endfunction
  
  virtual function void write(input transaction trans);
        t = trans;
        check_data(t);
    endfunction
  
  
  function void check_data(transaction t);
    if(t.d_in != prev_d_in) begin
      in_stream.push_back(t.d_in);
            prev_d_in = t.d_in;
      if(in_stream.size() == 2) 
              header = t.d_in;
        end
    
    if(t.rd_en_0 && t.vld_out_0 && t.dout_0 != 8'b0) 
      begin
      out_stream.push_back(t.dout_0);
      if(out_stream.size() == header[7:2] + 1) 
              checkParity();
        end
    else if(t.rd_en_1 && t.vld_out_1 && t.dout_1 != 8'b0)
      begin
      out_stream.push_back(t.dout_1);
      if(out_stream.size() == header[7:2] + 1) 
              checkParity();
        end
    else if(t.rd_en_2 && t.vld_out_2 && t.dout_2 != 8'b0) 
      begin
      out_stream.push_back(t.dout_2);
      if(out_stream.size() == header[7:2] + 1) 
              checkParity();
        end
    endfunction
  
function void checkParity();
  int parity=0;
        foreach(out_stream[i]) begin
            parity ^= out_stream[i];
        end
  if(parity != in_stream[$]) begin
            `uvm_info("SCOREBOARD", "Successfully verified Router 1x3", UVM_LOW);
    `uvm_info("SCOREBOARD", $sformatf("/* Input:  %0p", in_stream), UVM_LOW);
    `uvm_info("SCOREBOARD", $sformatf("/* Output: %0p", out_stream), UVM_LOW);
        end
        else begin
          `uvm_error("scoreboard","Received corrupted data");
        end
  in_stream.delete();
  out_stream.delete();
        
    endfunction
  
endclass

class agent extends uvm_agent;
  `uvm_component_utils(agent)
  
  function new(string comp="agent",uvm_component parent=null);
    super.new(comp,parent);
  endfunction
  
  uvm_sequencer #(transaction) sqr;
  driver driv;
  monitor mon;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sqr=uvm_sequencer#(transaction)::type_id::create("sqr",this);
    driv=driver::type_id::create("driv",this);
    mon=monitor::type_id::create("mon",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driv.seq_item_port.connect(sqr.seq_item_export);
  endfunction
endclass

class environment extends uvm_env;
 `uvm_component_utils(environment)
  agent agt;
  scoreboard sco;
  
  function  new(string comp="env",uvm_component parent=null);
    super.new(comp,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    agt= agent::type_id::create("agt",this);
    sco=scoreboard::type_id::create("sco",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agt.mon.wr_port.connect(sco.wr_fifo);    
  endfunction
endclass
  
class test_1 extends uvm_test;
    `uvm_component_utils(test_1)
  
      sequences seq;
  environment env;
  
  function  new(string name="seq",uvm_component parent=null);
    super.new(name,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
        env = environment::type_id::create("env", this);
        seq = sequences::type_id::create("seq");
    endfunction  

 task run_phase(uvm_phase phase);
	$display("-------------TEST RUN PHASE--------------------------------------");
	phase.raise_objection(this);
   seq.start(env.agt.sqr);
   #50;
   phase.drop_objection(this);
 endtask
endclass

module tb();
  logic clk=1;
  logic rst;
  intf vif_top(clk,rst);
  router dut(vif_top.clk,vif_top.rst,vif_top.d_in,vif_top.pkt_valid,vif_top.rd_en_0,vif_top.rd_en_1,vif_top.rd_en_2,vif_top.vld_out_0,vif_top.vld_out_1,vif_top.vld_out_2,vif_top.err,vif_top.busy,vif_top.dout_0,vif_top.dout_1,vif_top.dout_2);
always #10 clk=~clk;

initial begin
  uvm_config_db #(virtual intf)::set(null,"uvm_test_top.env.agt*","vif",vif_top);
  run_test("test_1");
end
  initial begin 
    rst=0;
    repeat(2) @(posedge clk);
    rst=1;
  end
initial begin
  $dumpfile("dump.vcd");
  $dumpvars(0, tb); 
  $dumpvars(0, dut);
  $dumpvars(0, vif_top);
end
  initial begin
    #2000;
    $finish();
  end
endmodule