// A template Mealy Machine for parity checking
// Runs 1 clock cycle ahead of Moore
module mealy_machine (
    input wire clk,
    input wire rst,
    input wire din,
    output reg dout
);

    typedef enum logic [1:0] {
        S1 = 2'b00,
        S2 = 2'b01
    } state_t;

    state_t state, next_state;

    // toggling state reigster
    always_ff @(posedge clk or posedge rst) begin
        if(rst)
            state <= S1; // start with even (zero 1's is even)
        else
            state <= next_state;
    end

    // forcing always combinational logic (gates or muxes only)
    // avoids latch 
    // overall, the below decodes the logic for the next state AND the machine's output
    always_comb begin
        next_state = state;
        dout = 0;

        case (state)
            S1: begin
                // case on inputs
                if (din) begin
                    next_state = S2;
                    dout = 0;
                end 
                else begin
                    next_state = S1;
                    dout = 1;
                end
            end

            S2 : begin
                if (din) begin
                    next_state = S1;
                    dout = 1;
                end else begin
                    next_state = S2;
                    dout = 0;
                end
            end
        
            default: begin
                next_state = S1;
                dout = 1;
            end
        endcase
    end

endmodule
