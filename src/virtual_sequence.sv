class virtual_sequence extends uvm_sequence;
	`uvm_object_utils(virtual_sequence)

	read_sequence seq_1;
	write_sequence seq_2;

	function new(string name = "virtual_sequence");
		super.new(name);
	endfunction: new

	virtual task body();
		Virtual_sequencer v_seqr;
		if(!$cast(v_seqr, m_sequencer)) begin
			`uvm_fatal(get_full_name(),"Virtual sequencer pointer cast failed")
		end

		seq_1 = read_sequence::type_id::create("seq_1");
		seq_2 = write_sequence::type_id::create("seq_2");

		`uvm_info(get_type_name(), "Executing write sequence...", UVM_MEDIUM)
		seq_2.start(v_seqr.sequencer_2);
		
		`uvm_info(get_type_name(), "Executing read sequence...", UVM_MEDIUM)
		seq_1.start(v_seqr.sequencer_1);

	endtask: body

endclass: virtual_sequence

////////////////////////////////////////////
// write and then read seq 
//////////////////////////////////////////
class virtual_write_read extends virtual_sequence;
	`uvm_object_utils(virtual_write_read)

	write_seq1 wr_seq;
	read_seq1 rd_seq;
	write_sequence seq_w;
	read_sequence seq_r;

	function new(string name = "virtual_write_read");
		super.new(name);
	endfunction: new

	virtual task body();
		Virtual_sequencer v_seqr;
		if(!$cast(v_seqr, m_sequencer)) begin
			`uvm_fatal(get_full_name(),"Virtual sequencer pointer cast failed")
		end

		wr_seq = write_seq1::type_id::create("wr_seq");
		rd_seq = read_seq1::type_id::create("rd_seq");
		seq_w = write_sequence::type_id::create("seq_w");
		seq_r = read_sequence::type_id::create("seq_r");

		seq_w.start(v_seqr.sequencer_2);
		repeat(16) begin
			wr_seq.start(v_seqr.sequencer_2);
		end
		seq_w.start(v_seqr.sequencer_2);

		seq_r.start(v_seqr.sequencer_1);
		repeat(16) begin
			rd_seq.start(v_seqr.sequencer_1);
		end
		seq_r.start(v_seqr.sequencer_1);
	endtask: body

endclass: virtual_write_read

////////////////////////////////////////////
// write and then read seq 
//////////////////////////////////////////
class virtual_rand_wr extends virtual_sequence;
	`uvm_object_utils(virtual_rand_wr)

	rand_write wr_seq;
	rand_read rd_seq;

	function new(string name = "virtual_rand_wr");
		super.new(name);
	endfunction: new

	virtual task body();
		Virtual_sequencer v_seqr;
		if(!$cast(v_seqr, m_sequencer)) begin
			`uvm_fatal(get_full_name(),"Virtual sequencer pointer cast failed")
		end

		wr_seq = rand_write::type_id::create("wr_seq");
		rd_seq = rand_read::type_id::create("rd_seq");
		wr_seq.start(v_seqr.sequencer_2);
		rd_seq.start(v_seqr.sequencer_1);
	endtask: body

endclass: virtual_rand_wr

////////////////////////////////////////////
// write full flag 
//////////////////////////////////////////
class virtual_write_full extends virtual_sequence;
	`uvm_object_utils(virtual_write_full)

	write_seq1 wr_seq;
	write_sequence seq_w;

	function new(string name = "virtual_write_full");
		super.new(name);
	endfunction: new

	virtual task body();
		Virtual_sequencer v_seqr;
		if(!$cast(v_seqr, m_sequencer)) begin
			`uvm_fatal(get_full_name(),"Virtual sequencer pointer cast failed")
		end

		wr_seq = write_seq1::type_id::create("wr_seq");
		seq_w = write_sequence::type_id::create("seq_w");

		seq_w.start(v_seqr.sequencer_2);
		repeat(17) begin
			wr_seq.start(v_seqr.sequencer_2);
		end
		seq_w.start(v_seqr.sequencer_2);

	endtask: body

endclass: virtual_write_full

////////////////////////////////////////////
// read empty flag 
//////////////////////////////////////////
class virtual_read_empty extends virtual_sequence;
	`uvm_object_utils(virtual_read_empty)

	read_seq1 rd_seq;
	read_sequence seq_r;
	write_seq1 wr_seq;
	write_sequence seq_w;

	function new(string name = "virtual_read_empty");
		super.new(name);
	endfunction: new

	virtual task body();
		Virtual_sequencer v_seqr;
		if(!$cast(v_seqr, m_sequencer)) begin
			`uvm_fatal(get_full_name(),"Virtual sequencer pointer cast failed")
		end

		rd_seq = read_seq1::type_id::create("rd_seq");
		seq_r = read_sequence::type_id::create("seq_r");

		wr_seq = write_seq1::type_id::create("wr_seq");
		seq_w = write_sequence::type_id::create("seq_w");

		seq_w.start(v_seqr.sequencer_2);
		repeat(3)
			wr_seq.start(v_seqr.sequencer_2);
		seq_w.start(v_seqr.sequencer_2);

		seq_r.start(v_seqr.sequencer_1);
		repeat(10) begin
			rd_seq.start(v_seqr.sequencer_1);
		end
		seq_r.start(v_seqr.sequencer_1);
	endtask: body

endclass: virtual_read_empty

////////////////////////////////////////////
// combination of all 
//////////////////////////////////////////
class virtual_wr extends virtual_sequence;
	`uvm_object_utils(virtual_wr)
	
	virtual_write_read seq_1;
	virtual_rand_wr seq_2;
	virtual_write_full seq_3;
	virtual_read_empty seq_4;

	function new(string name = "virtual_wr");
		super.new(name);
		seq_1 = virtual_write_read::type_id::create("seq_1");
		seq_2 = virtual_rand_wr::type_id::create("seq_3");
		seq_3 = virtual_write_full::type_id::create("seq_3");
		seq_4 = virtual_read_empty::type_id::create("seq_4");
	endfunction: new

	virtual task body();
		Virtual_sequencer v_seqr;
		if(!$cast(v_seqr, m_sequencer)) begin
			`uvm_fatal(get_full_name(),"Virtual sequencer pointer cast failed")
		end
	
		`uvm_do(seq_3)
		`uvm_do(seq_1)
		`uvm_do(seq_2)
		`uvm_do(seq_4)
		

	endtask: body

endclass: virtual_wr


