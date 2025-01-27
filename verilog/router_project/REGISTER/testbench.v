module router_register_tb();
reg clk=0,rst,pkt_valid=0,fifo_full=0,detect_add=0,ld_state=0,laf_state=0,full_state=0,lfd_state=0,rst_int_reg=0;
reg [7:0]d_in;
wire [7:0]dout;
wire err,parity_done,low_pkt_valid;
router_register dut(.clk(clk),.rst(rst),.pkt_valid(pkt_valid),.d_in(d_in),.fifo_full(fifo_full),.detect_add(detect_add),.ld_state(ld_state),.laf_state(laf_state),
.full_state(full_state),.lfd_state(lfd_state),.rst_int_reg(rst_int_reg),.dout(dout),.err(err),.parity_done(parity_done),.low_pkt_valid(low_pkt_valid));
always #5 clk=~clk;
reg [7:0]header,payload_data,parity=0;
integer i;
task reset;
begin
rst=1'b0;
#10;
rst=1'b1;
#10;
end
endtask
task packet1();
begin
#10;
detect_add=1'b1;
pkt_valid=1'b1;
header=8'b00010101;
parity=parity^header;
d_in=header;
#10;
detect_add=1'b0;
lfd_state=1'b1;
full_state =1'b0;      
fifo_full =1'b0;       
laf_state =1'b0; 
for(i=0;i<8;i=i+1)
begin
#10;
lfd_state=0;
ld_state=1;
payload_data={$random}%256;
d_in=payload_data;
parity=parity^d_in;
end
#10;
pkt_valid=0;
d_in=parity;
#10;
ld_state=0;
#20;
end
endtask
task packet2();
begin
#10;
parity=0;
detect_add=1'b1;
pkt_valid=1'b1;
header=8'b00010101;
parity=parity^header;
d_in=header;
#10;
detect_add=1'b0;
lfd_state=1'b1;
full_state =1'b0;      
fifo_full =1'b0;       
laf_state =1'b0; 
for(i=0;i<8;i=i+1)
begin
#10;
lfd_state=0;
ld_state=1;
payload_data={$random}%256;
d_in=payload_data;
parity=parity^d_in;
end
#10;
pkt_valid=0;
d_in=8'd48;
#10;
ld_state=0;
#20;
end
endtask
initial
begin
reset;
#20;
packet1();
#20;
packet2();
$finish;
end
endmodule
