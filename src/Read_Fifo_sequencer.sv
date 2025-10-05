`ifndef READ_FIFO_SEQUENCER_INCLUDED_  
`define READ_FIFO_SEQUENCER_INCLUDED_ 

class Read_Fifo_sequencer extends uvm_sequencer#(r_seq);  
	`uvm_component_utils(Read_Fifo_sequencer)              

	function new(string name = "Read_Fifo_sequencer", uvm_component parent);
		super.new(name, parent);
	endfunction: new

endclass: Read_Fifo_sequencer	

`endif
