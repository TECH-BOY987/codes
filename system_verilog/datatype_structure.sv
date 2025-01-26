module struct_example;
typedef bit[5:0][5:0]string_t;
struct packed{string_t name; bit[31:0] salary; integer id;}employee;
initial begin
    employee.name="joey";
    employee.salary=32'h100000;
    employee.id=1234;
    //$display("employee:name:%0s,salary:%0d,id:%0d",employee);
    //accessing_individual_struct_number
    $display("employee:name=%0s,salary=0x%0h,id=%0d",employee.name,employee.salary,employee.id);
end
endmodule
