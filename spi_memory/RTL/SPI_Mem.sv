//////////////////////
// SPI Memory
// File: spi_mem.sv
//////////////////////

import spi_mem_pkg::*;

module spi_mem(
input clk, rst, cs, miso,
output reg ready, mosi, op_done
);
 
state_type state = idle;

reg [7:0] mem [31:0] = '{default:0};
integer count = 0;
reg [15:0] datain;
reg [7:0]  dataout;
 

always@(posedge clk)
begin
      if(rst) 
          begin
             state <= idle;
             count <= 0;
             mosi  <= 0;
             ready <= 0;
             op_done <= 0;
             
          end
     else
         begin
                case(state)
                  idle: begin
                    count <= 0;
                    mosi  <= 0;
                    ready <= 0;
                    op_done <= 0;
                    datain <= 0;
                  
                     if(!cs)
                       state <= detect;
                     else
                       state <= idle;
                  end
                  
                    
                  detect: begin 
                      if(miso)
                        state <= store; ///write 
                      else
                        state <= send_addr;   ///read
                   end
                   
                    
                   store: begin
                      if(count <= 15) begin
                        datain[count]     <= miso;
                        count             <= count + 1;
                        state             <= store;
                      end
                      else
                        begin
                         mem[datain[7:0]]  <= datain[15:8];
                         state <= idle;
                         count <= 0;
                         op_done <= 1'b1;
                        end
                    end
                    
                    send_addr: begin
                      if(count <= 7) begin
                       count <= count + 1;
                       datain[count] <= miso;
                       state <= send_addr;
                       end
                       else begin
                       count <= 0;
                       state <= temp_del;
                       ready <= 1'b0;
                       dataout <= mem[datain];
                       end
                    end
                    
                    temp_del : begin
                     state <= send_data;
                     ready <= 1'b1;
                     count <=  1;
                     mosi  <= dataout[0];
                    end
                       
                    send_data: begin
                       
                       if(count <= 7) 
                       begin
                        count <= count + 1;
                        mosi  <= dataout[count]; 
                        state <= send_data;
                       end 
                       else
                         begin
                         count <= 0;
                         state <= idle;
                         op_done <= 1'b1;
                         end     
                    end   
                    
                    default : state <= idle;
                    
                 endcase
          end
      end
endmodule