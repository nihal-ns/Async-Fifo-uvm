program Async_Fifo_assertion(RDATA, WFULL, REMPTY, WDATA, WINC, WCLK, WRST_n, RINC, RCLK, RRST_n);
	
parameter DSIZE  = 8;
	input [DSIZE-1:0] RDATA, WDATA;
	input WFULL, REMPTY, WINC, WCLK, WRST_n, RINC, RCLK, RRST_n;

	property wrst_check;
		@(posedge WCLK) (!WRST_n) |-> !WFULL;
	endproperty

	property rrst_check;
		@(posedge RCLK) (!RRST_n) |-> (REMPTY && !RDATA);
	endproperty

	property winc_check;
		@(posedge WCLK) (WRST_n && !WINC) |-> WFULL == $past(WFULL,1);
	endproperty

	property rinc_check;
		@(posedge RCLK) (RRST_n && !RINC) |-> RDATA == $past(RDATA,1);
	endproperty

	property unknown_check;
		@(posedge RCLK)
			##2 ($isunknown(WRST_n) || $isunknown(RRST_n) || $isunknown(WINC) || $isunknown(RINC) || $isunknown(WDATA) || $isunknown(RDATA) || $isunknown(WFULL) || $isunknown(REMPTY)) == 0 ;
 	endproperty		

	assert property (wrst_check)
		$display("write reset assertion pass");
	else
		$display("Assertion fail");

	assert property (rrst_check)
		$display("read reset assertion pass");
	else
		$display("Assertion fail");

	assert property (winc_check)
		$display("winc: Assertion pass");
	else
		$display("Assertion fail");

	assert property (rinc_check)
		$display("rinc: Assertion pass");
	else
		$display("Assertion fail");

	assert property (unknown_check)
		$display("Assertion pass, No signals are unknown");
	else
		$display("Assertion fail");
endprogram
