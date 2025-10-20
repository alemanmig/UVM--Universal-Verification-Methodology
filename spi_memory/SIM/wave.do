onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SPI_Mem_TB_Top/dut/clk
add wave -noupdate /SPI_Mem_TB_Top/dut/rst
add wave -noupdate /SPI_Mem_TB_Top/dut/cs
add wave -noupdate /SPI_Mem_TB_Top/dut/miso
add wave -noupdate /SPI_Mem_TB_Top/dut/ready
add wave -noupdate /SPI_Mem_TB_Top/dut/mosi
add wave -noupdate /SPI_Mem_TB_Top/dut/op_done
add wave -noupdate /SPI_Mem_TB_Top/dut/mem
add wave -noupdate /SPI_Mem_TB_Top/dut/count
add wave -noupdate /SPI_Mem_TB_Top/dut/datain
add wave -noupdate /SPI_Mem_TB_Top/dut/dataout
add wave -noupdate /SPI_Mem_TB_Top/dut/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {453 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {3219 ps}
