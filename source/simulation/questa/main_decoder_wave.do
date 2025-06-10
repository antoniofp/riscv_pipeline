onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /main_decoder_tb/op
add wave -noupdate /main_decoder_tb/branch
add wave -noupdate /main_decoder_tb/jump
add wave -noupdate /main_decoder_tb/mem_write
add wave -noupdate /main_decoder_tb/alu_src
add wave -noupdate /main_decoder_tb/reg_write
add wave -noupdate /main_decoder_tb/result_src
add wave -noupdate /main_decoder_tb/imm_src
add wave -noupdate /main_decoder_tb/alu_op
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1443 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 271
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
WaveRestoreZoom {0 ps} {76743 ps}
