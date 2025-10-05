`ifndef W_SEQ_ITEM_INCLUDED_  
`define W_SEQ_ITEM_INCLUDED_  

class w_seq extends uvm_sequence_item;     	      
		
	rand logic WINC;
	rand logic [`WIDTH-1:0] WDATA;
	
	bit WFULL;

	`uvm_object_utils_begin(w_seq)
		`uvm_field_int(WINC, UVM_ALL_ON)
		`uvm_field_int(WDATA, UVM_ALL_ON)
		`uvm_field_int(WFULL, UVM_ALL_ON)
	`uvm_object_utils_end

	function new(string name = "w_seq");
		super.new(name);
	endfunction: new

endclass: w_seq

`endif
