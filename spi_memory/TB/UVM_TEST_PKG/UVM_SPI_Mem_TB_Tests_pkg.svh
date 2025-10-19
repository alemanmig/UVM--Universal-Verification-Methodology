//===============================================================
// File: UVM_SPI_Mem_TB_Test_pkg.sv
// Description: SPI Test Package - SPI-MEMEMORY.
//
// Author: Grupo de Verificación
//===============================================================


`include "uvm_macros.svh"

 package UVM_SPI_Mem_TB_Tests_pkg;
 
  import uvm_pkg::*;
  import UVM_SPI_Mem_TB_Top_pkg::*;
  import UVM_SPI_Mem_TB_Sequences_pkg::*; 

  `include "SPI_Mem_TB_Base_Test.sv"
 
  `include "SPI_Mem_TB_Write_Data_Test.sv"
  `include "SPI_Mem_TB_Read_Data_Test.sv"
  `include "SPI_Mem_TB_Writeb_Readb_Test.sv"
  `include "SPI_Mem_TB_Rst_Dut_Test.sv"
  
 endpackage