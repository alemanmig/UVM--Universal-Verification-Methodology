#######################################################################################
#
# This is the compilation file for the SPI Memory RTL and its testbench
#
#######################################################################################



# RTL files for compilation
vlog -cover bcest ../RTL/SPI_Mem.sv

#######################################################################################

# TB files for compilation
#vlog ../TB/TB_TOP_FOLDER/SoftErrorTol_GPIO_TB_Data_Types_pkg.svh
