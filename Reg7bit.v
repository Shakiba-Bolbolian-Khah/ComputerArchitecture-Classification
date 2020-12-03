`timescale 1ns/1ns
module Reg7bit(input clk,rst,loadData,initVal, input [6:0] inData, output[6:0] out);
  reg [6:0] outData;
  assign out = outData;
  always@(posedge clk, posedge rst)begin
    if(rst) outData <= 7'b0;
    else
    begin
      if(initVal) outData <= 7'b0;
      else
    begin
    if (loadData) outData <= inData;
    else outData <= outData;
    end
  end
  end
endmodule