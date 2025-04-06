module edge_detector(
  input clk,
  input reset,
  input data_in,
  output reg rising_edge,
  output reg falling_edge
);

  reg data_prev;

  // Sensitivity to rising edge of clock or reset
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // all signals set to 0
      data_prev <= 1'b0;
      rising_edge <= 1'b0;
      falling_edge <= 1'b0;
    end else begin
      rising_edge <= (data_in == 1'b1) && (data_prev == 1'b0);
      falling_edge <= (data_in == 1'b0) && (data_prev == 1'b1);
      data_prev <= data_in;
    end
  end

endmodule