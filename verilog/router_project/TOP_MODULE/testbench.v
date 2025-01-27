module top_module_tb();
reg clk,rst,pkt_valid,rd_en_0,rd_en_1,rd_en_2;
reg [7:0]d_in;
wire vld_out_0,vld_out_1,vld_out_2,err,busy;
wire [7:0]dout_0,dout_1,dout_2;
integer i;
top_module dut(.clk(clk),.rst(rst),.pkt_valid(pkt_valid),.rd_en_0(rd_en_0),.rd_en_1(rd_en_1),.rd_en_2(rd_en_2),.d_in(d_in),
.vld_out_0(vld_out_0),.vld_out_1(vld_out_1),.vld_out_2(vld_out_2),.err(err),.busy(busy),.dout_0(dout_0),.dout_1(dout_1),.dout_2(dout_2));
always #5 clk=~clk;
task pktm_gen_5;
			reg [7:0]header, payload_data, parity;
			reg [5:0]payloadlen;
			begin
				parity=0;
				wait(!busy)
				begin
				@(negedge clk)
				payloadlen=5;
				pkt_valid=1'b1;
				header={payloadlen,2'b00};
				d_in=header;
				parity=parity^d_in;
				end
				@(negedge clk)
							
				for(i=0;i<=payloadlen;i=i+1)
					begin
					wait(!busy)
					@(negedge clk)
					payload_data=$random%8;
					d_in=payload_data;
					parity=parity^d_in; 
					end					
								
              wait(!busy)
					@(negedge clk)
					pkt_valid=1'b0;				
					d_in=parity;
              repeat(5)
			@(negedge clk)
			rd_en_0=1'b1;
			wait(dut.f0.empty);
			rd_en_0=0;
              end
endtask
task pktm_gen_7;
			reg [7:0]header, payload_data, parity;
			reg [5:0]payloadlen;
			begin
				parity=0;
				wait(!busy)
				begin
				@(negedge clk)
				payloadlen=7;
				pkt_valid=1'b1;
				header={payloadlen,2'b00};
				d_in=header;
				parity=parity^d_in;
				end
				@(negedge clk)
							
				for(i=0;i<=payloadlen;i=i+1)
					begin
					wait(!busy)
					@(negedge clk)
					payload_data=$random%8;
					d_in=payload_data;
					parity=parity^d_in; 
					end					
								
              wait(!busy)
					@(negedge clk)
					pkt_valid=1'b0;				
					d_in=parity;
              repeat(5)
			@(negedge clk)
			rd_en_0=1'b1;
			wait(dut.f0.empty);
			rd_en_0=0;
              end
              endtask
 task pktm_gen_8;
			reg [7:0]header, payload_data, parity;
			reg [5:0]payloadlen;
			begin
				parity=0;
				wait(!busy)
				begin
				@(negedge clk)
				payloadlen=8;
				pkt_valid=1'b1;
				header={payloadlen,2'b01};
				d_in=header;
				parity=parity^d_in;
				end
				@(negedge clk)
							
				for(i=0;i<=payloadlen;i=i+1)
					begin
					wait(!busy)
					@(negedge clk)
					payload_data=$random%8;
					d_in=payload_data;
					parity=parity^d_in; 
					end					
								
              wait(!busy)
					@(negedge clk)
					pkt_valid=1'b0;				
					d_in=parity;
              repeat(5)
			@(negedge clk)
			rd_en_1=1'b1;
			wait(dut.f1.empty);
			rd_en_1=0;
              end
endtask
task pktm_gen_16;
			reg [7:0]header, payload_data, parity;
			reg [5:0]payloadlen;
			begin
				parity=0;
				wait(!busy)
				begin
				@(negedge clk)
				payloadlen=4;
				pkt_valid=1'b1;
				header={payloadlen,2'b10};
				d_in=header;
				parity=parity^d_in;
				end
				@(negedge clk)
							
				for(i=0;i<=payloadlen;i=i+1)
					begin
					wait(!busy)
					@(negedge clk)
					payload_data=$random%8;
					d_in=payload_data;
					parity=parity^d_in; 
					end					
								
              wait(!busy)
					@(negedge clk)
					pkt_valid=1'b0;				
					d_in=parity;
              repeat(4)
			@(negedge clk)
			rd_en_2=1'b1;
			wait(dut.f2.empty);
			rd_en_2=0;
              end
              endtask
              task pktm_gen_6;
			reg [7:0]header, payload_data, parity;
			reg [5:0]payloadlen;
			begin
				parity=0;
				wait(!busy)
				begin
				@(negedge clk)
				payloadlen=6;
				pkt_valid=1'b1;
				header={payloadlen,2'b10};
				d_in=header;
				parity=parity^d_in;
				end
				@(negedge clk)
							
				for(i=0;i<=payloadlen;i=i+1)
					begin
					wait(!busy)
					@(negedge clk)
					payload_data=$random%8;
					d_in=payload_data;
					parity=parity^d_in; 
					end					
								
              wait(!busy)
					@(negedge clk)
					pkt_valid=1'b0;				
					d_in=parity;
              repeat(5)
			@(negedge clk)
			rd_en_2=1'b1;
			wait(dut.f2.empty);
			rd_en_2=0;
              end
endtask
initial
		begin
		clk=1'b0;
		rst=1'b0;
		pkt_valid=1'b0;
		rd_en_0=1'b0;
		rd_en_1=1'b0;
		rd_en_2=1'b0;
		d_in=8'b0;
		#20;
		rst=1'b1;
		#10;
			pktm_gen_5;
			pktm_gen_7;
			pktm_gen_8;
			pktm_gen_16;
			pktm_gen_6;
			#200;
		end			
endmodule
