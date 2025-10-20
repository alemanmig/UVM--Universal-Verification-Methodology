

package spi_mem_pkg;

  typedef enum bit [2:0] { idle = 0, detect = 1, store = 2, send_addr = 3, send_data = 4, temp_del = 5} state_type;

endpackage