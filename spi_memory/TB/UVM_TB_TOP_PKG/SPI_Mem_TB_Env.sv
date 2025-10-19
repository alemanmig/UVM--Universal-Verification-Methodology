//==============================================================
// File: SPI_Mem_TB_Env.sv
// Description: Environment - SPI-MEMEMORY.
//
// Author: Grupo de Verificación
//==============================================================

class SPI_Mem_TB_Env extends uvm_env;
`uvm_component_utils(SPI_Mem_TB_Env)
 
function new(input string inst = "SPI_Mem_TB_Env", uvm_component c);
super.new(inst,c);
endfunction
 
SPI_Mem_TB_Spi_Agent a;
SPI_Mem_TB_Scoreboard s;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  a = SPI_Mem_TB_Spi_Agent::type_id::create("a",this);
  s = SPI_Mem_TB_Scoreboard::type_id::create("s", this);
endfunction
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
 a.m.send.connect(s.recv);
endfunction
 
endclass