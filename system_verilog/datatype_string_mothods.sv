module methords_tb;
string str="hello world";
initial
    begin
        string tmp;
        $display("str.len()=%0d",str.len());
        tmp=str;
        tmp.putc(3,"d");
        $display("str.putc(3,d)=%s",tmp);
        $display("str.getc(2)=%s (%0d)",str.getc(2),str.getc(2));
        $display("str.tolower()=%s",str.tolower());
        tmp="hello world";
        $display("[tmp,str are same] str.compare(tmp)=%0d",str.compare(tmp));
end
endmodule
