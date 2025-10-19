//==============================================================
// File: SPI_Mem_TB_Monitor.sv
// Description: SPI Monitor - SPI-MEMEMORY.
//
// Author: Grupo de Verificación
//==============================================================

class SPI_Mem_TB_Spi_Monitor extends uvm_monitor;
`uvm_component_utils(SPI_Mem_TB_Spi_Monitor)
 
virtual SPI_Mem_TB_If sm_vif;

uvm_analysis_port#(SPI_Mem_TB_Spi_Transaction) send;
SPI_Mem_TB_Spi_Transaction tr;

logic [15:0] din;
logic [7:0] dout;
 
    function new(input string inst = "SPI_Mem_TB_Spi_Monitor", uvm_component parent = null);
    super.new(inst,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tr = SPI_Mem_TB_Spi_Transaction::type_id::create("tr");
    send = new("send", this);
      if(!uvm_config_db#(virtual SPI_Mem_TB_If)::get(this,"","SPI_Mem_TB_If",sm_vif))//uvm_test_top.env.agent.drv.aif
        `uvm_error("MON","Unable to access Interface");
    endfunction
    
    
    virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge sm_vif.clk);
      
      if(sm_vif.rst)
        begin
        tr.op      = rstdut; 
        `uvm_info("MON", "SYSTEM RESET DETECTED", UVM_NONE);
        send.write(tr);
        end
        
        
      else begin
        @(posedge sm_vif.clk);
             if(sm_vif.miso && !sm_vif.cs)
               begin
                       tr.op = writed;
                      @(posedge sm_vif.clk);
              
                      for(int i = 0; i < 16 ; i++)
                       begin
                       din[i]  <= sm_vif.miso; 
                       @(posedge sm_vif.clk);
                       end
                       
                       tr.addr = din[7:0];
                       tr.din  = din[15:8];
                       
                      @(posedge sm_vif.op_done);
                     `uvm_info("MON", $sformatf("DATA WRITE addr:%0d data:%0d",din[7:0],din[15:8]), UVM_NONE); 
                      send.write(tr);
              end
            else if (!sm_vif.miso && !sm_vif.cs)
              begin
                             tr.op = readd; 
                             @(posedge sm_vif.clk);
                             
                               for(int i = 0; i < 8 ; i++)
                               begin
                               din[i]  <= sm_vif.miso;  
                               @(posedge sm_vif.clk);
                               end
                               tr.addr = din[7:0];
                               
                              @(posedge sm_vif.ready);
                              
                              for(int i = 0; i < 8 ; i++)
                              begin
                              @(posedge sm_vif.clk);
                              dout[i] = sm_vif.mosi;
                              end
                               @(posedge sm_vif.op_done);
                              tr.dout = dout;  
                             `uvm_info("MON", $sformatf("DATA READ addr:%0d data:%0d ",tr.addr,tr.dout), UVM_NONE); 
                             send.write(tr);
           end      
    end
end
   endtask 
 
endclass