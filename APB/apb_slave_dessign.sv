module apb_slave (
    input wire clk,
    input wire reset_n,
    input wire psel,
    input wire penable,
    input wire [31:0] paddr,
    input wire pwrite,
    input wire [31:0] pwdata,
    output reg [31:0] prdata,
    output reg pready,
    output reg pslverr
);

    reg [31:0] memory [0:255]; 

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            pready <= 1'b0;
            pslverr <= 1'b0; 
        end else begin
            if (psel && penable) begin
                if (pwrite) begin
    
                    memory[paddr] <= pwdata;
                    pready <= 1'b1;
                end else begin

                    prdata <= memory[paddr];
                    pready <= 1'b1;
                end
            end else begin
                pready <= 1'b0;
            end
        end
    end

endmodule