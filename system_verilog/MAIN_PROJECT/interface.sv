// FIFO Interface Definition
interface fifo_intf(input logic clk, rst, soft_rst, lfd_state);
  logic wr_en;       // Write enable signal for FIFO
  logic rd_en;       // Read enable signal for FIFO
  logic [7:0] d_in;  // 8-bit data input to FIFO
  logic [7:0] dout;  // 8-bit data output from FIFO
  logic full;        // FIFO full flag
  logic empty;       // FIFO empty flag
endinterface
