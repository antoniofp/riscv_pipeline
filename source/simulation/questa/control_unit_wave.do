onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_unit_tb/clk
add wave -noupdate /control_unit_tb/op
add wave -noupdate /control_unit_tb/funct3
add wave -noupdate /control_unit_tb/funct7_5
add wave -noupdate /control_unit_tb/zero
add wave -noupdate /control_unit_tb/pc_src
add wave -noupdate /control_unit_tb/mem_write
add wave -noupdate /control_unit_tb/alu_src
add wave -noupdate /control_unit_tb/reg_write
add wave -noupdate /control_unit_tb/result_src
add wave -noupdate /control_unit_tb/imm_src
add wave -noupdate /control_unit_tb/alu_control
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {1086 ps}
