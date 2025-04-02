module dff (
    input wire d,
    input wire clk,
    input wire reset,
    output reg q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

endmodule

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