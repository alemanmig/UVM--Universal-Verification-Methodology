- [Comandos para compialar el ejercicio UVM](#comandos-para-compialar-el-ejercicio-uvm)
  - [Para compilar los archivos .sv desde la carpeta /SIM en Questa:](#para-compilar-los-archivos-sv-desde-la-carpeta-sim-en-questa)
  - [Para correr cada uno de los test:](#para-correr-cada-uno-de-los-test)


# Comandos para compialar el ejercicio UVM

## Para compilar los archivos .sv desde la carpeta /SIM en Questa:

do SPI_Mem_Compilation.do

## Para correr cada uno de los test:

vsim -t ps -do "wave.do" -do "run -all" -coverage SPI_Mem_TB_Top +UVM_TESTNAME=SPI_Mem_TB_Read_Data_TestCase -vopt +acc

vsim -t ps -do "wave.do" -do "run -all" -coverage SPI_Mem_TB_Top +UVM_TESTNAME=SPI_Mem_TB_Write_Data_TestCase -vopt +acc

vsim -t ps -do "wave.do" -do "run -all" -coverage SPI_Mem_TB_Top +UVM_TESTNAME=SPI_Mem_TB_Rst_Dut_TestCase -vopt +acc

vsim -t ps -do "wave.do" -do "run -all" -coverage SPI_Mem_TB_Top +UVM_TESTNAME=SPI_Mem_TB_Writeb_Readb_TestCase -vopt +acc