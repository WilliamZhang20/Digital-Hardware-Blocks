`include "d_flip_flop.v"

module jkff (
    // two inputs to jk flip flop
    input wire j,
    input wire k,
    input wire clk,
    input wire reset,
    output wire q
);

    // single d-flip-flop instance, tied to the input of JKFF
    wire d;
    dff dff_inst (
        .d(d),
        .clk(clk),
        .reset(reset),
        .q(q)
    );

    // input to d is function of j, ~k and the feedback of output of the DFF
    assign d = (j & ~q) | (~k & q);

endmodule
