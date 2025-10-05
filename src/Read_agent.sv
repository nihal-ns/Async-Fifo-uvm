`ifndef READ_AGENT_INCLUDED_
`define READ_AGENT_INCLUDED_

class Read_agent extends uvm_agent;  
	`uvm_component_utils(Read_agent)  

	Read_Fifo_driver read_drv;            
	Read_Fifo_monitor read_mon;          
	Read_Fifo_sequencer read_seqr;      

	function new(string name = "Read_agent", uvm_component parent);        
		super.new(name,parent);
	endfunction: new	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(get_is_active() == UVM_ACTIVE) begin
			read_drv = Read_Fifo_driver::type_id::create("read_drv",this);          
			read_seqr = Read_Fifo_sequencer::type_id::create("read_seqr",this);    
		end
		read_mon = Read_Fifo_monitor::type_id::create("read_mon",this);    
	endfunction: build_phase	

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(get_is_active() == UVM_ACTIVE) begin              
			read_drv.seq_item_port.connect(read_seqr.seq_item_export); 
		end
	endfunction: connect_phase

endclass: Read_agent

`endif
