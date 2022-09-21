transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/writeback.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/sl2.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/signext.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/regfile.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/processor_arm.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/mux2.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/memory.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/maindec.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/imem.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/flopr.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/fetch.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/execute.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/decode.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/datapath.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/controller.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/aludec.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/alu.sv}
vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/adder.sv}
vcom -93 -work work {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/dmem.vhd}

vlog -sv -work work +incdir+/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3 {/home/ignacio/Projects/gitProjects/famaf/arqComputador/practico3/processor_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  processor_tb

add wave *
view structure
view signals
run -all
