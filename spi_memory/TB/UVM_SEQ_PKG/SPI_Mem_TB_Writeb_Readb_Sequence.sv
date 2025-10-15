//==============================================================
// File: SPI_Mem_TB_Writeb_Readb_Sequence.sv
// Description: SPI Write Read Sequence - SPI-MEMEMORY.
//
// Author: Grupo de Verificación
//==============================================================


class SPI_Mem_TB_Writeb_Readb_Sequence extends uvm_sequence#(SPI_Mem_TB_Spi_Transaction);
  `uvm_object_utils(SPI_Mem_TB_Writeb_Readb_Sequence)
  
  SPI_Mem_TB_Spi_Transaction tr;
 
  function new(string name = "SPI_Mem_TB_Writeb_Readb_Sequence");
    super.new(name);
  endfunction
  
  virtual task body();
     
    repeat(10)
      begin
        tr = SPI_Mem_TB_Spi_Transaction::type_id::create("tr");
        tr.addr_c.constraint_mode(1);
        start_item(tr);
        assert(tr.randomize);
        tr.op = writed;
        finish_item(tr);  
      end
        
    repeat(10)
      begin
        tr = SPI_Mem_TB_Spi_Transactiontr::type_id::create("tr");
        tr.addr_c.constraint_mode(1);
        start_item(tr);
        assert(tr.randomize);
        tr.op = readd;
        finish_item(tr);
      end   
    
  endtask
  
 
endclass