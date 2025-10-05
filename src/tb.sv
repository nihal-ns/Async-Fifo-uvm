// File: tb.sv
`include "FIFO.v"
`include "FIFO_memory.v"
`include "rptr_empty.v"
`include "wptr_full.v"
`include "two_ff_sync.v"
`timescale 1ns/1ps

module fifo_write_read_tb;

    // --- Parameters ---
    parameter DSIZE = 8;
    parameter ASIZE = 4;
    parameter DEPTH = 1 << ASIZE;
    // +++ CHANGE HERE: Set the number of writes AND reads +++
    parameter NUM_TRANSACTIONS = 16; // Try 14, 15, and 16

    // --- Signal Declarations ---
    reg  [DSIZE-1:0] wdata;
    wire [DSIZE-1:0] rdata;
    wire wfull, rempty;
    reg  winc, rinc, wclk, rclk, wrst_n, rrst_n;

    // --- Instantiate the DUT ---
    FIFO #(DSIZE, ASIZE) dut (
        .rdata(rdata), .wdata(wdata), .wfull(wfull), .rempty(rempty),
        .winc(winc),   .rinc(rinc),   .wclk(wclk),   .rclk(rclk),
        .wrst_n(wrst_n), .rrst_n(rrst_n)
    );

    // --- Clock Generation ---
    always #5 wclk = ~wclk;
    always #10 rclk = ~rclk;

    // --- Main Test Stimulus ---
    initial begin
        // 1. Initialize and reset
        wclk = 0; rclk = 0;
        wrst_n = 1; rrst_n = 1;
        winc = 0; rinc = 0;
        wdata = 0;
        #20;
        wrst_n = 0; rrst_n = 0;
        #20;
        wrst_n = 1; rrst_n = 1;
        #10;

        // +++ ENHANCED MONITORING +++
        $monitor("Time:%0t | winc:%b wfull:%b | rinc:%b rempty:%b | rdata:%d | wptr:%d rptr:%d ",
                 $time, winc, wfull, rinc, rempty, rdata, dut.wptr_full.wptr, dut.rptr_empty.rptr);

        // 2. Write Phase
        $display("\n--- Starting Write Phase (%0d items) ---", NUM_TRANSACTIONS);
        repeat (NUM_TRANSACTIONS) begin
            @(posedge wclk);
            winc = 1;
            wdata = wdata + 1;
        end
        @(posedge wclk);
        winc = 0; // Stop writing

        #20; // Small delay between writing and reading

        // 3. Read Phase
        $display("\n--- Starting Read Phase (%0d items) ---", NUM_TRANSACTIONS);
        repeat (NUM_TRANSACTIONS) begin
            @(posedge rclk);
            rinc = 1;
        end
        @(posedge rclk);
        rinc = 0; // Stop reading

        // 4. Wait to observe the final state
        #100;
        $display("\nTime: %0t | --- Test Finished ---", $time);
        $finish;
    end

endmodule
