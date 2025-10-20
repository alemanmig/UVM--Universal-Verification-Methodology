//===========================================================
// Archivo : SPI_Mem_TB_Cov_Collector.sv
// Descripción : Módulo de assertions y coberturas
//                para el diseño spi_mem.sv
// Autor: Grupo de Verificación
// Fecha: 2025-10-19
//===========================================================

`include "uvm_macros.svh"
import uvm_pkg::*;
import spi_mem_pkg::*;

class SPI_Mem_TB_Cov_Collector extends uvm_component;
  `uvm_component_utils(SPI_Mem_TB_Cov_Collector)

  // ==========================================================
  // Variables y configuración
  // ==========================================================
  virtual SPI_Mem_TB_If sm_vif;

  // ==========================================================
  // Constructor
  // ==========================================================
  function new (string name = "SPI_Mem_TB_Cov_Collector", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual SPI_Mem_TB_If)::get(this, "", "SPI_Mem_TB_If", sm_vif)) begin
      `uvm_fatal("COV", "No se pudo obtener la interfaz virtual SPI_Mem_TB_If desde uvm_config_db")
    end
  endfunction

  // ==========================================================
  // COVERGROUPS (solo señales visibles del DUT)
  // ==========================================================

  covergroup cs_signal; // @(posedge sm_vif.clk iff (!sm_vif.rst));
    
    cs_en: coverpoint sm_vif.cs {
      bins inactive = {1'b1};
      bins active   = {1'b0};
    }
  endgroup

  covergroup miso_cg; // @(posedge sm_vif.clk iff (!sm_vif.rst));

    miso_sig: coverpoint sm_vif.miso {
      bins low  = {0};
      bins high = {1};
    }

  endgroup

  covergroup mosi_cg; // @(posedge sm_vif.clk iff (!sm_vif.rst));
    mosi_sig: coverpoint sm_vif.mosi {
      bins low  = {0};
      bins high = {1};
    }
  endgroup

  covergroup read_signal; //@(posedge sm_vif.clk iff (!sm_vif.rst));
    read_en: coverpoint sm_vif.ready {
      bins not_ready = {0};
      bins ready     = {1};
    }
  endgroup

  covergroup op_done_signal; // @(posedge sm_vif.clk iff (!sm_vif.rst));
    op_done_en: coverpoint sm_vif.op_done {
      bins not_done = {0};
      bins done     = {1};
    }
  endgroup

  covergroup cg_ctrl_vs_hs; // @(posedge sm_vif.clk iff (!sm_vif.rst));
    coverpoint sm_vif.cs {
      bins inactive = {1'b1};
      bins active   = {1'b0};
    }
    coverpoint sm_vif.ready {
      bins low  = {0};
      bins high = {1};
    }
    coverpoint sm_vif.op_done {
      bins low  = {0};
      bins high = {1};
    }
    cross sm_vif.cs, sm_vif.ready, sm_vif.op_done;
  endgroup

  covergroup cg_miso_vs_mosi;  //@(posedge sm_vif.clk iff (!sm_vif.rst));
    coverpoint sm_vif.miso {
      bins low  = {0};
      bins high = {1};
    }
    coverpoint sm_vif.mosi {
      bins low  = {0};
      bins high = {1};
    }
    cross sm_vif.miso, sm_vif.mosi;
  endgroup

  // ==========================================================
  // INSTANCIAS DE COVERGROUPS
  // ==========================================================
  cs_signal      = new;
  miso_cg        = new;
  mosi_cg        = new;
  read_signal   = new;
  op_done_signal = new;
  cg_ctrl_vs_hs  = new;
  cg_miso_vs_mosi = new;

  // ==========================================================
  // RUN PHASE
  // ==========================================================
  task run_phase(uvm_phase phase);

  fork
    begin
      forever 
        begin
           @(posedge sm_vif.clk iff (!sm_vif.rst));
            cs_signal.sample();
            miso_cg.sample();
            mosi_cg.sample();
            read_signal.sample();
            op_done_signal.sample();
            cg_miso_vs_mosi.sample();

        end
    end
    
  join
  
  endtask

endclass

