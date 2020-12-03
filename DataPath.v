`timescale 1ns/1ns
module DataPath(input clk,rst, input [6:0] x1Data,x2Data, input [1:0] tData, input InitYin, InitW1, InitW2, InitB, InitFlag, InitAlpha, LdX1, LdX2, LdT, Select2, LdYin, LdFlag, LdAlphaT, LdW1, LdW2, LdB, input [1:0]  Select1, Sel1, Sel2, output compare, flag, output[1:0] signYin, output[13:0] w1,w2,b,Yin);
  wire [6:0] x1,x2;
  wire [1:0] t;
  wire [2:0] alpha,alphaT;
  wire [13:0] AddOut,MultOut,MultOp1,MultOp2,AddOp1,AddOp2;
  wire [13:0] castedT,castedAlphaT,castedAlpha,castedX1,castedX2;
  assign castedT = t[1] ? {4'b1111, t, 8'b0}: {4'b0, t, 8'b0};
  assign castedAlphaT = alphaT[2] ? {5'b11111, alphaT, 6'b0}: {5'b0, alphaT, 6'b0};
  assign castedAlpha = alpha[2] ? {5'b11111, alpha, 6'b0}: {5'b0, alpha, 6'b0};
  assign castedX1 = x1[6] ? {3'b111, x1, 4'b0}: {3'b0, x1, 4'b0};
  assign castedX2 = x2[6] ? {3'b111, x2, 4'b0}: {3'b0, x2, 4'b0};
  FlagReg FLAG(clk,rst,LdFlag,InitFlag, flag);
  Reg2bit T(clk,rst,LdT,1'b0,tData,t);
  Reg3bit ALPHA(clk,rst,InitAlpha,1'b0,3'b011, alpha);
  Reg3bit ALPHAT(clk,rst,LdAlphaT,1'b0,MultOut[8:6], alphaT);
  Reg7bit X1(clk,rst,LdX1,1'b0,x1Data, x1);
  Reg7bit X2(clk,rst,LdX2,1'b0,x2Data, x2);
  Reg14bit W1(clk,rst,LdW1,InitW1,AddOut, w1);
  Reg14bit W2(clk,rst,LdW2,InitW2,AddOut, w2);
  Reg14bit B (clk,rst,LdB,InitB,AddOut, b);
  Reg14bit YIN (clk,rst,LdYin,InitYin,AddOut, Yin);
  Mux4to1 MULTOP1(Sel1,w1,w2,castedT,castedAlphaT, MultOp1);
  Mux4to1 MULTOP2(Sel2,castedAlpha,castedX1,castedX2,14'b0, MultOp2);
  Mux4to1 ADDOP1(Select1,Yin,b,w1,w2, AddOp1);
  Mux2to1 ADDOP2(Select2,castedAlphaT,MultOut, AddOp2);
  multiplier MULTIPLIER(MultOp1,MultOp2, MultOut);
  adder ADDER(AddOp1,AddOp2, AddOut);
  assign compare = (Yin == 14'b0) ? 1 : (Yin[13] ^ t[1]);
  assign signYin = Yin[13] ? 2'b11 : 2'b01;  
endmodule