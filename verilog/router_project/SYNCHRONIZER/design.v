module router_synchronizer(
input clk,rst,detect_add,full_0,full_1,full_2,empty_0,empty_1,empty_2,wr_en_reg,rd_en_0,rd_en_1,rd_en_2,
input [1:0]d_in,
output reg vld_out_0,vld_out_1,vld_out_2,
output reg fifo_full,soft_rst_0,soft_rst_1,soft_rst_2,
output reg [2:0]wr_en);
reg[1:0]temp;
reg[4:0]count0,count1,count2;
always@(posedge clk)
if(!rst)
temp<=2'b00;
else if(detect_add)
temp<=d_in;
always@(*)
begin
case(temp)
2'b00:begin
fifo_full=full_0;
wr_en<=(wr_en_reg)? 3'b001:0;
end
2'b01:begin
fifo_full=full_1;
wr_en<=(wr_en_reg)? 3'b010:0;
end
2'b10:begin
fifo_full=full_2;
wr_en<=(wr_en_reg)? 3'b100:0;
end
endcase
end
always@(*)
begin
if(!rst)
begin
vld_out_0=1'b0;
vld_out_1=1'b0;
vld_out_2=1'b0;
end
else begin
vld_out_0=!empty_0;
vld_out_1=!empty_1;
vld_out_2=!empty_2;
end
end
always@(posedge clk) begin
if(!rst) begin
count0<=0;
soft_rst_0<=0;
end
else if(vld_out_0) begin
if(!rd_en_0)
if(count0==29) begin
soft_rst_0<=1;
count0<=0;
end else begin
soft_rst_0<=0;
count0<=count0+1'b1;
end
else
count0<=0;
end
end
always@(posedge clk) begin
if(!rst) begin
count1<=0;
soft_rst_1<=0;
end
else if(vld_out_1) begin
if(!rd_en_1)
if(count1==29) begin
soft_rst_1<=1;
count1<=0;
end else begin
soft_rst_1<=0;
count1<=count1+1'b1;
end
end
else
count1<=0;
end
always@(posedge clk) begin
if(!rst) begin
count2<=0;
soft_rst_2<=0;
end
else if(vld_out_2) begin
if(!rd_en_2)
if(count2==29) begin
soft_rst_2<=1;
count2<=0;
end else begin
soft_rst_2<=0;
count2<=count2+1'b1;
end
end
else
count2<=0;
end
endmodule
