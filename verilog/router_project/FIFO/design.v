module fifo_router(
input clk,rst,soft_rst,wr_en,rd_en,lfd_state,
input [7:0] d_in,
output reg [7:0] dout,
output reg full,empty);
reg [8:0]fifo_mem[15:0];
reg [3:0] wr_ptr,rd_ptr;
reg[5:0]count_len;
reg [4:0]count;
reg lfd_state_t;
integer i;
always@(posedge clk)
begin
if(!rst)
lfd_state_t<=1'b0;
else
lfd_state_t<= lfd_state;
end
//size
always@(count)
begin
empty<=(count==4'b0000);
full<=(count==4'b1111);
end
//counter
always@(posedge clk)
begin
if(!rst)begin
dout<=8'd0;
count<=4'd0;
end
else if((!full&&wr_en)&&(!empty&&rd_en))
count<=count;
else if(!full&&wr_en)
count<=count+1;
else if(!empty&&rd_en)
count<=count-1;
else
count<=count;
end
//fifo_read
always@(posedge clk)
begin
if(!rst)
dout<=8'b0;
else if(soft_rst)
dout<=8'bz;
else if(count==0)
dout<=8'bz;
else if(rd_en&&!empty)
dout<=fifo_mem[rd_ptr[3:0]];
end
//fifo_write
always @(posedge clk) begin
if (!rst||soft_rst) begin
for(i=0;i<16;i=i+1)
fifo_mem[i]<=0;
end
else if (wr_en && !full) begin
fifo_mem[wr_ptr[3:0]][8]<=lfd_state_t;
fifo_mem[wr_ptr[3:0]][7:0]<=d_in;
end
end
//rd_ptr and wr_ptr
always@(posedge clk) begin
if(!rst||soft_rst) begin
wr_ptr<=4'b0;
rd_ptr<=4'b0;
end
else begin
if(wr_en&&!full)
wr_ptr<=wr_ptr+1;
else
wr_ptr<=wr_ptr;
if(rd_en&&!empty)
rd_ptr<=rd_ptr+1;
else
rd_ptr<=rd_ptr;
end
end
//payload_length
always @(posedge clk) begin
if(fifo_mem[rd_ptr[3:0]][8])
count<=fifo_mem[rd_ptr[3:0]][7:2]+1'b1;
 if(count_len!=0)
count_len<=count_len-1'b1;
end
endmodule
