//==============================================================
// File: SPI_Mem_TB_Agent.sv
// Description: SPI Agent - SPI-MEMEMORY.
//
// Author: Grupo de Verificación
//==============================================================

class SPI_Mem_TB_Agent extends uvm_agent;
`uvm_component_utils(SPI_Mem_TB_Agent)
  
  SPI_Mem_TB_Config cfg;
 
function new(input string inst = "SPI_Mem_TB_Agent", uvm_component parent = null);
super.new(inst,parent);
endfunction
 
 SPI_Mem_TB_Driver d;
 uvm_sequencer#(transaction) seqr;
 SPI_Mem_TB_Mon m;
 SPI_Mem_TB_Mon
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
   cfg = SPI_Mem_TB_Config ::type_id::create("cfg"); 
   m   = SPI_Mem_TB_Mon    ::type_id::create("m",this);
  
  if(cfg.is_active == UVM_ACTIVE)
   begin   
   d = SPI_Mem_TB_Driver ::type_id::create("d",this);
   seqr = uvm_sequencer#(transaction)::type_id::create("seqr", this);
   end
  
  
endfunction
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
  if(cfg.is_active == UVM_ACTIVE) begin  
    d.seq_item_port.connect(seqr.seq_item_export);
  end
endfunction
 
endclass