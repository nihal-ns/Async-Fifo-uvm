`ifndef FIFO_PKG_INCLUDED_
`define FIFO_PKG_INCLUDED_

`include "uvm_macros.svh"
`define WIDTH 8

package fifo_pkg;
	import uvm_pkg::*;
	`include "r_seq.sv"
	`include "w_seq.sv"
	`include "Read_Fifo_sequencer.sv"
	`include "Write_Fifo_sequencer.sv"
	`include "read_sequence.sv"
	`include "write_sequence.sv"
	`include "Virtual_sequencer.sv"
	`include "virtual_sequence.sv"
	`include "Read_Fifo_driver.sv"
	`include "Write_Fifo_driver.sv"
	`include "Read_Fifo_monitor.sv"
	`include "Write_Fifo_monitor.sv"
	`include "Read_agent.sv"
	`include "Write_agent.sv"
	`include "Async_Fifo_scoreboard.sv"
	`include "Async_Fifo_subscriber.sv"
	`include "Async_Fifo_env.sv"
	`include "test.sv"
endpackage

`endif
