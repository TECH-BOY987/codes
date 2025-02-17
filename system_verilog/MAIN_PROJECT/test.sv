`include "environment.sv"

// Test program to instantiate and execute the verification environment
program test(fifo_intf intf);
  environment env;  // Environment instance to manage all components

  // Initial block to set up and run the test
  initial begin
    env = new(intf);             // Instantiate the environment with FIFO interface
    env.gen.repeat_count = 10;   // Set the number of transactions to be generated
    env.run();                   // Execute the test sequence
  end
endprogram
