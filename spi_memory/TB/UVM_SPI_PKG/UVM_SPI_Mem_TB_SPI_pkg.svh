
//==============================================================
// File: UVM_SPI_Mem_TB_pkg.sv
// Description: SPI Agent Package - SPI-MEMORY.
//
// Author: Grupo de Verificación
//==============================================================

 `include "uvm_macros.svh"
 
 package UVM_SPI_Mem_TB_SPI_pkg;
 
  import uvm_pkg::*;
  import SPI_Mem_TB_Data_Types_pkg::*; 
  
  `include "SPI_Mem_TB_SPI_Transaction.sv"  
  typedef uvm_sequencer #(SoftErrorTol_GPIO_TB_AXI_Bus_Transaction) SoftErrorTol_GPIO_TB_AXI_Bus_Sequencer; 
  `include "SPI_Mem_TB_SPI_Driver.sv"  
  `include "SPI_Mem_TB_SPI_Monitor.sv" 
  `include "SPI_Mem_TB_SPI_Agent.sv"  
  
 endpackage