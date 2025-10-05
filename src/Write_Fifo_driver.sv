`ifndef Write_Fifo_DRIVER_INCLUDED_   
`define Write_Fifo_DRIVER_INCLUDED_  

class Write_Fifo_driver extends uvm_driver#(w_seq); 
	`uvm_component_utils(Write_Fifo_driver)          

	virtual Fifo_if vif; 

	function new(string name = "Write_Fifo_driver", uvm_component parent);
		super.new(name, parent);
	endfunction: new	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual Fifo_if)::get(this,"","vif",vif)) begin    
			`uvm_fatal("NO_VIF","virtual interface failed to get from config") 
		end
	endfunction: build_phase

	virtual task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			drive(req);
			seq_item_port.item_done();
		end
	endtask: run_phase
	
	task drive(w_seq req);
		/* repeat(1)@(vif.write_drv_cb); */
		vif.WINC <= req.WINC;
		vif.WDATA <= req.WDATA;
		`uvm_info(get_type_name(),$sformatf("Write Driver: winc:%0b | Wdata: %0d", req.WINC, req.WDATA),UVM_LOW)
		@(vif.write_drv_cb);
	endtask: drive

endclass: Write_Fifo_driver

`endif
