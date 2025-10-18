//==============================================================
// File: UVM_SPI_Mem_TB_Top_pkg.svh
// Description: SPI-TB TOP Pakage.
//
// Author: Grupo de Verificación
//==============================================================

 `include "uvm_macros.svh"
 
 package UVM_SPI_Mem_TB_Top_pkg;
 
   import uvm_pkg::*;
   import UVM_SPI_Mem_TB_Spi_pkg::*;
   
   `include "SPI_Mem_TB_Scoreboard.sv"
//   `include "SPI_Mem_TB_VSequencer.sv"
//   `include "SPI_Mem_TB_Cov_Collector.sv"
   `include "SPI_Mem_TB_Env.sv"
   
 endpackage