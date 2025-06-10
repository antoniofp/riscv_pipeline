onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /program_counter_tb/clk
add wave -noupdate /program_counter_tb/reset
add wave -noupdate /program_counter_tb/pc_next
add wave -noupdate /program_counter_tb/pc
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14024 ps} 0}
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
WaveRestoreZoom {0 ps} {78560 ps}
