`include "d_flip_flop.v"

// Flip flop conversions:
// https://www.allaboutcircuits.com/technical-articles/conversion-of-flip-flops-part-iv-d-flip-flops/

// T Flip-Flop
module tff (
    input wire t,
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

    assign d = t ^ q; // feedback Q XOR with T

endmodule
