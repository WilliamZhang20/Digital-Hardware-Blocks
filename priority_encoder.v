// a priority encoder
// 8 to 3 priority encoder
module priority_encoder (
    input [7:0] in,    // 8-bit input
    output reg [2:0] out, // 3-bit output for the binary representation
    output reg valid    // High when one of the inputs is active
);

    always @(*) begin
        // case will function like switch
        // don't cares are marked by an 'x'
        casez (in) // The 'casez' allows for don't-care states in the input
            8'b00000001: begin out = 3'b000; valid = 1; end
            8'b0000001x: begin out = 3'b001; valid = 1; end
            8'b000001xx: begin out = 3'b010; valid = 1; end
            8'b00001xxx: begin out = 3'b011; valid = 1; end
            8'b0001xxxx: begin out = 3'b100; valid = 1; end
            8'b001xxxxx: begin out = 3'b101; valid = 1; end
            8'b01xxxxx: begin out = 3'b110; valid = 1; end
            8'b1xxxxxx: begin out = 3'b111; valid = 1; end
            default: begin out = 3'b000; valid = 0; end // Invalid state when no inputs are active
        endcase
    end

endmodule
