`timescale 1ns/1ns
module LearningMachine(input clk,rst, start, input [6:0] x1Data,x2Data, input [1:0] tData, output[1:0] signYin, output[13:0] w1,w2,b,Yin,output ReadEn, Ready);
  wire [1:0]Select1, Sel1, Sel2;
  wire  flag, InitYin, InitW1, InitW2, InitB, InitFlag, InitAlpha, LdX1, LdX2, LdT, Select2, LdYin, LdFlag, LdAlphaT, LdW1, LdW2, LdB;
  Controller controller(clk, rst, start, compare, flag, InitYin, InitW1, InitW2, InitB, InitFlag, InitAlpha, LdX1, LdX2, LdT, Select2, LdYin, LdFlag, LdAlphaT, LdW1, LdW2, LdB, ReadEn, Ready, Select1, Sel1, Sel2);
  DataPath datapath(clk,rst, x1Data,x2Data, tData, InitYin, InitW1, InitW2, InitB, InitFlag, InitAlpha, LdX1, LdX2, LdT, Select2, LdYin, LdFlag, LdAlphaT, LdW1, LdW2, LdB, Select1, Sel1, Sel2, compare, flag, signYin, w1,w2,b,Yin);
endmodule