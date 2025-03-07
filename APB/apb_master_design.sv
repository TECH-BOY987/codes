module apb_master(
input wire clk,
input wire rst,
input wire [31:0] prdata,
input wire pready, 
output reg psel,
output reg pen,
output reg [31:0] paddr,
output reg pwrite,
output reg [31:0] pwdata,
output reg pslverr
);

typedef enum logic [1:0]{IDLE,SETUP,ACCESS} state_t;
state_t state;
always@(posedge clk or negedge rst) begin
    if(!rst) begin
        state<=IDLE;
        psel<=1'b0;
        pen<=1'b0;
    end
    else begin
    case(state)
    IDLE: begin
        psel<=32'h0000_0000;
        pwrite<=1'b1;
        pwdata<=32'h1234_5678;
        pen<=1'b1;
        if(pready) begin
            state<=ACCESS;
        end
    end
    SETUP: begin
        paddr<=32'h0000_0000;
        pwrite<=1'b1;
        pwdata<=32'h1234_5678;
        pen<=1'b1;
        if(pready) begin
            state<=ACCESS;
        end
    end
    ACCESS: begin
      psel<=1'b0;
      pen<=1'b0;
      state<=IDLE;
    end
    endcase
    end
end
endmodule