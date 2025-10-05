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
		
		/* `uvm_info(get_type_name(), "Executing read sequence...", UVM_MEDIUM) */
		/* seq_1.start(v_seqr.sequencer_1); */

	endtask: body

endclass: virtual_sequence

////////////////////////////////////////////
// write and then read seq 
//////////////////////////////////////////
class virtual_write_read extends virtual_sequence;
	`uvm_object_utils(virtual_write_read)

	write_seq1 wr_seq;
	read_seq1 rd_seq;

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
		wr_seq.start(v_seqr.sequencer_2);
		rd_seq.start(v_seqr.sequencer_1);
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
