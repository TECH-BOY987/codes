module apb_slave (
	input pclk,
	input prst,
	input psel,
	input pen,
	input pwrite,
	input [31:0] paddr,
	input [31:0] pwdata,
	output reg [31:0] prdata,
	output reg pready,
	output reg pslverr
	);

	reg [31:0] memory [0:15];

	always @(posedge pclk)begin
		if (~prst)begin
			prdata <= 32'b0;
			pready <= 1'b0;
			pslverr <= 1'b0;
		end
		else begin
			if (psel && pen)begin
				if (pwrite) begin
					//write operation
					memory[paddr] <= pwdata;
					pready <= 1'b1;
					pslverr <= 1'b0;
				end
				else begin
					//read operation
					prdata <= memory[paddr];
					pready <= 1'b1;
					pslverr <= 1'b0;
				end
			end
			else begin
				pready <= 1'b0;
				pslverr <= 1'b0;
			end
		end
	end
endmodule
