class monitor;
  virtual fifo_intf vif_fifo;             // Virtual interface for FIFO communication
  mailbox #(transaction) mon2scb;         // Mailbox to send transactions to the scoreboard

  // Constructor: Initializes the virtual interface and mailbox
  function new(virtual fifo_intf vif_fifo, mailbox #(transaction) mon2scb);
    this.vif_fifo = vif_fifo;
    this.mon2scb = mon2scb;
  endfunction

  // Main task to monitor FIFO transactions
  task main;
    forever begin
      transaction trans;
      trans = new();                       // Create a new transaction object
      
      @(posedge vif_fifo.clk);             // Wait for a clock edge
      trans.d_in = vif_fifo.d_in;          // Capture input data
      trans.wr_en = vif_fifo.wr_en;        // Capture write enable signal
      trans.rd_en = vif_fifo.rd_en;        // Capture read enable signal
      
      @(posedge vif_fifo.clk);             // Wait for another clock edge
      #1;                                  // Small delay for stability
      
      // Capture output signals from FIFO
      trans.dout = vif_fifo.dout;
      trans.full = vif_fifo.full;
      trans.empty = vif_fifo.empty;

      @(posedge vif_fifo.clk);             // Wait for another clock edge
      mon2scb.put(trans);                  // Send transaction to the scoreboard mailbox
      trans.display("_______MONITOR__________"); // Display transaction details
    end   
  endtask
endclass
