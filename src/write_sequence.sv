`ifndef WRITE_SEQ_INCLUDED_ 
`define WRITE_SEQ_INCLUDED_

class write_sequence extends uvm_sequence#(w_seq); 
	`uvm_object_utils(write_sequence)               

	function new(string name = "write_sequence");  
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_info(get_type_name(),$sformatf("Starting write sequence"), UVM_LOW) 
		req = w_seq::type_id::create("req");          
		start_item(req);
		if(!req.randomize() with { WINC == 1;})
		begin
			`uvm_error(get_type_name(), "Randomization failed");
		end
		/* req.print(); */
		finish_item(req);
	endtask: body

endclass: write_sequence 

///////////////////////////////////////////////
// write six times 
//////////////////////////////////////////////
class write_seq1 extends write_sequence;
	`uvm_object_utils(write_seq1)

	function new(string name = "write_seq1");
		super.new(name);
	endfunction: new

	virtual task body();
		repeat(17) begin 
			`uvm_do_with(req,{req.WINC == 1;});
		end
		`uvm_do_with(req,{req.WINC == 0;});
	endtask: body

endclass: write_seq1

///////////////////////////////////////////////
// rand write 
//////////////////////////////////////////////
class rand_write extends write_sequence;
	`uvm_object_utils(rand_write)

	function new(string name = "rand_write");
		super.new(name);
	endfunction: new

	virtual task body();
		repeat(10) begin 
			`uvm_do(req);
		end
		`uvm_do_with(req,{req.WINC ==0;})
	endtask: body

endclass: rand_write


`endif
