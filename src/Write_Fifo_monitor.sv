`ifndef WRITE_FIFO_MONITOR_INCLUDED_   
`define WRITE_FIFO_MONITOR_INCLUDED_  

class Write_Fifo_monitor extends uvm_monitor; 
	`uvm_component_utils(Write_Fifo_monitor)   

	virtual Fifo_if vif;                   
	uvm_analysis_port #(w_seq) write_item_port;      

	function new(string name = "Write_Fifo_monitor", uvm_component parent);     
		super.new(name,parent);
	endfunction: new	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		write_item_port = new("write_item_port",this);         
		if(!uvm_config_db#(virtual Fifo_if)::get(this,"","vif",vif))      
			`uvm_fatal("NO_VIF","virtual interface failed to get from config");
	endfunction: build_phase	

	task run_phase(uvm_phase phase);
		w_seq item = w_seq::type_id::create("item");
		@(vif.write_mon_cb);
		forever begin
			@(vif.write_mon_cb);
			item.WINC = vif.WINC;
			item.WFULL = vif.WFULL;
			item.WDATA = vif.WDATA;
			if(get_report_verbosity_level() >= UVM_HIGH) begin 
				$display("%0t |||Write Monitor: winc:%0b | wfull:%0b | wdata:%0d",$time, vif.WINC, vif.WFULL, vif.WDATA);
			end
			write_item_port.write(item);
		end
	endtask: run_phase	

endclass: Write_Fifo_monitor  

`endif
