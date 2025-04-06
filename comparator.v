// an 8-bit comparator circuit between two numbers

module comparator (
    input [7:0] a,
    input [7:0] b,
    output reg gt, // high if a > b
    output reg lt, // high if a < b
    output reg eq // high if a == b
);
    // block sensitive to all inputs changing in all directions
    always @(*) begin
        gt = 0;
        lt = 0;
        eq = 0;

        if (a > b) begin
            gt = 1;
        end else if (a < b) begin
            lt = 1;
        end else begin
            eq = 1; 
        end
    end

endmodule
