onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /register_file_tb/clk
add wave -noupdate /register_file_tb/we3
add wave -noupdate /register_file_tb/a1
add wave -noupdate /register_file_tb/a2
add wave -noupdate /register_file_tb/a3
add wave -noupdate /register_file_tb/wd3
add wave -noupdate /register_file_tb/rd1
add wave -noupdate /register_file_tb/rd2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {167 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {138624 ps}
