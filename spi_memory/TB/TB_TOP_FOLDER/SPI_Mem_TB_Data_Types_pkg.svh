/////////////////////////////////////////////////////////////////
//
// Ejercicio: Verificación de SPI_Mem
// UVM - SPI_Mem_TB_Data_Types_pkg.sv
// Data Types 
//
///////////////////////////////////////////////////////////////////

  package SPI_Mem_TB_Data_Types_pkg;

   typedef enum bit [1:0]   {readd = 0, writed = 1, rstdut = 2} oper_mode;

  endpackage