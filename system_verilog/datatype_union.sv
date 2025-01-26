module union_1();
union packed{bit[31:0]salary;
int id;}emp;
initial begin
    emp.salary=16'h800;
    $display("salary updated for EMP:%0d",emp.salary);
    emp.id=8'd1234;
    $display("ID updated for EMP: %0d",emp.id);
    $display("salary after ID update for EMP:%0d",emp.salary);
end
endmodule
