`include "d_flip_flop.v"

module jkff (
    input wire j,
    input wire k,
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

    assign d = (j & ~q) | (~k & q);

endmodule
