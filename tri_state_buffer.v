// Controls data flow
// 3 State sare: high impedance (disconnect), output, or disabled

module tristate_buffer(
    input wire data,
    input wire enable,
    output wire out
);
    assign output = (enable) ? data : 1'bz; // if enable = 1 pass, else high impedance
endmodule
