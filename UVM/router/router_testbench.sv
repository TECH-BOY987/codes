`include "uvm_macros.svh"
import uvm_pkg::*;

interface intf(input clk);
 logic rst;
 logic [7:0] d_in;
 logic pkt_valid;
 logic rd_en;
 logic vld_out;
 logic err; 
 logic busy;
 logic [7:0] dout;
endinterface

class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction)
  
  function  new(string obj="transaction");
    super.new(obj);
  endfunction
  
  rand bit[7:0] header;
  rand bit[7:0] payload[];
  bit[7:0] parity=0;
  
  constraint header_con{header[1:0] inside {2'b00,2'b01,2'b10};}
  constraint payload_con{payload.size()==header[7:2] && header[7:0]!=0;}
  
  
  function void do_printer(uvm_printer printer);
    super.do_print(printer);
    printer.print_field( "header", this.header, 8,UVM_DEC);
    foreach(payload[i])
    begin
    printer.print_field( $sformatf("payload[%0d]", i), 	this.payload[i], 	    8,UVM_DEC		);
    end
    printer.print_field( "parity",	this.parity,   8,UVM_DEC);
  endfunction
endclass

class sequence_1 extends uvm_sequence#(transaction);
  `uvm_object_utils(sequence_1)

  function  new(string obj="sequence_1");
    super.new(obj);
  endfunction
  
 transaction t;
  
  virtual task body();
    repeat(3) begin
       t=transaction::type_id::create("t");
      start_item(t);
      $display("---------sequence-------------");
      assert(t.randomize() with {header[7:2] < 4'd14;});
      $display("header=%0h ",t.header);
      $display("---------sequence-------------");
      finish_item(t);
    end    
  endtask
endclass

class driver extends uvm_driver#(transaction);
  `uvm_component_utils(driver)
  
  function new(string comp="driver",uvm_component parent=null);
    super.new(comp,parent);
  endfunction
  transaction t;
  virtual intf vif;
//   wr_agent_config wr_cfg;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // assert(uvm_config_db#(wr_agent_config)::get(this,"","wr_agent_config",wr_cfg));
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // vif=wr_cfg.vif;
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(negedge vif.clk);
      @(negedge vif.clk);
       @(negedge vif.clk);
      @(negedge vif.clk);
    vif.rst=0;
    @(negedge vif.clk);
    vif.rst=1;
      t=transaction::type_id::create("t");
      seq_item_port.get_next_item(t);
      wait(!vif.busy);
      @(negedge vif.clk);
      vif.pkt_valid<=1'b1;
      vif.d_in<=t.header;
      t.parity<=t.parity^t.header;
      @(negedge vif.clk);
      foreach(t.payload[i]) begin
        wait(!vif.busy);
         @(negedge vif.clk);
        vif.d_in<=t.payload[i];
        t.parity<=t.parity^t.payload[i];
      end 
      wait(!vif.busy);
       @(negedge vif.clk);
     vif.pkt_valid<=0;
     vif.d_in<=t.parity;
      $display("================DRIVER==============");
      $display("header=%0h parity=%0h",t.header,t.parity);
      $display("================DRIVER==============");
      @(negedge vif.clk);
      seq_item_port.item_done(t);  
    end
  endtask
endclass

class sequencer extends uvm_sequencer#(transaction);
  `uvm_component_utils(sequencer)
  
  function  new(string comp="sequencer",uvm_component parent=null);
    super.new(comp,parent);
  endfunction
endclass  

class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  
  virtual intf vif;
  // wr_agent_config wr_cfg;
  transaction t;
  uvm_analysis_port#(transaction) wr_port;
  
   function  new(string comp="monitor",uvm_component parent);
    super.new(comp,parent);
     wr_port=new("wr_port",this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    // assert(uvm_config_db#(wr_agent_config)::get(this,"","wr_agent_config",wr_cfg));   
    super.build_phase(phase);
  endfunction
  
  
  // virtual function void connect_phase(uvm_phase phase);
  //   vif=wr_cfg.vif;
  // endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      t=transaction::type_id::create("t",this);
      
      wait(vif.pkt_valid && !vif.busy);
		 @(posedge vif.clk);
       @(posedge vif.clk);
      t.header=vif.d_in;
       
     
      t.payload=new[t.header[7:2]];
      @(posedge vif.clk);
      foreach(t.payload[i]) begin
        t.payload[i]=vif.d_in;
        @(posedge vif.clk);
      end
      wait(!vif.busy);
      t.parity=vif.d_in;
      $display("==================WRITE MONITOR===================");
      $display("header=%0h parity=%0h",t.header,t.parity);
      @(posedge vif.clk);
      wr_port.write(t);
    end
  endtask
endclass

class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  uvm_tlm_analysis_fifo#(transaction) wr_fifo;
  uvm_tlm_analysis_fifo#(transaction) rd_fifo[];
  
  // env_config cfg;
  transction wr_data;
  transction rd_data;
  
  function new(string comp="sco",uvm_component parent=null);
    super.new(comp,parent);
    // assert(uvm_config_db #(env_config)::get(this,"","env_cfg",cfg));
    wr_fifo=new("transaction",this);
    rd_fifo=new[cfg.no_of_read_agents];
    foreach(rd_fifo[i])
      rd_fifo[i]=new($sformatf("rd_fifo[%0d]",i),this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
    $display("scoreboard run phase");
    wr_fifo.get(wr_data);
    if(wr_data.header[1:0]==2'b00) begin
      rd_fifo[0].get(rd_data);
      check_data(wr_data,rd_data);
    end
    if(wr_data.header[1:0]==2'b01) begin
      rd_fifo[1].get(rd_data);
      check_data(wr_data,rd_data);
    end
    if(wr_data.header[1:0]==2'b10) begin
      rd_fifo[2].get(rd_data);
      check_data(wr_data,rd_data);
    end
    end
  endtask
  
  function void check_data(transaction wr_data,transaction rd_data);
    $display("'================Scoreboard====================");
    $display("WRITE: payload=%p, header=%0h, parity=%0h", wr_data.payload, wr_data.header, wr_data.parity);
    $display("READ: payload=%p, header=%0h, parity=%0h",rd_data.payload, rd_data.header, rd_data.parity);

    if(wr_data.header == rd_data.header)
$display("HEADER IS MATCHED");
else $display("HEADER NOT MATCHED");

if(wr_data.payload == rd_data.payload)
$display("PAYLOAD IS MATCHED");
else
$display("PAYLOAD IS NOT MATCHED");

if(wr_data.parity == rd_data.parity)
$display("PARITY IS MATCHED");
else
$display("PARITY IS NOT MATCHED");
    $display("'================Scoreboard====================");
endfunction
endclass

class agent extends uvm_agent;
  `uvm_component_utils(agent)
  
  function new(string comp="agent",uvm_component parent=null);
    super.new(comp,parent);
  endfunction
  
  sequencer sqr;
  driver driv;
  monitor mon;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sqr=sequencer::type_id::create("sqr",this);
    driv=driver::type_id::create("driv",this);
    mon=monitor::type_id::create("mon",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driv.seq_item_port.connect(sqr.seq_item_export);
  endfunction
endclass

class agent_config extends uvm_object;
  `uvm_object_utils(agent_config)
  
  function  new(string obj="agent_config");
    super.new(obj);
    endfunction
  
 virtual intf vif;
 
  uvm_active_passive_enum is_active=UVM_ACTIVE;
  
  static int mon_rcvd_trans=0;
  static int driv_snd_trans=0;
  
endclass

class env_config extends uvm_object;
  `uvm_object_utils(env_config)
  
  function  new(string obj="env_config");
    super.new(obj);
  endfunction
  
  bit has_wagent = 1;
bit has_ragent = 1;
bit has_virtual_sequencer = 1;
bit has_scoreboard= 1;
 
  agent_config wr_cfg;
  agent_config rd_cfg[];
  
  int no_of_read_agents=3;
int no_of_write_agents= 1;
  
endclass

class virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);
  `uvm_component_utils(virtual_sequencer)
  sequencer w_sqr;
  sequencer r_sqr[];
  
  env_config cfg;
  
  function  new(string comp="virtual_sequencer",uvm_component parent=null);
    super.new(comp,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    $display("v_seq build phase");
    assert(uvm_config_db#(env_config)::get(this,"","env_cfg",cfg)) ;
//        `uvm_fatal("virtual sequencer","cannot config data")
    $display("v_seq build phase end");
    r_sqr=new[cfg.no_of_read_agents];
  endfunction
  
endclass

class environment extends uvm_env;
 `uvm_component_utils(environment)
  
  // wr_agent_top wr_agt_top;
  // rd_agent_top rd_agt_top;
  virtual_sequencer vsqr;
  scoreboard sco;
  env_config cfg;
  
  function  new(string comp="env",uvm_component parent=null);
    super.new(comp,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    assert(uvm_config_db#(env_config)::get(this,"","env_cfg",cfg));
    
    if(cfg.has_wagent)
      wr_agt_top=wr_agent_top::type_id::create("wr_agt_top",this);
    if(cfg.has_ragent)
      rd_agt_top=rd_agent_top::type_id::create("rd_agt_top",this);
    
    if(cfg.has_virtual_sequencer)
      vsqr=virtual_sequencer::type_id::create("vsqr",this);
    if(cfg.has_scoreboard)
      sco=scoreboard::type_id::create("sco",this);
    
    
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    if(cfg.has_virtual_sequencer) begin
       if(cfg.has_wagent)
	       vsqr.w_sqr = wr_agt_top.wr_agnt.sqr;
      if(cfg.has_ragent)
        vsqr.r_sqr=new[3];
      foreach(vsqr.r_sqr[i])
        vsqr.r_sqr[i]=rd_agt_top.rd_agnt[i].r_sqr;
    end
    if(cfg.has_scoreboard)begin
      wr_agt_top.wr_agnt.mon.wr_port.connect(sco.wr_fifo.analysis_export);
      foreach(rd_agt_top.rd_agnt[i])
        rd_agt_top.rd_agnt[i].r_mon.rd_port.connect(sco.rd_fifo[i].analysis_export);
    end       
  endfunction
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  function  new(string comp="test",uvm_component parent=null);
    super.new(comp,parent);
  endfunction
  
  environment env;
  wr_agent_config wr_cfg;
  rd_agent_config rd_cfg[];
  env_config cfg;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg=env_config::type_id::create("cfg");
    wr_cfg=wr_agent_config::type_id::create("wr_cfg");
    wr_cfg.is_active=UVM_ACTIVE;
    
    if(!uvm_config_db #(virtual intf) :: get(this, " ","vif",wr_cfg.vif))
              	`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?") 

               cfg.wr_cfg= wr_cfg;
    
    cfg.rd_cfg=new[3];
    rd_cfg=new[3];
    foreach(rd_cfg[i]) begin
      rd_cfg[i]=rd_agent_config::type_id::create($sformatf("rd_cfg[%0d]",i));
      rd_cfg[i].is_active=UVM_ACTIVE;
      if(!uvm_config_db #(virtual intf) :: get(this, " ",$sformatf("vif%0d",i),rd_cfg[i].vif))
              	`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?") 
        cfg.rd_cfg[i]=rd_cfg[i];
    end

    uvm_config_db #(env_config)::set(this,"*","env_cfg",cfg);
    env=environment::type_id::create("env", this);
	endfunction
endclass
  
class test extends uvm_test;
    seq s;
    `uvm_component_utils(test)
    function  new(string comp="test",uvm_component parent=null);
      super.new(comp,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    endfunction
    

 virtual task run_phase(uvm_phase phase);
	$display("-------------TEST RUN PHASE--------------------------------------");
	s = seq :: type_id :: create( "s") ;
	phase.raise_objection(this);
   	s.start(env.vsqr);
   phase.drop_objection(this);
 endtask
endclass
  

    
    
  
      
  