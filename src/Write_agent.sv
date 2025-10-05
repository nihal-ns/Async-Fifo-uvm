`ifndef WRITE_AGENT_INCLUDED_
`define WRITE_AGENT_INCLUDED_

class Write_agent extends uvm_agent; 
	`uvm_component_utils(Write_agent) 

	Write_Fifo_driver write_drv;     
	Write_Fifo_monitor write_mon;   
	Write_Fifo_sequencer write_seqr; 

	function new(string name = "Write_agent", uvm_component parent);      
		super.new(name,parent);
	endfunction: new	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(get_is_active() == UVM_ACTIVE) begin
			write_drv = Write_Fifo_driver::type_id::create("write_drv",this);       
			write_seqr = Write_Fifo_sequencer::type_id::create("write_seqr",this); 
		end
		write_mon = Write_Fifo_monitor::type_id::create("write_mon",this);    
	endfunction: build_phase	

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if (get_is_active() == UVM_ACTIVE) begin            
			write_drv.seq_item_port.connect(write_seqr.seq_item_export);
		end
	endfunction: connect_phase

endclass: Write_agent

`endif
