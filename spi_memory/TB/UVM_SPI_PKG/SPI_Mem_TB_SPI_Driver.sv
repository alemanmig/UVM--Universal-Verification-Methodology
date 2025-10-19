//==============================================================
// File: SPI_Mem_TB_Spi_Driver.sv
// Description: SPI Driver - SPI-MEMEMORY.
//
// Author: Grupo de Verificación
//==============================================================

class SPI_Mem_TB_Spi_Driver extends uvm_driver #(SPI_Mem_TB_Spi_Transaction);
  `uvm_component_utils(SPI_Mem_TB_Spi_Driver)
  
  virtual SPI_Mem_TB_If sm_vif;
  SPI_Mem_TB_Spi_Transaction tr;
  logic [15:0] data; ////<- din , addr ->
  logic [7:0] datard;
  
  
  function new(input string path = "SPI_Mem_TB_Spi_Drive", uvm_component parent = null);
    super.new(path,parent);
  endfunction
  
 virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     tr = SPI_Mem_TB_Spi_Transaction::type_id::create("tr");
      
      if(!uvm_config_db#(virtual SPI_Mem_TB_If)::get(this,"","sm_vif",sm_vif))//uvm_test_top.env.agent.drv.aif
      `uvm_error("drv","Unable to access Interface");
  endfunction
  
  
  
  ////////////////////reset task
  task reset_dut(); 
    begin
    sm_vif.rst      <= 1'b1;  ///active high reset
    sm_vif.miso     <= 1'b0;
    sm_vif.cs       <= 1'b1;
   `uvm_info("DRV", "System Reset", UVM_MEDIUM);
    @(posedge sm_vif.clk);
    end
  endtask
  
  ///////////////////////write 
  task write_d();
  ////start of transaction
  sm_vif.rst  <= 1'b0;
  sm_vif.cs   <= 1'b0;
  sm_vif.miso <= 1'b0;
  data     = {tr.din, tr.addr};
  `uvm_info("DRV", $sformatf("DATA WRITE addr : %0d din : %0d",tr.addr, tr.din), UVM_MEDIUM); 
  @(posedge sm_vif.clk);
  sm_vif.miso <= 1'b1;  ///write operation
  @(posedge sm_vif.clk);
  
  for(int i = 0; i < 16 ; i++)
   begin
   sm_vif.miso <= data[i];
   @(posedge sm_vif.clk);
   end
  
  @(posedge sm_vif.op_done);
  
  endtask 
  
 //////////////////read operation 
  task read_d();
  ////start of transaction
  sm_vif.rst  <= 1'b0;
  sm_vif.cs   <= 1'b0;
  sm_vif.miso <= 1'b0;
  data     = {8'h00, tr.addr};
  @(posedge sm_vif.clk);
  sm_vif.miso <= 1'b0;  ///read operation
  @(posedge sm_vif.clk);
  
  ////send addr
  for(int i = 0; i < 8 ; i++)
   begin
   sm_vif.miso <= data[i];
   @(posedge sm_vif.clk);
   end
   
   ///wait for data ready
  @(posedge sm_vif.ready);
  
  ///sample output data
   for(int i = 0; i < 8 ; i++)
   begin
   @(posedge sm_vif.clk);
   datard[i] = sm_vif.mosi;
   end
   `uvm_info("DRV", $sformatf("DATA READ addr : %0d dout : %0d",tr.addr,datard), UVM_MEDIUM);  
  @(posedge sm_vif.op_done);
  
  endtask 
  
 
  virtual task run_phase(uvm_phase phase);
    forever begin
     
         seq_item_port.get_next_item(tr);
     
     
                   if(tr.op ==  rstdut)
                          begin
                          reset_dut();
                          end
 
                  else if(tr.op == writed)
                          begin
                          write_d();
                          end
                else if(tr.op ==  readd)
                          begin
					      read_d();
                          end
                          
       seq_item_port.item_done();
     
   end
  endtask
 
  
endclass