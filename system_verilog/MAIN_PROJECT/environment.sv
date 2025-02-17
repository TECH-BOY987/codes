`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

// Environment class to manage all testbench components
class environment;
  generator gen;                         // Generator instance
  driver drv;                             // Driver instance
  monitor mon;                            // Monitor instance
  scoreboard scb;                         // Scoreboard instance
  
  mailbox #(transaction) gen2drv;         // Mailbox for generator-to-driver communication
  mailbox #(transaction) mon2scb;         // Mailbox for monitor-to-scoreboard communication
  virtual fifo_intf vif_fifo;             // Virtual interface for FIFO communication
  
  // Constructor: Initializes the environment components
  function new(virtual fifo_intf vif_fifo);
    this.vif_fifo = vif_fifo;
    gen2drv = new();                      // Create mailbox for generator-driver communication
    mon2scb = new();                      // Create mailbox for monitor-scoreboard communication
    gen = new(gen2drv);                   // Instantiate generator
    drv = new(vif_fifo, gen2drv);         // Instantiate driver with FIFO interface and mailbox
    mon = new(vif_fifo, mon2scb);         // Instantiate monitor with FIFO interface and mailbox
    scb = new(mon2scb);                   // Instantiate scoreboard with mailbox
  endfunction
  
  // Task to perform pre-test setup (reset FIFO)
  task pre_test();
    drv.reset();                           // Call the reset task in driver
  endtask
  
  // Task to execute the main test sequence
  task test();
    fork
      gen.main();                          // Start generator
      drv.main();                          // Start driver
      mon.main();                          // Start monitor
      scb.main();                          // Start scoreboard
    join_any                               // Run any process until one completes
  endtask
  
  // Task to perform post-test checks
  task post_test();
    wait(gen.drv2gen.triggered);           // Wait for the generator-to-driver event
    wait(gen.repeat_count == drv.no_trans);// Ensure all generated transactions were driven
    wait(gen.repeat_count == scb.no_trans);// Ensure all transactions were verified
  endtask
  
  // Task to run the entire testbench sequence
  task run();
    pre_test();                            // Perform pre-test setup
    test();                                // Execute test sequence
    post_test();                           // Perform post-test validation
    #300;                                  // Delay to allow simulation stabilization
  endtask
endclass
