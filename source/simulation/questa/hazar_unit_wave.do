onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hazard_unit_tb/Rs1E
add wave -noupdate /hazard_unit_tb/Rs2E
add wave -noupdate /hazard_unit_tb/RdE
add wave -noupdate /hazard_unit_tb/Rs1D
add wave -noupdate /hazard_unit_tb/Rs2D
add wave -noupdate /hazard_unit_tb/RdM
add wave -noupdate /hazard_unit_tb/RdW
add wave -noupdate /hazard_unit_tb/RegWriteM
add wave -noupdate /hazard_unit_tb/RegWriteW
add wave -noupdate /hazard_unit_tb/ResultSrcE
add wave -noupdate /hazard_unit_tb/PCSrcE
add wave -noupdate /hazard_unit_tb/ForwardAE
add wave -noupdate /hazard_unit_tb/ForwardBE
add wave -noupdate /hazard_unit_tb/StallF
add wave -noupdate /hazard_unit_tb/StallD
add wave -noupdate /hazard_unit_tb/FlushD
add wave -noupdate /hazard_unit_tb/FlushE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11118 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 215
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
WaveRestoreZoom {0 ps} {62701 ps}
