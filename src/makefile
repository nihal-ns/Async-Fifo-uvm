all: vlog vsim

vlog:
	vlog -sv fifo_pkg.sv top.sv

vsim:
	vsim -c -do "run -all; quit" top

clean:
	rm -rf work transcript vsim_stacktrace.vstf simulation.log
