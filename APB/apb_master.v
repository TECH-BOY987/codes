module apb_master(
	input pclk,
	input prst,
	input pwrite,
	input [31:0] paddr,
	input [31:0]pwdata,
	output reg psel,
	output reg pen,
	output reg [31:0]prdata,
	input pready,
	input pslverr
	);

	reg [1:0] state;
	localparam IDLE = 2'b00, SETUP = 2'b01, ACCESS = 2'b10;

	always @(posedge pclk)begin
		if (~prst)begin
			state <= IDLE;
			psel <= 1'b0;
			pen <= 1'b0;
			prdata <= 32'b0;
		end
		else begin
			case (state)
				IDLE : begin
					psel <= 1'b0;
					pen <= 1'b0;
					state <= SETUP;
				end
				SETUP : begin
					psel <= 1'b1;
					pen <= 1'b0;
					state <= ACCESS;
				end
				ACCESS : begin
					pen <= 1'b1;
					if (pready)begin
						psel <= 1'b0;
						pen <= 1'b0;
						if (~pwrite)begin
							prdata <= pwdata;
						end
						state <= IDLE;
					end
				end
			endcase
		end
	end
endmodule