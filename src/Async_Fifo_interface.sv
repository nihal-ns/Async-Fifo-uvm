`ifndef FIFO_IF_INCLUDED_
`define FIFO_IF_INCLUDED_

interface Fifo_if(input bit WCLK, RCLK, WRST_n, RRST_n );
	bit WINC; 
	bit RINC; 
	logic [`ASIZE -1:0] WDATA;
	logic [`ASIZE -1:0] RDATA;
	logic WFULL;
	logic REMPTY;

	clocking read_mon_cb@(posedge RCLK);
		default input #0 output #0;
		input RINC, REMPTY, RDATA;
	endclocking

	clocking write_mon_cb@(posedge WCLK);
		default input #0 output #0;
		input WINC, WFULL, WDATA;
	endclocking

	clocking read_drv_cb@(posedge RCLK);
		default input #0 output #0;
		output RINC;
	endclocking

	clocking write_drv_cb@(posedge WCLK);
		default input #0 output #0;
		output WINC, WDATA;
	endclocking

	modport READ_DRIVER(clocking read_mon_cb,input RCLK);
	modport WRITE_DRIVER(clocking write_mon_cb,input WCLK);
	modport READ_MONITOR(clocking read_drv_cb,input RCLK);
	modport WRITE_MONITOR(clocking write_drv_cb,input WCLK);

endinterface: Fifo_if

`endif
