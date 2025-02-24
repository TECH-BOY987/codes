`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2025 21:50:38
// Design Name: 
// Module Name: router_topmodule_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module router_topmodule_tb();
reg clk=0,rst,pkt_valid,rd_en_0,rd_en_1,rd_en_2;
reg [7:0]d_in;
wire vld_out_0,vld_out_1,vld_out_2,err,busy;
wire [7:0]dout_0,dout_1,dout_2;
integer i;
router_topmodule dut(.clk(clk),.rst(rst),.pkt_valid(pkt_valid),.rd_en_0(rd_en_0),.rd_en_1(rd_en_1),.rd_en_2(rd_en_2),.d_in(d_in),
.vld_out_0(vld_out_0),.vld_out_1(vld_out_1),.vld_out_2(vld_out_2),.err(err),.busy(busy),.dout_0(dout_0),.dout_1(dout_1),.dout_2(dout_2));
always #5 clk=~clk;
task pktm_gen_5;
            input [6:0] payloadlen;
            input read;
            input simread;
            input [1:0] addr;
            input [7:0] ext_parity;
			reg [7:0]header, payload_data; 
			reg [7:0]parity;
			begin
				parity=0;
				wait(!busy)
				begin
				@(negedge clk);
				pkt_valid=1;
				header={payloadlen,addr};
				d_in=header;
				parity=parity^d_in;
				end
				@(negedge clk);
							
				for(i=0;i<=payloadlen;i=i+1)
					begin
					wait(!busy) begin
					@(negedge clk);
					payload_data={$random}%256;
					d_in=payload_data;
					parity=parity^d_in; 
					end					
					if(read&&simread&&i==5) begin
					rd_en_0=(addr==0);
					rd_en_1=(addr==1);
					rd_en_2=(addr==2);
					end
					end			
              wait(!busy) begin
					@(negedge clk)
					pkt_valid=0;				
					d_in=(ext_parity==0)?parity:ext_parity;
					end
					if(read) begin
					@(negedge clk);
					@(negedge clk);
					if(addr==0) begin
					rd_en_0=simread? rd_en_0:1;
					wait(dut.f0.empty);
					rd_en_0=0;
					end else if(addr==1) begin
					rd_en_1=simread? rd_en_1:1;
					wait(dut.f1.empty);
					rd_en_1=0;
					end else if(addr==2) begin
					rd_en_2=simread? rd_en_2:1;
					wait(dut.f2.empty);
					rd_en_2=0;
					end
					end
					end
             
endtask
initial
		begin
		pkt_valid=0;
		rd_en_0=0;
		rd_en_1=0;
		rd_en_2=0;
		d_in=0;
		rst=0;
		#10;
		rst=1;
		#20 pktm_gen_5(6'd8,1,0,2'b0,0);
		#20; rst=0;#10; rst=1;		
		#30; pktm_gen_5(6'd20,1,1,2'b0,0);
		end			
endmodule
