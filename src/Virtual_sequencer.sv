`ifndef VIRTUAL_SEQUENCER_INCLUDED_  
`define VIRTUAL_SEQUENCER_INCLUDED_ 

class Virtual_sequencer extends uvm_sequencer#(uvm_sequence_item); 
	`uvm_component_utils(Virtual_sequencer)                

	Read_Fifo_sequencer sequencer_1;
	Write_Fifo_sequencer sequencer_2;

	function new(string name = "Virtual_sequencer", uvm_component parent);
		super.new(name, parent);
	endfunction: new

endclass: Virtual_sequencer	

`endif
