`ifndef FIFO_IF_INCLUDED_
`define FIFO_IF_INCLUDED_
parameter WIDTH = 8;

interface Fifo_if(input bit WCLK, RCLK, WRST_n, RRST_n );
	logic WINC; 
	logic RINC; 
	logic [WIDTH -1:0] WDATA;
	logic [WIDTH -1:0] RDATA;
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

	modport READ_DRIVER(clocking read_mon_cb);
	modport WRITE_DRIVER(clocking write_mon_cb);
	modport READ_MONITOR(clocking read_drv_cb);
	modport WRITE_MONITOR(clocking write_drv_cb);

endinterface: Fifo_if

`endif
