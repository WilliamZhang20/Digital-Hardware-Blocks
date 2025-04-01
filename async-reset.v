module async_reset_circuit(
  input reset_n, // Active-low asynchronous reset
  input clk,     // Clock input
  output reg reset_sync // Synchronized reset output
);

  reg reset_int;
  reg reset_sync_d1;
  reg reset_sync_d2;

  // Asynchronous reset capture
  always @(reset_n) begin
    reset_int <= ~reset_n; // Invert the active-low reset
  end

  // Synchronize the reset to the clock domain
  always @(posedge clk or posedge reset_int) begin
    if (reset_int) begin
      reset_sync_d1 <= 1'b1;
      reset_sync_d2 <= 1'b1;
    end else begin
      reset_sync_d1 <= 1'b0;
      reset_sync_d2 <= reset_sync_d1;
    end
  end

  assign reset_sync = reset_sync_d2;

endmodule