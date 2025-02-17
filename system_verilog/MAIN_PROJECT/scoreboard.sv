class scoreboard;
  mailbox #(transaction) mon2scb;   // Mailbox to receive transactions from the monitor
  int no_trans;                     // Counter for the number of transactions processed
  
  bit [8:0] fifo_mem[15:0];         // FIFO memory array (16 locations, 9-bit width)
  bit [4:0] wr_ptr;                 // Write pointer to track FIFO writes
  bit [4:0] rd_ptr;                 // Read pointer to track FIFO reads
  bit [6:0] count;                  // Counter to track the number of elements in the FIFO

  // Constructor: Initializes the mailbox
  function new(mailbox #(transaction) mon2scb);
    this.mon2scb = mon2scb;
  endfunction 

  // Main task to process transactions
  task main;
    forever begin   
      transaction trans;
      mon2scb.get(trans);           // Get transaction from the mailbox

      // Handle write operations
      if (trans.wr_en) begin
        fifo_mem[wr_ptr] = trans.d_in;  // Store data into FIFO memory
        wr_ptr = (wr_ptr + 1) % 16;     // Increment write pointer (wrap around if needed)
        count = count + 1;              // Increase FIFO count
      end

      // Handle read operations
      if (trans.rd_en) begin
        if (count == 0) begin
          $display("Scoreboard: FIFO is empty, no data to read");
        end else begin
          // Display expected vs received data
          $display("Scoreboard: Expected Data = %0d, Received Data = %0d", fifo_mem[rd_ptr], trans.dout);
          
          // Check if data matches expected value
          if (fifo_mem[rd_ptr] == trans.dout) begin
            $display("Scoreboard: Test Passed for Data = %0d", trans.dout);
          end else begin
            $display("Scoreboard: Test Failed for Data = %0d", trans.dout);
          end
          
          rd_ptr = (rd_ptr + 1) % 16;  // Increment read pointer (wrap around if needed)
          count = count - 1;           // Decrease FIFO count
        end 
      end

      trans.display("_________SCOREBOARD___________"); // Display transaction details
      no_trans++;                       // Increment transaction counter
    end
  endtask
endclass
