`ifndef ASYNC_FIFO_SCOREBOARD_INCLUDED_
`define ASYNC_FIFO_SCOREBOARD_INCLUDED_

`uvm_analysis_imp_decl(_read_mon)
`uvm_analysis_imp_decl(_write_mon)

class Async_Fifo_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(Async_Fifo_scoreboard)

	uvm_analysis_imp_read_mon #(r_seq, Async_Fifo_scoreboard) read_export;
	uvm_analysis_imp_write_mon #(w_seq, Async_Fifo_scoreboard) write_export;

	w_seq write_packet_q[$];
	r_seq read_packet_q[$];

	localparam FIFO_DEPTH = 16; 
	logic [`WIDTH-1:0] fifo_q[$];

	function new(string name = "Async_Fifo_scoreboard", uvm_component parent);
		super.new(name,parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		write_export = new("write_export",this);
		read_export = new("read_export",this);
	endfunction: build_phase

	virtual function void write_write_mon(w_seq pkt);
		`uvm_info(get_type_name(), "Received a write packet from monitor.", UVM_HIGH)
		write_packet_q.push_back(pkt);
	endfunction: write_write_mon

	virtual function void write_read_mon(r_seq pkt);
		`uvm_info(get_type_name(), "Received a read packet from monitor.", UVM_HIGH)
		read_packet_q.push_back(pkt);
	endfunction: write_read_mon

	virtual task run_phase(uvm_phase phase);
		fork
			forever begin
				w_seq write_pkt;
				bit emulated_full;

				wait (write_packet_q.size() > 0);
				write_pkt = write_packet_q.pop_front();

				emulated_full = (fifo_q.size() == FIFO_DEPTH);

				if (write_pkt.WFULL != emulated_full) begin
					`uvm_error(get_type_name(), $sformatf("WFULL Flag Mismatch! DUT reported: %b, Scoreboard expected: %b", write_pkt.WFULL, emulated_full))
				end

				if (write_pkt.WINC) begin
					if (emulated_full) begin
						`uvm_error(get_type_name(), "FAIL: DUT permitted a write to a full FIFO.")
					end else begin
						`uvm_info(get_type_name(), $sformatf("SCOREBOARD: Storing data: %0d", write_pkt.WDATA), UVM_LOW)
						fifo_q.push_back(write_pkt.WDATA);
					end
				end
			end

			forever begin
				r_seq read_pkt;
				logic [`WIDTH-1:0] expected_data;
				bit emulated_empty;

				wait (read_packet_q.size() > 0);
				read_pkt = read_packet_q.pop_front();

				emulated_empty = (fifo_q.size() == 0);

				if (read_pkt.REMPTY != emulated_empty) begin
					`uvm_error(get_type_name(), $sformatf("REMPTY Flag Mismatch! DUT reported: %b, Scoreboard expected: %b", read_pkt.REMPTY, emulated_empty))
				end

				if (read_pkt.RINC) begin
					if (emulated_empty) begin
						`uvm_error(get_type_name(), "FAIL: DUT provided data from an empty FIFO.")
					end else begin
						expected_data = fifo_q.pop_front();
						if (read_pkt.RDATA == expected_data) begin
							`uvm_info(get_type_name(), $sformatf("PASS: Read data matched. Got: %0d, Expected: %0d", read_pkt.RDATA, expected_data), UVM_LOW)
						end else begin
							`uvm_error(get_type_name(), $sformatf("FAIL: Read data mismatch. Got: %0d, Expected: %0d", read_pkt.RDATA, expected_data))
						end
					end
				end
			end
		join_none
	endtask: run_phase

endclass: Async_Fifo_scoreboard

`endif
