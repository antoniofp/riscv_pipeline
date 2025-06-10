transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source {C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source/top.v}
vlog -vlog01compat -work work +incdir+C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source {C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source/imm_extend.v}
vlog -vlog01compat -work work +incdir+C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source {C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source/data_memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source {C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source/control_unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source {C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source {C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source/main_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source {C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source/alu_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source {C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source/program_counter.v}
vlog -vlog01compat -work work +incdir+C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source {C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source/register_file.v}
vlog -vlog01compat -work work +incdir+C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source {C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source/instruction_memory.v}

vlog -vlog01compat -work work +incdir+C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source {C:/Users/janto/Desktop/FPGAs/riscv_single_cycle_processor/source/top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  top_tb

add wave *
view structure
view signals
run -all
