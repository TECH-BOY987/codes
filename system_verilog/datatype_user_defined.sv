shortint mydata;
typedef enum  {RED,GREEN,YELLOW} light_enum_t;
typedef shortint u_shorti;
typedef bit [7:0]ubyte;
u_shorti my_data_var;
light_enum_t light1;
ubyte my_byte_var;
module testench;
    initial begin
        my_data_var=10;
        light1=GREEN;
        my_byte_var=8'b10101010;
        $display("my_data_var=%0d",my_data_var);
        $display("light1 =%s",light1.name());
        $display("my_byte_var =%b",my_byte_var);
    end
endmodule
