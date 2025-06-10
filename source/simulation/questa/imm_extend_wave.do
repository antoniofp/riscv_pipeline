onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /imm_extend_tb/instr
add wave -noupdate /imm_extend_tb/imm_src
add wave -noupdate /imm_extend_tb/imm_ext
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2507 ps} 0}
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
WaveRestoreZoom {10303 ps} {45499 ps}
