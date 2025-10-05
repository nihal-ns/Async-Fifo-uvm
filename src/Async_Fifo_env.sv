`ifndef ASYNC_FIFO_ENV_INCLUDED_
`define ASYNC_FIFO_ENV_INCLUDED_

class Async_Fifo_env extends uvm_env;
	`uvm_component_utils(Async_Fifo_env)

	Read_agent read_agt;
	Write_agent write_agt;
	Virtual_sequencer v_seqr;
	Async_Fifo_scoreboard scb;
	/* Async_Fifo_coverage cov; */

	function new(string name = "Async_Fifo_env", uvm_component parent);
		super.new(name,parent);
	endfunction: new	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		read_agt = Read_agent::type_id::create("read_agt",this);
		write_agt = Write_agent::type_id::create("write_agt",this);

		set_config_int("write_agt","is_active",UVM_ACTIVE);
		set_config_int("read_agt","is_active",UVM_ACTIVE);

		scb = Async_Fifo_scoreboard::type_id::create("scb",this);
		/* cov = Async_Fifo_coverage::type_id::create("cov",this); */
		
		v_seqr = Virtual_sequencer::type_id::create("v_seqr",this);
	endfunction: build_phase	

	/* function void connect_phase(uvm_phase phase); */
	/* 	super.connect_phase(phase); */
	/* 	// should change the scb port names */ 
	/* 	write_agt.write_mon.write_item_port.connect(scb.write_port); */
	/* 	read_agt.read_mon.read_item_port.connect(scb.read_port); */
		
	/* 	// coverage port connect pending */
	/* 	/1* agt_act.mon_act.mon_collect_port.connect(cov.mon_act_cg_port); *1/ */
	/* 	/1* agt_pass.mon_pass.mon_collect_port.connect(cov.analysis_export); *1/ */

	/* 	v_seqr.sequencer_1 = read_agt.read_seqr; */
	/* 	v_seqr.sequencer_2 = write_agt.write_seqr; */

	/* endfunction: connect_phase */


	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		write_agt.write_mon.write_item_port.connect(scb.write_export);
		read_agt.read_mon.read_item_port.connect(scb.read_export);
		
		v_seqr.sequencer_1 = read_agt.read_seqr;
		v_seqr.sequencer_2 = write_agt.write_seqr;

	endfunction: connect_phase

endclass: Async_Fifo_env	

`endif
