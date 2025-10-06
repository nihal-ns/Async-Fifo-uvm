`ifndef READ_SEQ_INCLUDED_ 
`define READ_SEQ_INCLUDED_ 

class read_sequence extends uvm_sequence#(r_seq); 
	`uvm_object_utils(read_sequence)               

	function new(string name = "read_sequence");  
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_info(get_type_name(),$sformatf("starting read sequence "), UVM_LOW) 
		req = r_seq::type_id::create("req");          
		start_item(req);
	if(!req.randomize() with {RINC ==0;})
		begin
			`uvm_error(get_type_name(),"randomization failed");
		end
		/* req.print(); */
		finish_item(req);
	endtask: body

endclass: read_sequence  

///////////////////////////////////////////////////
// read sequence with enable 
/////////////////////////////////////////////////
class read_seq1 extends read_sequence;
	`uvm_object_utils(read_seq1)

	function new(string name = "read_seq1");
		super.new(name);
	endfunction: new

	virtual task body();
		`uvm_do_with(req,{req.RINC == 1;});
	endtask: body

endclass: read_seq1

///////////////////////////////////////////////////
// rand read 
/////////////////////////////////////////////////
class rand_read extends read_sequence;
	`uvm_object_utils(rand_read)

	function new(string name = "rand_read");
		super.new(name);
	endfunction: new

	virtual task body();
	repeat(10) begin 
			`uvm_do(req);
		end
	`uvm_do_with(req,{req.RINC == 0;});
	endtask: body

endclass: rand_read


`endif
