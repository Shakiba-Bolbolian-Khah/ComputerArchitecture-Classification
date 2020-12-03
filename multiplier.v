`timescale 1ns/1ns
module multiplier( input [13:0] op1, op2, output [13:0] result );
  wire [27:0] w;
  wire signed [13:0] operand1,operand2;
  assign operand1 = op1;
  assign operand2 = op2;
  assign w = operand1 * operand2;
  assign result = w[21:8];
endmodule