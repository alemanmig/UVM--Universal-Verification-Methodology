 //==============================================================
// SPI Interface Memmory
// Description: SPI-TB Sequences Pakage.
//
// Author: Grupo de Verificación
//==============================================================
 
 `include "uvm_macros.svh"

 package UVM_SPI_Mem_TB_Sequences_pkg;
 
  import uvm_pkg::*;
  import SPI_Mem_TB_Data_Types_pkg::*;
  import UVM_SPI_Mem_TB_Spi_pkg::*;
  import UVM_SPI_Mem_TB_Top_pkg::*;

    `include "SPI_Mem_TB_Read_Data_Sequence.sv"
    `include "SPI_Mem_TB_Rst_Dut_Sequence.sv"
    `include "SPI_Mem_TB_Write_Data_Sequence.sv"
    `include "SPI_Mem_TB_Witeb_Readb_Sequence.sv"

  endpackage