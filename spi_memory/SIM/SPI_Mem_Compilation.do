#######################################################################################
#
# This is the compilation file for the SPI Memory RTL and its testbench
#
#######################################################################################



# RTL files for compilation
vlog -cover bcest ../RTL/SPI_Mem.sv

#######################################################################################

# TB files for compilation

vlog ../TB/TB_TOP_FOLDER/SPI_Mem_TB_Data_Types_pkg.svh
#vlog ../TB/UVM_SPI_PKG/SPI_Mem_TB_Config.sv
vlog ../TB/UVM_SPI_PKG/UVM_SPI_Mem_TB_Spi_pkg.svh +incdir+./../TB/UVM_SPI_PKG
# vlog ../TB/UVM_REF_MODEL/UVM_SPI_Mem_TB_Ref_Model_pkg.svh +incdir+./../UVM_REF_MODEL
vlog ../TB/UVM_TB_TOP_PKG/UVM_SPI_Mem_TB_Top_pkg.svh +incdir+./../MISC +incdir+./../UVM_TB_TOP_PKG    

#########################################################################################

vlog ../TB/UVM_SEQ_PKG/UVM_SPI_Mem_TB_Sequences_pkg.svh +incdir+./../MISC +incdir+./../UVM_SEQ_PKG
vlog ../TB/UVM_TEST_PKG/UVM_SPI_Mem_TB_Tests_pkg.svh +incdir+./../TB/UVM_TESTS_PKG
vlog ../TB/TB_TOP_FOLDER/SPI_Mem_TB_pkg.svh
vlog ../TB/TB_TOP_FOLDER/SPI_Mem_TB_If.sv +incdir+./../MISC
# vlog ../TB/TB_TOP_FOLDER/SPI_Mem_TB_Assertions.sv +incdir+./../MISC
vlog ../TB/TB_TOP_FOLDER/SPI_Mem_TB_Top.sv +incdir+./../MISC
