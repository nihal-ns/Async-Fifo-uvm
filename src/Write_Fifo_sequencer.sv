`ifndef WRITE_FIFO_SEQUENCER_INCLUDED_  
`define WRITE_FIFO_SEQUENCER_INCLUDED_ 

class Write_Fifo_sequencer extends uvm_sequencer#(w_seq);  
	`uvm_component_utils(Write_Fifo_sequencer)              

	function new(string name = "Write_Fifo_sequencer", uvm_component parent);
		super.new(name, parent);
	endfunction: new

endclass: Write_Fifo_sequencer	

`endif
