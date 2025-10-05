`ifndef R_SEQ_ITEM_INCLUDED_  
`define R_SEQ_ITEM_INCLUDED_  

class r_seq extends uvm_sequence_item;     	      
		
	rand logic RINC;
	
	bit REMPTY;
	logic [`WIDTH-1:0] RDATA;

	`uvm_object_utils_begin(r_seq)
		`uvm_field_int(RINC, UVM_ALL_ON)
		`uvm_field_int(REMPTY, UVM_ALL_ON)
		`uvm_field_int(RDATA, UVM_ALL_ON)	
	`uvm_object_utils_end

	function new(string name = "r_seq");
		super.new(name);
	endfunction: new

endclass: r_seq

`endif
