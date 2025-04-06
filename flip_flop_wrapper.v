`include "d_flip_flop.v"
`include "t_flip_flop.v"
`include "jk_flip_flop.v"

module flip_flops_wrapper (
    input wire clk,
    input wire reset,
    input wire t,
    input wire j,
    input wire k,
    output wire q_t,
    output wire q_jk
);

    tff tff_inst (
        .t(t),
        .clk(clk),
        .reset(reset),
        .q(q_t)
    );

    jkff jkff_inst (
        .j(j),
        .k(k),
        .clk(clk),
        .reset(reset),
        .q(q_jk)
    );

endmodule
