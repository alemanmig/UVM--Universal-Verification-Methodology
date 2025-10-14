//==============================================================
// File: SPI_Mem_TB_Monitor.sv
// Description: SPI Monitor - SPI-MEMEMORY.
//
// Author: Grupo de Verificación
//==============================================================

class SPI_Mem_TB_SPI_Monitor extends uvm_monitor;
`uvm_component_utils(SPI_Mem_TB_SPI_Monitor)
 
uvm_analysis_port#(SPI_UVM_TB_SPI_Transaction) send;
SPI_Mem_TB_SPI_Transaction tr;
SPI_Mem_TB_If sm_if;

logic [15:0] din;
logic [7:0] dout;
 
    function new(input string inst = "SPI_Mem_TB_SPI_Monitor", uvm_component parent = null);
    super.new(inst,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tr = SPI_Mem_TB_SPI_Transaction::type_id::create("tr");
    send = new("send", this);
      if(!uvm_config_db#(virtual SPI_Mem_TB_If)::get(this,"","SPI_Mem_TB_If sm_if",sm_if))//uvm_test_top.env.agent.drv.aif
        `uvm_error("MON","Unable to access Interface");
    endfunction
    
    
    virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.clk);
      
      if(vif.rst)
        begin
        tr.op      = rstdut; 
        `uvm_info("MON", "SYSTEM RESET DETECTED", UVM_NONE);
        send.write(tr);
        end
        
        
      else begin
        @(posedge vif.clk);
             if(vif.miso && !vif.cs)
               begin
                       tr.op = writed;
                      @(posedge vif.clk);
              
                      for(int i = 0; i < 16 ; i++)
                       begin
                       din[i]  <= vif.miso; 
                       @(posedge vif.clk);
                       end
                       
                       tr.addr = din[7:0];
                       tr.din  = din[15:8];
                       
                      @(posedge vif.op_done);
                     `uvm_info("MON", $sformatf("DATA WRITE addr:%0d data:%0d",din[7:0],din[15:8]), UVM_NONE); 
                      send.write(tr);
              end
            else if (!vif.miso && !vif.cs)
              begin
                             tr.op = readd; 
                             @(posedge vif.clk);
                             
                               for(int i = 0; i < 8 ; i++)
                               begin
                               din[i]  <= vif.miso;  
                               @(posedge vif.clk);
                               end
                               tr.addr = din[7:0];
                               
                              @(posedge vif.ready);
                              
                              for(int i = 0; i < 8 ; i++)
                              begin
                              @(posedge vif.clk);
                              dout[i] = vif.mosi;
                              end
                               @(posedge vif.op_done);
                              tr.dout = dout;  
                             `uvm_info("MON", $sformatf("DATA READ addr:%0d data:%0d ",tr.addr,tr.dout), UVM_NONE); 
                             send.write(tr);
           end      
    end
end
   endtask 
 
endclass