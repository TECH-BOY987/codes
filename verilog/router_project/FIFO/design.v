module router_fifo(
input clk,rst,soft_rst,wr_en,rd_en,lfd_state,
input [7:0] d_in,
output reg [7:0] dout,
output full,empty);
reg [8:0]fifo_mem[15:0];
reg [4:0] wr_ptr,rd_ptr;
reg [6:0]count;
reg lfd_state_t;
integer i;
always@(posedge clk)
begin
if(!rst)
lfd_state_t<=0;
else
lfd_state_t<= lfd_state;
end
//fifo_read
always@(posedge clk)
begin
if(!rst)
dout<=8'b0;
else if(soft_rst)
dout<=8'bz;
else if(rd_en&&!empty)
dout<=fifo_mem[rd_ptr[3:0]][7:0];
else if(count==0)
dout<=8'bz;
end
//fifo_write
always @(posedge clk) begin
if (!rst||soft_rst) begin
for(i=0;i<16;i=i+1)
fifo_mem[i]<=0;
end
 else if (wr_en && !full) begin
  if(lfd_state_t) begin
   fifo_mem[wr_ptr[3:0]][8]<=1'b1;
fifo_mem[wr_ptr[3:0]][7:0]<=d_in;
  end
  else begin
   fifo_mem[wr_ptr[3:0]][8]<=1'b0;
fifo_mem[wr_ptr[3:0]][7:0]<=d_in;
  end
end
end
//rd_ptr and wr_ptr
always@(posedge clk) begin
if(!rst)
wr_ptr<=0;
else
if(wr_en&&!full)
wr_ptr<=wr_ptr+1;
end
always@(posedge clk) begin
if(!rst)
rd_ptr<=0;
else
if(rd_en&&!empty)
rd_ptr<=rd_ptr+1;
end
//payload_length
always @(posedge clk) begin
if(rd_en&&!empty) begin
if(fifo_mem[rd_ptr[3:0]][8]==1'b1)
count<=fifo_mem[rd_ptr[3:0]][7:2]+1'b1;
else if(count!=0)
count<=count-1'b1;
end
end
assign full=(wr_ptr=={~rd_ptr[4],rd_ptr[3:0]});
assign empty=(rd_ptr==wr_ptr);
endmodule
