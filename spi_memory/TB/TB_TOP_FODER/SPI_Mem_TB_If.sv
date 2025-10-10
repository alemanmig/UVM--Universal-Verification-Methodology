///////////////////////////////////////////
// SPI Memory
// SPI_Mem_TB_If.sv
// SPI Memory interface
//////////////////////////////////////////////

interface spi_i;
 
    logic clk, rst, cs, miso;
    logic ready, mosi, op_done;
      
endinterface