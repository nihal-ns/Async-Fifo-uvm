`ifndef Read_FIFO_MONITOR_INCLUDED_   
`define Read_FIFO_MONITOR_INCLUDED_  

class Read_Fifo_monitor extends uvm_monitor; 
	`uvm_component_utils(Read_Fifo_monitor)   
	int i;

	virtual Fifo_if vif;                  
	uvm_analysis_port #(r_seq) read_item_port;     

	function new(string name = "Read_Fifo_monitor", uvm_component parent);     
		super.new(name,parent);
	endfunction: new	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		read_item_port = new("read_item_port",this);           
		if(!uvm_config_db#(virtual Fifo_if)::get(this,"","vif",vif)) 
			`uvm_fatal("NO_VIF","virtual interface failed to get from config");
	endfunction: build_phase	

	task run_phase(uvm_phase phase);
		forever begin
			r_seq item = r_seq::type_id::create("item");
			item.RDATA = vif.RDATA; // this is sampled before so that the first read data is not missed
			repeat(1)@(vif.read_mon_cb);
			item.RINC = vif.RINC;
			item.REMPTY = vif.REMPTY;
			if(get_report_verbosity_level() >= UVM_HIGH)
				$display("Read Monitor: rinc:%0b | rempty:%0b | rdata:%0d", item.RINC, item.REMPTY, item.RDATA);
			read_item_port.write(item);
		end
	endtask: run_phase	

endclass: Read_Fifo_monitor  

`endif
