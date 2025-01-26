module enum_datatype;
enum{mage=30,thief,priest=60,archer,hero=100,demon}fantasy;
initial begin
    fantasy=archer;
    $display($time,"\t the great archer is %0d years old",fantasy);
    #50;
    fantasy=hero;
    $display($time,"\t the great hero is %0d years old",fantasy);
    #60;
    fantasy=mage;
    $display($time,"\t the great mage is %0d years old",fantasy);
end
endmodule
