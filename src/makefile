all: vlog vsim

vlog:
	vlog -sv fifo_pkg.sv top.sv

vsim:
	vsim -c -do "run -all; quit" top

clean:
	rm -rf work transcript vsim_stacktrace.vstf simulation.log coverage.ucdb covReport tb.log

cover:
	vlog -sv +acc +cover +fcover -l top.log top.sv
	vsim -vopt work.top -voptargs=+acc=npr -assertdebug -l simulation.log -coverage -c -do "coverage save -onexit -assert -directive -cvg -codeAll coverage.ucdb; run -all; exit"
	vcover report -html coverage.ucdb -htmldir covReport -details
