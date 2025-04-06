`ifndef DFF_V
`define DFF_V
`timescale 1ns / 1ps

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

`endif
