module string_datatype;
string s1="hello world";
string s2={"hi,"," ",s1};
string s3;
bit [31:0]b=128;
initial
begin
    s3=$sformatf("%0d",b);
    $display("string1 s1=%0s",s1);
    $display("string2 s2=%0s",s2);
    $display("string3 s3=%0sbit b=%0d",s3,b);
end
endmodule
