`include "apb_master.v"
`include "apb_slave.v"
module apb_tb;
	reg pclk;
	reg prst;
	wire psel;
	wire pen;
	reg pwrite;
	reg [31:0] paddr;
	reg [31:0] pwdata;
	wire [31:0]prdata;
	wire pready;
	wire pslverr;

	apb_master uut_master(
		.pclk(pclk),
		.presetn(prst),
		.psel(psel),
		.penable(pen),
		.pwrite(pwrite),
		.paddr(paddr),
		.pwdata(pwdata),
		.prdata(prdata),
		.pready(pready),
		.pslverr(pslverr)
		);

	apb_slave uut_slave(
		.pclk(pclk),
		.presetn(prst),
		.psel(psel),
		.penable(pen),
		.pwrite(pwrite),
		.paddr(paddr),
		.pwdata(pwdata),
		.prdata(prdata),
		.pready(pready),
		.pslverr(pslverr));

	always #5 pclk = ~pclk;

	initial begin	
		pclk = 0;
		prst = 0;
		
		//apply reset
		#10 prst = 1;

		//write operation
		#10;
		pwrite = 1;
		paddr = 32'h00001;
		pwdata = 32'hA5A5A5A5;
		#20;

		//read operation
		#10;
		pwrite = 0;
		paddr = 32'h00001;

		//wait for transaction
		#100;
		 
		$stop;
	end
endmodule