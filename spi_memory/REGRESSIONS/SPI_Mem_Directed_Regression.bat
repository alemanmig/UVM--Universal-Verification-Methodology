@echo off
mkdir REGRESSION_RESULTS
vsim -batch -do ../SIM/SPI_Mem_Compilation.do -logfile Compilation_SPI_Mem_TB.txt -do "quit -f"
vsim -batch -t ps -coverage SPI_Mem_TB_Top +UVM_TESTNAME=SPI_Mem_TB_Read_Data_TestCase -logfile Run_SPI_Mem_TB_Read_Data_TestCase.txt -do "coverage save -onexit Coverage_SPI_Mem_TB_Read_Data_TestCase.ucdb" -do "run -all" 
vsim -batch -t ps -coverage SPI_Mem_TB_Top +UVM_TESTNAME=SPI_Mem_TB_Write_Data_TestCase -logfile Run_SPI_Mem_TB_Write_Data_TestCase.txt -do "coverage save -onexit Coverage_SPI_Mem_TB_Write_Data_TestCase.ucdb" -do "run -all"
vsim -batch -t ps -coverage SPI_Mem_TB_Top +UVM_TESTNAME=SPI_Mem_TB_Rst_Dut_TestCase -logfile Run_SPI_Mem_TB_Rst_Dut_TestCase.txt -do "coverage save -onexit Coverage_SPI_Mem_TB_Rst_Dut_TestCase.ucdb" -do "run -all"
vsim -batch -t ps -coverage SPI_Mem_TB_Top +UVM_TESTNAME=SPI_Mem_TB_Writeb_Readb_TestCase -logfile Run_SPI_Mem_TB_Writeb_Readb_TestCase.txt -do "coverage save -onexit Coverage_SPI_Mem_TB_Writeb_Readb_TestCase.ucdb" -do "run -all"
vsim -batch -do "vcover merge -64 coverage_regression.ucdb *.ucdb" -do "quit -f"
move coverage_regression.ucdb REGRESSION_RESULTS
move *.txt REGRESSION_RESULTS
move REGRESSION_RESULTS "DIRECTED_REGRESSION_RESULTS_DATE_%date:~-4,4%-%date:~-7,2%-%date:~-10,2%_TIME_%time:~0,2%-%time:~3,2%-%time:~6,2%"
del *.ucdb
rmdir /s /q "work"