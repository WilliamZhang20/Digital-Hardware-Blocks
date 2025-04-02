// a VERY simple 8-bit adder...
module simple_adder(input [7:0] a, input [7:0] b, output [7:0] sum);

  assign sum = a + b;

endmodule