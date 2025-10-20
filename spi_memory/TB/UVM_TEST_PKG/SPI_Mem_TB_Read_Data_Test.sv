//===============================================================
// File: SPI_Mem_TB_Base_Test.sv
// Description: SPI Base Test - SPI-MEMEMORY.
//
// Author: Grupo de Verificación
//===============================================================

class SPI_Mem_TB_Read_Data_TestCase extends SPI_Mem_TB_Base_Test;
  `uvm_component_utils(SPI_Mem_TB_Read_Data_TestCase)
 
  function new(input string inst = "SPI_Mem_TB_Read_Data_TestCase", uvm_component c);
   super.new(inst,c);
  endfunction
 
  SPI_Mem_TB_Read_Data_Sequence rdata;
  
  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);

   rdata  = SPI_Mem_TB_Read_Data_Sequence::type_id::create("rdata");

  endfunction
 
  task run_phase(uvm_phase phase);
   super.run_phase(phase);
   
   phase.raise_objection(this);
   rdata.start(e.a.seqr);
   #20;
   phase.drop_objection(this);
   
  endtask

endclass