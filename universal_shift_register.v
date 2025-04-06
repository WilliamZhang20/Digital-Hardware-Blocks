// universal register shifts both left & right
module universal_shift_register #(
    parameter DATA_WIDTH = 8
) (
    input clk,
    input rst,
    input load_en,
    input shift_en,
    input left_en,
    input right_en,
    input [DATA_WIDTH-1:0] load_data,
    input left_in,
    input right_in,
    output reg [DATA_WIDTH-1:0] q,
    output reg left_out,
    output reg right_out
);

    reg [DATA_WIDTH-1:0] next_q;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= '0;
            left_out <= 0;
            right_out <= 0;
        end else begin
            q <= next_q;
            // Output the shifted out bit
            left_out <= q[DATA_WIDTH-1];
            right_out <= q[0];
        end
    end

    always_comb begin
        next_q = q; // Default: hold the current value

        if (load_en) begin
            next_q = load_data;
        end else if (shift_en) begin
            if (left_en && !right_en) begin
                next_q = {q[DATA_WIDTH-2:0], left_in};
            end else if (!left_en && right_en) begin
                next_q = {right_in, q[DATA_WIDTH-1:1]};
            end
            // If both left_en and right_en are high, or both are low,
            // the register will hold its value due to the default assignment.
            // You might want to define specific behavior for these cases if needed.
        end
    end

endmodule
