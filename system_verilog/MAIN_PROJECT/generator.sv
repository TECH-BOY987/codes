class generator;
  rand transaction trans;                 // Randomized transaction object
  mailbox #(transaction) gen2drv;         // Mailbox for communication with the driver
  event drv2gen;                          // Event to synchronize with the driver
  int repeat_count;                        // Number of transactions to generate

  // Constructor: Initializes the mailbox
  function new(mailbox #(transaction) gen2drv);
    this.gen2drv = gen2drv; 
  endfunction

  // Main task to generate and send transactions
  task main();
    repeat (repeat_count) begin
      trans = new();                      // Create a new transaction object
      if (!trans.randomize())             // Randomize transaction fields
        $fatal("Gen::trans randomization failed"); // Fatal error if randomization fails
      trans.display("_______GENERATOR_______"); // Display transaction details
      gen2drv.put(trans);                 // Send transaction to the driver via mailbox
    end
    ->drv2gen;                            // Trigger event to signal completion
  endtask
endclass