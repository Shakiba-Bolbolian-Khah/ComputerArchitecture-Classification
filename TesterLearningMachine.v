`timescale 1ns/1ns
module TesterLearningMachine( input [13:0] W1,W2,B, input [6:0]X1,X2, output[1:0] SignYin);
  wire [13:0] result;
  wire signed [13:0] w1,w2;
  wire signed [6:0] x1,x2;
  assign w1 = W1;
  assign w2 = W2;
  assign x1 = X1;
  assign x2 = X2;
  wire [27:0] mult1 , mult2;
  assign mult1 = x1 * w1;
  assign mult2 = x2 * w2;
  assign result = mult1[17:4] + mult2[17:4] + B;
  assign SignYin = result[13]? 2'b11 : 2'b01;
endmodule
