onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /data_memory_tb/clk
add wave -noupdate /data_memory_tb/we
add wave -noupdate /data_memory_tb/addr
add wave -noupdate /data_memory_tb/wd
add wave -noupdate /data_memory_tb/rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {41361 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 308
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
WaveRestoreZoom {0 ps} {76099 ps}
