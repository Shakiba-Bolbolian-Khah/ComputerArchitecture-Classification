`timescale 1ns/1ns
module Reg2bit(input clk,rst,loadData,initVal, input [1:0] inData, output[1:0] out);
  reg [1:0] outData;
  assign out = outData;
  always@(posedge clk, posedge rst)begin
    if(rst) outData <= 2'b0;
    else
    begin
      if(initVal) outData <= 2'b0;
      else
    begin
    if (loadData) outData <= inData;
    else outData <= outData;
    end
  end
  end
endmodule