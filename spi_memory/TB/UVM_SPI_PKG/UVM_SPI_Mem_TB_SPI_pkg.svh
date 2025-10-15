
//==============================================================
// File: UVM_SPI_Mem_TB_pkg.sv
// Description: SPI Agent Package - SPI-MEMORY.
//
// Author: Grupo de Verificación
//==============================================================

 `include "uvm_macros.svh"
 
 package UVM_SPI_Mem_TB_Spi_pkg;
 
  import uvm_pkg::*;
  import SPI_Mem_TB_Data_Types_pkg::*; 
  
  `include "SPI_Mem_TB_Spi_Transaction.sv"  
  typedef uvm_sequencer #(SPI_Mem_TB_Spi_Transaction) SPI_Mem_TB_Spi_Sequencer; 
  `include "SPI_Mem_TB_Spi_Driver.sv"  
  `include "SPI_Mem_TB_Spi_Monitor.sv" 
  `include "SPI_Mem_TB_Spi_Agent.sv"  
  
 endpackage