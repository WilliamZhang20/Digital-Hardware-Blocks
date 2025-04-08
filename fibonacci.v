// A circuit that counts in Fibonacci numbers
module fibonacci (
    input clk,
    input reset,
    output reg [3:0] fib // 4 bit fibonacci output
);

    reg [3:0] fib_prev, fib_curr;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            fib_prev <= 4'b0000; // fib(0) = 0
            fib_curr <= 4'b0001; // fib(1) = 1
            fib <= 4'b0000;      // Output initially 0
        end
        else begin // non-blocking assignments used 
            // therefore, must read the old value and THEN update forward
            fib <= fib_curr; // Output current value
            fib_curr <= (fib_prev + fib_curr) & 4'hF;
            fib_prev <= fib_curr;
        end
    end

endmodule
