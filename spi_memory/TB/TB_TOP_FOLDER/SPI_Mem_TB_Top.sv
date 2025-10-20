///////////////////////////////////////////////
// SPI Testbench Top 
// File: SPI_Mem_TB_Top.sv
////////////////////////////////////////////////

 `include "uvm_macros.svh"

module SPI_Mem_TB_Top;

  import uvm_pkg::*;
  import spi_mem_pkg::*;
  import SPI_Mem_TB_pkg::*;
  
  SPI_Mem_TB_If sm_if();
  
  spi_mem dut (.clk(sm_if.clk), .rst(sm_if.rst), .cs(sm_if.cs), .miso(sm_if.miso), .ready(sm_if.ready), .mosi(sm_if.mosi), .op_done(sm_if.op_done));


  
  initial begin
    sm_if.clk <= 0;
  end
 
  always #10 sm_if.clk <= ~sm_if.clk;
 
  
 initial
   begin
   
    $timeformat(-6,2,"us");
    
    uvm_config_db #(virtual SPI_Mem_TB_If)::set(null, "*", "SPI_Mem_TB_If", sm_if);
   
    run_test("");
	
   end

  bind spi_mem SPI_Mem_TB_Assertions SPI_Mem_SVA (.clk(clk), .rst(rst), .cs(cs), .miso(miso), .ready(ready), .mosi(mosi), .op_done(op_done));
  
 
  
endmodule