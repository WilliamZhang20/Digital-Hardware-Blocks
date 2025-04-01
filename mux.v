module mux2to1 (
  input wire a,
  input wire b,
  input wire sel,
  output wire out
);

  assign out = sel ? b : a;

endmodule