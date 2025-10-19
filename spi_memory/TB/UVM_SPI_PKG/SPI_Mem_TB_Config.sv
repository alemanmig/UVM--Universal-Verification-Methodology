//==============================================================
// File: SPI_Mem_TB_Config.sv
// Description: SPI Config - SPI-MEMEMORY.
//
// Author: Grupo de Verificación
//==============================================================

class SPI_Mem_TB_Config extends uvm_object; /////configuration of env
  `uvm_object_utils(SPI_Mem_TB_Config)
  
  function new(string name = "SPI_Mem_TB_Config");
    super.new(name);
  endfunction
  
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  
endclass