// Packet class definition 
class transaction;
  // Randomizable fields representing packet attributes	
  rand bit wr_en;  
  rand bit rd_en;
  rand bit lfd_state;
  randc bit [7:0] d_in;
  bit [7:0] dout;
  bit full, empty;

  // Constraint to ensure write and read are not enabled simultaneously
  constraint cons { wr_en != rd_en; }

  // Function to display transaction details

  function void display(string name); 
    $display("--------------");
    $display("%0s", name);  // Display name of the transaction
    $display("--------------");
    
    // Print write transaction details if write enable is active
    if (wr_en)
      $display("wr_en=%0b    d_in=%0d    full=%0b", wr_en, d_in, full);
    // Print read transaction details if read enable is active
    if (rd_en)
      $display("rd_en=%0b    dout=%0d    empty=%0b", rd_en, dout, empty);
    
    $display("--------------");
  endfunction
endclass