`timescale 1ns/1ns
module Reg3bit(input clk,rst,loadData,initVal, input [2:0] inData, output[2:0] out);
  reg [2:0] outData;
  assign out = outData;
  always@(posedge clk, posedge rst)begin
    if(rst) outData <= 3'b0;
    else
    begin
      if(initVal) outData <= 3'b0;
      else
    begin
    if (loadData) outData <= inData;
    else outData <= outData;
    end
  end
  end
endmodule