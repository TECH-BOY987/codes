module apb_master(
input wire clk,
input wire rst,
input wire psel,
input wire pen,
input wire [31:0] paddr,
input wire  [31:0] pwdata,
input wire [31:0] pwrite,
output reg [31:0] prdata,
output reg pready, 
output reg pslverr
);

parameter IDLE = 3'b000;
parameter SETUP = 3'b010;
parameter ACCESS = 3'b100;

reg [1:0] ps,ns;

reg [31:0] memory [31:0];

always@(posedge clk) begin
    if(!rst)
    ps<=IDLE;
    else
    ps<=ns;
end
always@(*)  begin
    case(ps)
    IDLE:
        if(!psel)
        ns<=IDLE;
        else
        ns<=ACCESS;
    SETUP:
        if(psel && pen) begin
            ns<=ACCESS;
            pready=1;
             if (pwrite) begin
    
                    memory[paddr] <= pwdata;
                    pready <= 1'b1;
                end else begin

                    prdata <= memory[paddr];
                    pready <= 1'b1;
                end
        end
    ACCESS:
if(!psel&&!pen) begin
    ns<= IDLE;
    pready<=0;
    prdata<=0;
end
endcase
end
endmodule

//testbench

module tb();
reg clk=0;
reg rst;
reg psel;
reg pen;
reg [31:0] paddr;
reg  [31:0] pwdata;
reg [31:0] pwrite;
wire [31:0] prdata;
wire pready;
wire pslverr;

apb_master dut(.clk(clk),.rst(rst),.psel(psel),.pen(pen),.paddr(paddr),.pwdata(pwdata),.pwrite(pwrite),.prdata(prdata),.pready(pready),.pslverr(pslverr));

always #5 clk=~clk;

task initialize;
begin
    clk=0;
    rst=0;
    psel=0;
    paddr=0;
    pen=0;
    pwrite=0;
end
endtask
task reset;
begin
    rst=0;
    #5; rst=1;
end
endtask
task write();
begin
@(posedge clk);
paddr=paddr+1;
psel=1;
pwrite=1;
pwdata=($random)%10;
$display("data_in=%0d,addr=%0d",pwdata,paddr);
@(posedge clk);
pen=1;

@(posedge clk);
pen=0;
psel=0;
pwdata=0;
end
endtask
task read();
begin
@(posedge clk);
paddr=paddr+1;
psel=1;
pwrite=0;
@(posedge clk);
pen=1;
$display("data_out=%0d,addr=%0d",prdata,paddr);

@(posedge clk);
pen=0;
psel=0;
pwdata=0;
end
endtask
initial begin
    initialize;
    reset;

    write();
    paddr=0;
    read();
end
endmodule
