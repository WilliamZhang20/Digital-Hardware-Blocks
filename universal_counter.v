// a simple counter that can count both up and down
// Behaves synchronously
module counter (
    input clk, // clock signal
    input rst, // reset output signal
    input up_down, // 1 for counting up, 0 for counting down
    output reg[7:0] count // 8-bit counter
);

    // Asynchronously reset
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 8'b0 // reset all 8 bits to 0
        end else begin
            if (up_down) begin
                count <= count + 1;
            end else begin
                count <= count - 1;
            end
        end
    end

endmodule