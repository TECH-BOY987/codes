class driver;
  int no_trans;                           // Counter to keep track of the number of transactions
  virtual fifo_intf vif_fifo;             // Virtual interface for FIFO communication
  mailbox #(transaction) gen2drv;         // Mailbox to receive transactions from the generator
  
  // Constructor: Initializes the virtual interface and mailbox
  function new(virtual fifo_intf vif_fifo, mailbox #(transaction) gen2drv);
    this.vif_fifo = vif_fifo;
    this.gen2drv = gen2drv;
  endfunction  
  
  // Task to reset the FIFO interface
  task reset;
    wait(!vif_fifo.rst);                  // Wait until reset is de-asserted
    $display("start reset");
    vif_fifo.wr_en <= 0;                   // Disable write enable
    vif_fifo.rd_en <= 0;                   // Disable read enable
    wait(vif_fifo.rst);                    // Wait for reset assertion
    $display("done resetting");
  endtask
  
  // Main task to handle transactions
  task main;
    forever begin
      transaction trans;
      gen2drv.get(trans);                  // Retrieve transaction from the generator mailbox
      @(posedge vif_fifo.clk);             // Wait for a clock edge
      vif_fifo.d_in = trans.d_in;          // Assign input data from transaction
      vif_fifo.wr_en = trans.wr_en;        // Assign write enable signal
      vif_fifo.rd_en = trans.rd_en;        // Assign read enable signal
      @(posedge vif_fifo.clk);             // Wait for another clock edge
      #1;                                  // Small delay for stability
      
      // Capture output signals from FIFO
      trans.dout = vif_fifo.dout;
      trans.full = vif_fifo.full;
      trans.empty = vif_fifo.empty;
      
      @(posedge vif_fifo.clk);             // Wait for another clock edge
      trans.display("________DRIVER________"); // Display transaction details
      no_trans++;                          // Increment transaction count
    end
  endtask
endclass
