onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/clk
add wave -noupdate /top_tb/rst
add wave -noupdate -radix unsigned /top_tb/cpu_dut/alu_unit/src_a
add wave -noupdate -radix unsigned /top_tb/cpu_dut/alu_unit/src_b
add wave -noupdate -radix unsigned /top_tb/cpu_dut/alu_unit/alu_control
add wave -noupdate -radix unsigned /top_tb/cpu_dut/alu_unit/result
add wave -noupdate -radix unsigned /top_tb/cpu_dut/PCF
add wave -noupdate /top_tb/cpu_dut/StallF
add wave -noupdate /top_tb/cpu_dut/StallD
add wave -noupdate /top_tb/cpu_dut/FlushD
add wave -noupdate /top_tb/cpu_dut/FlushE
add wave -noupdate /top_tb/cpu_dut/ForwardAE
add wave -noupdate /top_tb/cpu_dut/ForwardBE
add wave -noupdate /top_tb/cpu_dut/PCPlus4F
add wave -noupdate /top_tb/cpu_dut/PCPlus4D
add wave -noupdate /top_tb/cpu_dut/PCPlus4E
add wave -noupdate /top_tb/cpu_dut/PCPlus4M
add wave -noupdate /top_tb/cpu_dut/PCPlus4W
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 237
configure wave -valuecolwidth 138
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
configure wave -timelineunits ns
update
WaveRestoreZoom {362 ps} {498 ps}
