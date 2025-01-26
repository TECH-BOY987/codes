module arrays_t();
  int arr[3]= {20,40,34};
  string arr1[3]={"hello","world","!"};
string arr2[];
  int arr3[string];
// int arr3[string;
initial begin
    arr2=new[4];
    arr2={"hello","Vlsi","!"};
  arr3["RED"]=128;
  arr3["BLUE"]=230;
  arr3["GREEN"]=8;
      $display("/*** simple integer array ***/");
      foreach(arr[i])begin
        $display("arr[%0d]:%0d",i,arr[i]);
      end
        $display("/*** simple string array ***/");
      foreach(arr1[i])begin
        $display("arr1[%0d]:%0s",i,arr1[i]);
      end
        $display("/*** dynamic array ***/");
      foreach(arr2[i])begin
        $display("arr2[%0d]:%0s",i,arr2[i]);
      end
  $display("/*** associative array ***/");
  $display("arr3[RED]:%0d",arr3["RED"]);
  $display("arr2[BLUE]:%0d",arr3["BLUE"]);
  $display("arr3[GREEN]:%0d",arr3["GREEN"]);
end
endmodule
