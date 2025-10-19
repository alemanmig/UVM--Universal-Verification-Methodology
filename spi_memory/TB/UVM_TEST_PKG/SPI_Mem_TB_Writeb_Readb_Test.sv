//===============================================================
// File: SPI_Mem_TB_Wite_Data_Test.sv
// Description: SPI Write Data Test - SPI-MEMEMORY.
//
// Author: Grupo de Verificación
//===============================================================

class SPI_Mem_TB_Writeb_Readb_TestCase extends SPI_Mem_TB_Base_Test;
  `uvm_component_utils(SPI_Mem_TB_Writeb_Readb_TestCase)
 
  function new(input string inst = "SPI_Mem_TB_Writeb_Readb_TestCase", uvm_component c);
   super.new(inst,c);
  endfunction
 
  SPI_Mem_TB_Writeb_Readb_Sequence wrrdb;
  
  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);

   wrrdb  = SPI_Mem_TB_Writeb_Readb_Sequence::type_id::create("wrrdb");

  endfunction
 
  task run_phase(uvm_phase phase);
   super.run_phase(phase);
   
   phase.raise_objection(this);
   wrrdb.start(e.a.seqr);
   #20;
   phase.drop_objection(this);
   
  endtask

endclass