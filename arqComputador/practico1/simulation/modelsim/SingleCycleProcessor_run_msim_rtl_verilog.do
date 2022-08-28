transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1/signext.sv}

vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1/signext_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  signext_tb

add wave *
view structure
view signals
run -all
