`include "uvm_macros.svh"
`include "defines.sv"
`include "Async_Fifo_interface.sv"
`include "fifo_pkg.sv"  
`include "FIFO.v"

`include "Async_Fifo_assertion.sv"

import uvm_pkg::*;
import fifo_pkg::*; 

module top;
	bit WCLK, RCLK;
	bit WRST_n, RRST_n;
	
	always #5 WCLK = ~WCLK;
	always #10 RCLK = ~RCLK;

  initial begin
    WRST_n = 0;
		repeat(2) @(negedge WCLK);
    WRST_n = 1;
  end
	
  initial begin
		RRST_n = 0;
		repeat(1) @(negedge RCLK);
		RRST_n = 1;
	end

	Fifo_if intf(WCLK, RCLK, WRST_n, RRST_n);

	// design dut connection
	FIFO DUT (
		.wclk(WCLK),
		.rclk(RCLK),
		.wrst_n(WRST_n),
		.rrst_n(RRST_n),
		.winc(intf.WINC),
		.rinc(intf.RINC),
		.wfull(intf.WFULL),
		.rempty(intf.REMPTY),
		.wdata(intf.WDATA),
		.rdata(intf.RDATA)
		);

	bind intf  Async_Fifo_assertion ASSERT(.*);

	initial begin
		uvm_config_db#(virtual Fifo_if)::set(null,"*","vif",intf);
	end

	initial begin
		run_test("w_r_test");	
		/* run_test("write_full_test"); */	
		/* run_test("comb_test"); */	
		#100 $finish;
	end
endmodule	
