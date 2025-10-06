`uvm_analysis_imp_decl(_read_cg)

class Async_Fifo_subscriber extends uvm_subscriber#(w_seq);
	`uvm_component_utils(Async_Fifo_subscriber)

	uvm_analysis_imp_read_cg#(r_seq, Async_Fifo_subscriber) read_port;

	r_seq read_seq; 
	w_seq write_seq;
	real rd_cov, wr_cov;

// fifo read coverage 
	covergroup read_cvg;
    RINC_C: coverpoint read_seq.RINC {
			bins r_en_1 = {1};
			bins r_en_0 = {0};
		}
		RDATA_C: coverpoint read_seq.RDATA{
			option.auto_bin_max = 4;
		}
    EMPTY: coverpoint read_seq.REMPTY {
			bins empty_0 = {0};
			bins empty_1 = {1};
		}	
	endgroup

// fifo write coverage 
	covergroup write_cvg;
    WINC_C: coverpoint write_seq.WINC {
			bins w_en_1 = {1};
			bins w_en_0 = {0};
		}
		WDATA_C: coverpoint write_seq.WDATA {
			option.auto_bin_max = 4;
		}
    FULL_C: coverpoint write_seq.WFULL {
			bins full_0 = {0};
			bins full_1 = {1};
		}
	endgroup

	function new(string name = "Async_Fifo_subscriber", uvm_component parent);
		super.new(name, parent);
		read_cvg = new;
		write_cvg = new;
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		read_port = new("read_port", this);
	endfunction

	function void write(w_seq t);
		write_seq = t;
		write_cvg.sample();
	endfunction

	function void write_read_cg(r_seq t);
		read_seq = t;
		read_cvg.sample();
	endfunction

	function void extract_phase(uvm_phase phase);
		super.extract_phase(phase);
		rd_cov = read_cvg.get_coverage();
		wr_cov = write_cvg.get_coverage();
	endfunction

	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info(get_type_name, $sformatf("read Coverage ------> %0.2f%%,", rd_cov), UVM_MEDIUM);
		`uvm_info(get_type_name, $sformatf("write Coverage ------> %0.2f%%", wr_cov), UVM_MEDIUM);
	endfunction

endclass
