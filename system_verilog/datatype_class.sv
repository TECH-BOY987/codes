module class_tb;
class packet;
logic [31:0]addr;
logic[15:0]data;
function void display();
$display("address:%h,data:%h",addr,data);
endfunction
endclass
endmodule
