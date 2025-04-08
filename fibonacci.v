// A circuit that counts in Fibonacci numbers
module fibonacci (
    input clk,
    input reset,
    output reg [3:0] fib // 4 bit fibonacci output
);

    reg [3:0] fib_prev, fib_curr;
    reg [4:0] sum; // extra bit to detect overflow

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            fib_prev <= 4'b0000; // fib(0) = 0
            fib_curr <= 4'b0001; // fib(1) = 1
            fib <= 4'b0000;      // Output initially 0
        end
        else begin // non-blocking assignments used 
            fib <= fib_curr;
            sum = fib_prev + fib_curr; // full 5-bit addition
            if (sum >= 5'd16) begin
                // 4-bit overflow detected: reset sequence
                fib_prev <= 4'd0;
                fib_curr <= 4'd1;
            end
            else begin
                // Normal Fibonacci update
                fib_prev <= fib_curr;
                fib_curr <= sum[3:0];
            end
        end
    end

endmodule
