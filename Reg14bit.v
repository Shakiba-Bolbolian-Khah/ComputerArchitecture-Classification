`timescale 1ns/1ns
module Reg14bit(input clk,rst,loadData,initVal, input [13:0] inData, output[13:0] out);
  reg [13:0] outData;
  assign out = outData;
  always@(posedge clk, posedge rst)begin
    if(rst) outData <= 14'b0;
    else
    begin
      if(initVal) outData <= 14'b0;
      else
    begin
    if (loadData) outData <= inData;
    else outData <= outData;
    end
  end
  end
endmodule
