`timescale 1ns/1ns
module Controller(input clk, rst, start, compare, flag, output InitYin, InitW1, InitW2, InitB, InitFlag, InitAlpha, LdX1, LdX2, LdT, Select2, LdYin, LdFlag, LdAlphaT, LdW1, LdW2, LdB,ReadEn,Ready, output [1:0] Select1, Sel1, Sel2);
	reg initYin, initW1, initW2, initB, initFlag, initAlpha, ldX1, ldX2, ldT, select2, ldYin, ldFlag, ldAlphaT, ldW1, ldW2, ldB;
	reg [1:0] select1, sel1, sel2;
	reg [3:0] ns, ps;
	reg ldCnt, cntDown;
	reg readEn, ready;
	wire co;
	reg [7:0] Cout;
	always@(ps, start, co, compare, flag)begin
		ns = 4'b0;
		case(ps)
			4'b0000: begin
				ns = (start)? 4'b0001 : 4'b0000;
			  end
			4'b0001: begin
				ns = 4'b0010;
				end
			4'b0010: begin
				ns = 4'b0011;
				end
			4'b0011: begin
				ns = 4'b0100;
				end
			4'b0100: begin
				ns = 4'b0101;
				end
			4'b0101: begin
				ns = compare ? 4'b0110 : 4'b1010;
				end
			4'b0110: begin
				ns = 4'b0111;
				end
			4'b0111: begin
				ns = 4'b1000;
				end
			4'b1000: begin
				ns = 4'b1001;
				end
			4'b1001: begin
				ns = 4'b1010;
				end
			4'b1010: begin
				ns = (co == 0) ? 4'b0010 : 
				     (flag == 1) ? 4'b1011 : 
				     (flag == 0) ? 4'b0000 : 4'b1010;
				end
			4'b1011: begin
			  ns = 4'b0010;
			  end
			default: ns = 4'b0000;
		endcase
	end
	always@(ps)begin
		{initYin, initW1, initW2, initB, initFlag, ldCnt, initAlpha, ldX1, ldX2, ldT, cntDown, select2, ldYin, ldFlag, ldAlphaT, ldW1, ldW2, ldB} = 18'b0;
		readEn = 1'b0;
		ready = 1'b0;
		select1 = 2'b0;
		sel1 = 2'b0;
		sel2 = 2'b0;
		case(ps)
			4'b0000: begin
				ready = 1;
			  end
			4'b0001: begin
				initW1 = 1;
				initW2 = 1;
				initB = 1;
				initYin = 1;
				ldCnt = 1;
				initAlpha = 1;
				end
			4'b0010: begin
				ldX1 = 1;
				ldX2 = 1;
				ldT = 1;
				cntDown = 1;
				readEn = 1;
				end
			4'b0011: begin
				sel1 = 2'b00;
				sel2 = 2'b01;
				select1 = 2'b01;
				select2 = 1;
				ldYin = 1;
				end
			4'b0100: begin
				sel1 = 2'b01;
				sel2 = 2'b10;
				select1 = 2'b00;
				select2 = 1;
				ldYin = 1;
				end
			4'b0101: begin
			  // do nothing
				end
			4'b0110: begin
				sel1 = 2'b10;
				sel2 = 2'b0;
				ldAlphaT = 1;
				ldFlag = 1;
				end
			4'b0111: begin
				sel1 = 2'b11;
				sel2 = 2'b01;
				select2 = 1;
				select1 = 2'b10;
				ldW1 = 1;
				end
			4'b1000: begin
				sel1 = 2'b11;
				sel2 = 2'b10;
				select2 = 1;
				select1 = 2'b11;
				ldW2 = 1;
				end
			4'b1001: begin
				select2 = 0;
				select1 = 2'b01;
				ldB = 1;
				end
			4'b1010: begin
			  // do nothing
				end
			4'b1011: begin
			  ldCnt = 1;
			  initFlag = 1;
			  end
		endcase
	end
	always@(posedge clk,posedge rst)begin
		if(rst) ps <= 4'b0000;
		else ps <= ns;
	end
	always@(posedge clk, posedge rst)begin
	  if(rst)
	    Cout = 8'b11001000;
	  else begin
	    if(ldCnt) Cout <= 8'b11001000;
	    else if(cntDown) Cout <= Cout - 1;
	  end
  end
  assign co = ~|{Cout};
  assign InitYin = initYin;
  assign InitW1 = initW1;
  assign InitW2 = initW2;
  assign InitB = initB;
  assign InitFlag = initFlag;
  assign LdCnt = ldCnt;
  assign InitAlpha = initAlpha;
  assign LdX1 = ldX1;
  assign LdX2 = ldX2;
  assign LdT = ldT;
  assign CntDown = cntDown;
  assign Select1 = select1;
  assign Select2 = select2;
  assign LdYin = ldYin;
  assign LdFlag = ldFlag;
  assign LdAlphaT = ldAlphaT;
  assign LdW1 = ldW1;
  assign LdW2 = ldW2;
  assign LdB = ldB;
  assign Sel1 = sel1;
  assign Sel2 = sel2;
  assign ReadEn = readEn;
  assign Ready = ready;
endmodule