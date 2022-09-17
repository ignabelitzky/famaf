transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905/writeback.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905/processor_arm.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905/memory.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905/decode.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905/datapath.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905/controller.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905/aludec.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1/sl2.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1/signext.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1/regfile.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1/mux2.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1/maindec.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1/imem.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1/flopr.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1/fetch.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1/execute.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1/alu.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico1/adder.sv}
vcom -93 -work work {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905/dmem.vhd}

vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico2/ModulosTP2-20220905/processor_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  processor_tb

add wave *
view structure
view signals
run -all
