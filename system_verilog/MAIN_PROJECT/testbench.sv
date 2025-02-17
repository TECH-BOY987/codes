`include "interface.sv"
`include "test.sv"

// Top-level testbench module
module tb_top;
  logic clk;         // Clock signal
  logic rst;         // Reset signal
  logic soft_rst;    // Soft reset signal
  logic wr_en;       // Write enable signal
  logic rd_en;       // Read enable signal
  logic lfd_state;   // Load First Data state signal
  logic [7:0] d_in;  // 8-bit data input
  logic [7:0] dout;  // 8-bit data output
  logic full;        // FIFO full flag
  logic empty;       // FIFO empty flag 

  // Instantiate the FIFO interface
  fifo_intf intf(clk, rst, soft_rst);

  // Instantiate the FIFO router (DUT - Device Under Test)
  fifo_router dut (
    .clk(intf.clk), 
    .rst(intf.rst), 
    .soft_rst(intf.soft_rst), 
    .wr_en(intf.wr_en), 
    .rd_en(intf.rd_en), 
    .lfd_state(intf.lfd_state), 
    .d_in(intf.d_in), 
    .dout(intf.dout), 
    .full(intf.full), 
    .empty(intf.empty)
  );

  // Clock generation: 10ns period (T = 10ns, F = 100MHz)
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // Toggle clock every 5 time units
  end

  // Reset sequence
  initial begin
    rst = 0;
    soft_rst = 0;
    #5;
    soft_rst = 1;
    #20;
    rst = 1; 
    soft_rst = 0;
    #5;
    lfd_state = 0;
    #35;
    lfd_state = 1;
  end

  // Instantiate and run the test program
  test t1(.intf);

  // Dump waveforms for debugging
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
