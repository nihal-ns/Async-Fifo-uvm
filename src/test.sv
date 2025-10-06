class test extends uvm_test;
	`uvm_component_utils(test)

	Async_Fifo_env env;
	virtual_sequence v_seq;

	function new(string name = "test", uvm_component parent = null);
		super.new(name,parent);
	endfunction	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = Async_Fifo_env::type_id::create("env",this);
		v_seq = virtual_sequence::type_id::create("v_seq");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		v_seq.start(env.v_seqr);
		phase.drop_objection(this);
	endtask

endclass

////////////////////////////////////////
// write and then read test
//////////////////////////////////////
class w_r_test extends test;
	`uvm_component_utils(w_r_test)

	virtual_write_read v_seq_1;

	function new(string name = "w_r_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		v_seq_1 = virtual_write_read::type_id::create("v_seq_1");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		v_seq_1.start(env.v_seqr);
		phase.drop_objection(this);
	endtask

endclass

/////////////////////////////
// rand write and then rand read
//////////////////////////////////////
class rand_wr_test extends test;
	`uvm_component_utils(rand_wr_test)

	virtual_rand_wr v_seq_1;

	function new(string name = "rand_wr_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		v_seq_1 = virtual_rand_wr::type_id::create("v_seq_1");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		v_seq_1.start(env.v_seqr);
		phase.drop_objection(this);
	endtask

endclass

/////////////////////////////
// write full flag test
//////////////////////////////////////
class write_full_test extends test;
	`uvm_component_utils(write_full_test)

	virtual_write_full v_seq_1;

	function new(string name = "write_full_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		v_seq_1 = virtual_write_full::type_id::create("v_seq_1");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		v_seq_1.start(env.v_seqr);
		phase.drop_objection(this);
	endtask

endclass

/////////////////////////////
// read empty flag test
//////////////////////////////////////
class read_empty_test extends test;
	`uvm_component_utils(read_empty_test)

	virtual_read_empty v_seq_1;

	function new(string name = "read_empty_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		v_seq_1 = virtual_read_empty::type_id::create("v_seq_1");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		v_seq_1.start(env.v_seqr);
		phase.drop_objection(this);
	endtask

endclass
/////////////////////////////
// all test
//////////////////////////////////////
class comb_test extends test;
	`uvm_component_utils(comb_test)

	virtual_wr v_seq_1;

	function new(string name = "comb_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		v_seq_1 = virtual_wr::type_id::create("v_seq_1");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		repeat(100)
		v_seq_1.start(env.v_seqr);
		phase.drop_objection(this);
	endtask

endclass
