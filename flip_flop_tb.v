`include "flip_flops.v"
`timescale 1ns / 1ps
// Test module for all flip flops

module flip_flop_tb;
    reg clk, reset;
    reg t, j, k;
    wire q_tff, q_jkff;

    // Instantiate T Flip-Flop
    tff tff_inst (
        .t(t),
        .clk(clk),
        .reset(reset),
        .q(q_tff)
    );

    // Instantiate JK Flip-Flop
    jkff jkff_inst (
        .j(j),
        .k(k),
        .clk(clk),
        .reset(reset),
        .q(q_jkff)
    );

    // Clock Generation
    always #5 clk = ~clk; // Toggle clock every 5 ns

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        t = 0;
        j = 0;
        k = 0;

        #10 reset = 0; // Release reset after 10 ns

        // Test T Flip-Flop
        #10 t = 1;
        #10 t = 0;
        #10 t = 1;
        #10 t = 1;

        // Test JK Flip-Flop
        #20 j = 1; k = 0; // Set
        #10 j = 0; k = 1; // Reset
        #10 j = 1; k = 1; // Toggle
        #10 j = 0; k = 0; // Hold

        #50 $finish; // End simulation
    end

    // Monitor output
    initial begin
        $dumpfile("flip_flop_tb.vcd"); // Dump waveform for Verilator
        $dumpvars(0, flip_flop_tb);
        $monitor("Time=%0t | T=%b | Q_TFF=%b | J=%b K=%b | Q_JKFF=%b", $time, t, q_tff, j, k, q_jkff);
    end

endmodule
