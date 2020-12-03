`timescale 1ns/1ns
module TestBench();
  reg clk = 0, rst = 0, start = 0;
  integer data_file    ; // file handler
  integer scan_file    ; // file handler
  reg [6:0] x1Data, x2Data;
  reg [6:0] x1 = 7'b0;
  reg [6:0] x2 = 7'b0;
  reg [1:0] tData;
  wire [1:0] signYin, testResult;
  wire [13:0] w1,w2,b,Yin;
  wire ReadEn, Ready;
  
  `define NULL 0
  LearningMachine UUT(clk,rst,start,x1Data,x2Data,tData, signYin,w1,w2,b,Yin,ReadEn, Ready);
  TesterLearningMachine TUT(w1,w2,b,x1,x2, testResult);
  always#50 clk = ~clk;

  initial begin
    rst = 1;
    start = 1;
    #50
    rst = 0;
    #20
    start = 0;
  end
  always @(posedge ReadEn,posedge start, posedge Ready) begin
    if(start) begin
      data_file = $fopen("data_set.txt", "r");
      if (data_file == `NULL) begin
        $display("data_file handle was NULL");
        $stop;
      end
    end
      
    scan_file = $fscanf(data_file, "%b %b %b\n", x1Data, x2Data, tData);

    if ($feof(data_file)) begin
      if(!Ready) begin
        $fclose(data_file);
        data_file = $fopen("data_set.txt", "r");
      end
    end
    if( Ready & ~start)begin
      #1000
      x1 = 7'b0000010;
      x2 = 7'b0010010;
      #1000
      x1 = 7'b0001101;
      x2 = 7'b0100100;
      #1000
      x1 = 7'b1101111;
      x2 = 7'b1110011;
      #1000
      x1 = 7'b1111010;
      x2 = 7'b1111011;
      #1000;     
      $stop;
    end

  end
  
endmodule