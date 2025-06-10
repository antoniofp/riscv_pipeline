transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/edwin/Desktop/riscv_pipeline/source {C:/Users/edwin/Desktop/riscv_pipeline/source/program_counter.v}

vlog -vlog01compat -work work +incdir+C:/Users/edwin/Desktop/riscv_pipeline/source {C:/Users/edwin/Desktop/riscv_pipeline/source/program_counter_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  program_counter_tb

add wave *
view structure
view signals
run -all
