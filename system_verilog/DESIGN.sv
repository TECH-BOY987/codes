module fifo_router(
  input clk, rst, soft_rst, wr_en, rd_en, lfd_state, // Control signals
  input [7:0] d_in,                                  // Data input
  output reg [7:0] dout,                             // Data output
  output full, empty                                 // FIFO status flags
);

  reg [8:0] fifo_mem[15:0];  // FIFO memory (9-bit wide: 8-bit data + 1-bit flag)
  reg [4:0] wr_ptr, rd_ptr;   // Write and read pointers (5 bits for wrap-around)
  reg [6:0] count;            // Counter for tracking payload length
  reg lfd_state_t;            // Latched version of lfd_state signal
  integer i;

  // Latch lfd_state on every clock cycle
  always @(posedge clk) begin
    if (!rst)
      lfd_state_t <= 0;
    else
      lfd_state_t <= lfd_state;
  end

  // FIFO Read Logic
  always @(posedge clk) begin
    if (!rst)
      dout <= 8'b0;                 // Reset output data
    else if (soft_rst)
      dout <= 8'bz;                 // Soft reset puts output in high-impedance state
    else if (count == 0)
      dout <= 8'bz;                 // If FIFO is empty, output remains high-impedance
    else if (rd_en && !empty)
      dout <= fifo_mem[rd_ptr[3:0]][7:0]; // Read data from FIFO memory
  end

  // FIFO Write Logic
  always @(posedge clk) begin
    if (!rst || soft_rst) begin
      // Reset FIFO memory on hard or soft reset
      for (i = 0; i < 16; i = i + 1)
        fifo_mem[i] <= 0;
    end
    else if (wr_en && !full) begin
      // Write data to FIFO if not full
      if (lfd_state_t) begin
        fifo_mem[wr_ptr[3:0]][8] <= 1'b1;   // Set flag for first data
        fifo_mem[wr_ptr[3:0]][7:0] <= d_in; // Store input data
      end
      else begin
        fifo_mem[wr_ptr[3:0]][8] <= 1'b0;   // Clear flag for normal data
        fifo_mem[wr_ptr[3:0]][7:0] <= d_in;
      end
    end
  end

  // Write Pointer Update
  always @(posedge clk) begin
    if (!rst)
      wr_ptr <= 0;                   // Reset write pointer
    else if (wr_en && !full)
      wr_ptr <= wr_ptr + 1;           // Increment write pointer on write enable
  end

  // Read Pointer Update
  always @(posedge clk) begin
    if (!rst)
      rd_ptr <= 0;                    // Reset read pointer
    else if (rd_en && !empty)
      rd_ptr <= rd_ptr + 1;            // Increment read pointer on read enable
  end

  // Payload Length Handling
  always @(posedge clk) begin
    if (rd_en && !empty) begin
      if (fifo_mem[rd_ptr[3:0]][8] == 1'b1) 
        count <= fifo_mem[rd_ptr[3:0]][7:2] + 1'b1; // Calculate payload length
      else if (count != 0)
        count <= count - 1;            // Decrement count when reading data
    end
  end

  // FIFO Full Condition: When write pointer wraps around and overlaps with read pointer
  assign full = (wr_ptr == {~rd_ptr[4], rd_ptr[3:0]});

  // FIFO Empty Condition: When read and write pointers are equal
  assign empty = (rd_ptr == wr_ptr);

endmodule
