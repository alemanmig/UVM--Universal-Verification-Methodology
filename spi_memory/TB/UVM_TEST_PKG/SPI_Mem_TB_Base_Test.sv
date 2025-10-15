//===============================================================
// File: SPI_Mem_TB_Base_Test.sv
// Description: SPI Base Test - SPI-MEMEMORY.
//
// Author: Grupo de Verificación
//===============================================================


 class SPI_Mem_Base_Test extends uvm_test;

  `uvm_component_utils(SPI_Mem_Base_Test)
 
  function new(string name = "SPI_Mem_Base_Test", uvm_component parent = null);
   super.new(name,parent);
  endfunction
 
  SPI_Mem_TB_Env e;
  
  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
     
	 e = SPIi_Mem_Env::type_id::create("env",this);

  endfunction
 
  virtual task run_phase(uvm_phase phase);
  
   phase.raise_objection(this);
   `uvm_info("","Base Test",UVM_MEDIUM);
   phase.drop_objection(this);
   
  endtask
  
endclass