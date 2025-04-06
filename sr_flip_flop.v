// coding conversion of D to SR flip flop
// So a combinational circuit at DFF input from S and R
`include "d_flip_flop.v"

module srFlipFlop (
    input wire s,
    input wire r,
    input wire clk,
    input wire reset,
    output wire q
);
    wire d;

    dff dff_inst (
        .d(d),
        .clk(clk),
        .reset(reset),
        .q(q)
    );

    assign d = (s & ~r) ? 1 :         // Set state (S = 1, R = 0)
               (q & ~s & r) ? 0 :    // Reset state (S = 0, R = 1)
               1'bz;
endmodule
