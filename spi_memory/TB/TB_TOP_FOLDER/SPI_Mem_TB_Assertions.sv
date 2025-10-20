//===========================================================
// Archivo : spi_mem_asserts.sv
// Descripción : Módulo de assertions y coberturas
//                para el diseño spi_mem.sv
// Autor: Grupo de Verificación
// Fecha: 2025-10-19
//===========================================================

import spi_mem_pkg::*;

module SPI_Mem_TB_Assertions (
  input logic clk,
  input logic rst,
  input logic cs,
  input logic miso,
  input logic ready,
  input logic mosi,
  input logic op_done,
  input state_type state,
  input int count
);

  //===========================================================
  // 1. Assertions básicas de reset y estados válidos
  //===========================================================
  property p_reset_state;
    @(posedge clk)
      rst |-> (state == idle && ready == 0 && op_done == 0 && mosi == 0);
  endproperty
  assert property(p_reset_state)
    else $error("FSM no vuelve a estado idle después del reset.");

  // Estado siempre válido
  assert property (@(posedge clk)
    (state inside {idle, detect, store,
                   send_addr, send_data, temp_del}))
    else $error("FSM en un estado no definido.");


  //===========================================================
  // 2. Transiciones válidas del FSM
  //===========================================================

  // idle → detect
  assert property (@(posedge clk)
    (state == idle && !cs) |=> (state == detect))
    else $error("FSM no pasó correctamente de idle a detect.");

  // detect → store
  assert property (@(posedge clk)
    (state == detect && miso) |=> (state == store))
    else $error("FSM no pasó correctamente a store (miso==1).");

  // detect → send_addr
  assert property (@(posedge clk)
    (state == detect && !miso) |=> (state == send_addr))
    else $error("FSM no pasó correctamente a send_addr (miso==0).");


  //===========================================================
  // 3. Rangos válidos de count
  //===========================================================

  // store: count ≤ 15
  assert property (@(posedge clk)
    (state == store) |-> (count <= 15))
    else $error("Count fuera de rango en estado STORE.");

  // send_data: count ≤ 7
  assert property (@(posedge clk)
    (state == send_data) |-> (count <= 7))
    else $error("Count fuera de rango en estado SEND_DATA.");


  //===========================================================
  // 4. Señales de control coherentes
  //===========================================================

  // op_done solo activo en estado idle
  assert property (@(posedge clk)
    op_done |-> (state == idle))
    else $error("op_done activo en un estado no permitido.");

  // ready solo activo durante temp_del o send_data
  assert property (@(posedge clk)
    ready |-> (state inside {temp_del, send_data}))
    else $error("ready activo fuera de los estados válidos.");


  //===========================================================
  // 5. Reglas del protocolo SPI
  //===========================================================

  // CS debe permanecer activo (bajo) durante la transacción
  property p_cs_during_op;
    @(posedge clk) disable iff (rst)
      (!cs) |-> (!op_done until cs);
  endproperty
  assert property(p_cs_during_op)
    else $error("CS se desactivó antes de finalizar la operación SPI.");


  //===========================================================
  // 6. Cobertura funcional
  //===========================================================

  // Escritura completa
  cover property (@(posedge clk)
    (state == store && count == 15 ##1 op_done))
    $display("[COVER] Escritura SPI completada correctamente.");

  // Lectura completa
  cover property (@(posedge clk)
    (state == send_data && count == 7 ##1 op_done))
    $display("[COVER] Lectura SPI completada correctamente.");

  // Idle después de operación
  cover property (@(posedge clk)
    (op_done ##1 state == idle))
    $display("[COVER] FSM vuelve a idle después de operación.");

endmodule
