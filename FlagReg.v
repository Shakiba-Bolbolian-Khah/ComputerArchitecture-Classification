`timescale 1ns/1ns
module FlagReg(input clk,rst,loadData,initVal, output out);
  reg outData;
  assign out = outData;
  always@(posedge clk, posedge rst)begin
    if(rst) outData <= 1'b0;
    else
    begin
      if(initVal) outData <= 1'b0;
      else
    begin
    if (loadData) outData <= 1'b1;
    else outData <= outData;
    end
  end
  end
endmodule