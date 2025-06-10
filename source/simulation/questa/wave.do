onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/clk
add wave -noupdate /top_tb/rst
add wave -noupdate /top_tb/cpu_dut/clk
add wave -noupdate /top_tb/cpu_dut/reset
add wave -noupdate /top_tb/cpu_dut/pc
add wave -noupdate /top_tb/cpu_dut/pc_target
add wave -noupdate /top_tb/cpu_dut/instr
add wave -noupdate /top_tb/cpu_dut/pc_src
add wave -noupdate /top_tb/cpu_dut/mem_write
add wave -noupdate /top_tb/cpu_dut/alu_src
add wave -noupdate /top_tb/cpu_dut/reg_write
add wave -noupdate /top_tb/cpu_dut/result_src
add wave -noupdate /top_tb/cpu_dut/imm_src
add wave -noupdate /top_tb/cpu_dut/alu_control
add wave -noupdate /top_tb/cpu_dut/rd1
add wave -noupdate /top_tb/cpu_dut/rd2
add wave -noupdate /top_tb/cpu_dut/result
add wave -noupdate /top_tb/cpu_dut/imm_ext
add wave -noupdate /top_tb/cpu_dut/alu_result
add wave -noupdate /top_tb/cpu_dut/src_a
add wave -noupdate /top_tb/cpu_dut/src_b
add wave -noupdate /top_tb/cpu_dut/zero
add wave -noupdate /top_tb/cpu_dut/read_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {384 ps} 0}
quietly wave cursor active 1
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {789 ps}
