module tb;
string firstname="joey";
string lastname="thakolkaran";
initial begin
    if(firstname==lastname)
    $display("firstname %0s is equal to last name=%0s",firstname,lastname);
    if(firstname!=lastname)
    $display("firstname %0s is not equal to lastname=%0s",firstname,lastname);
    if(firstname<lastname)
    $display("firstname %0s is less than lastname=%0s",firstname,lastname);
    if(firstname>lastname)
    $display("firstname %0s is greater than lastname=%0s",firstname,lastname);
    $display("fullname=%0s",{firstname," ",lastname});
    $display("%0s",{3{firstname}});
    $display("firstname[2]=%0s lastname[2]=%0s",firstname[2],lastname[2]);
end
endmodule
