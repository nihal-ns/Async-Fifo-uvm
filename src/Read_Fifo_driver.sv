`ifndef Read_Fifo_DRIVER_INCLUDED_
`define Read_Fifo_DRIVER_INCLUDED_ 

class Read_Fifo_driver extends uvm_driver#(r_seq); 
	`uvm_component_utils(Read_Fifo_driver)          

	virtual Fifo_if vif;

	function new(string name = "Read_Fifo_driver", uvm_component parent);
		super.new(name, parent);
	endfunction: new	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual Fifo_if)::get(this,"","vif",vif)) begin            
			`uvm_fatal("NO_VIF","virtual interface failed to get from config")         
		end
	endfunction: build_phase

	virtual task run_phase(uvm_phase phase);
		@(vif.read_drv_cb);
		forever begin
			seq_item_port.get_next_item(req);
			drive();
			seq_item_port.item_done();
		end
	endtask: run_phase
	
	task drive();
		/* repeat(1)@(vif.read_drv_cb); */
		/* if(vif.RRST_n) begin */ 
			@(vif.read_drv_cb);
			vif.RINC <= req.RINC;
			`uvm_info(get_type_name(),$sformatf("Read Driver: rinc:%0b", req.RINC),UVM_LOW)
		/* end */
	endtask: drive

endclass: Read_Fifo_driver

`endif
