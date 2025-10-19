//===============================================================
// File: SPI_Mem_TB_Rst_Dut_Test.sv
// Description: SPI Reset DUT Test - SPI-MEMEMORY.
//
// Author: Grupo de Verificación
//===============================================================


class SPI_Mem_TB_Rst_Dut_TestCase extends SPI_Mem_TB_Base_Test;
  `uvm_component_utils(SPI_Mem_TB_Rst_Dut_TestCase)
 
  function new(input string inst = "SPI_Mem_TB_Rst_Dut_TestCase", uvm_component c);
   super.new(inst,c);
  endfunction
 
  SPI_Mem_TB_Rst_Dut_Sequence rstdut;
  
  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);

   rstdut  = SPI_Mem_TB_Rst_Dut_Sequence::type_id::create("rstdut");

  endfunction
 
  task run_phase(uvm_phase phase);
   super.run_phase(phase);
   
   phase.raise_objection(this);
   rstdut.start(e.a.seqr);
   #20;
   phase.drop_objection(this);
   
  endtask

endclass