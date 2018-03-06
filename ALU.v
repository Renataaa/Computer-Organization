`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:17:24 11/14/2016 
// Design Name: 
// Module Name:    ALU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
////00000加法00001减法00010与00011或00100异或 00101或非nor (?a ∧ b) ∨ (a ∧?b) 
/////00110 逻辑可变左移 00111 逻辑可变右移 01000 可变左移 01001可变右移
//// 01010 算数右移 01011算数可变右移 01100无符号比较小于置1
/////01101有符号比较小于置 01110 seb
/////01111seh 10000wsbh
module ALU(
    input [31:0] In1,
    input [31:0] In2,
	 input [4:0] ALUop,
    output [31:0] output1,
    output zero,
	 input [4:0] move,
	 input [31:0] insE
    );
	 wire [31:0] a;
	 assign a= {32{In2[31]}};
	// wire [31-move:0] b;
	// assign b=a[31-move:0];
	 wire smaller;
	 assign smaller= ((In1[31]==1'b1)&(In2[31]==1'b0))?1'b1:(((In1[31]==0)&(In2[31]==1))?1'b0:((In1[30:0]<In2[30:0])?1'b1:1'b0));
	 wire [31:0] sebb;
	 assign sebb= {{24{In2[7]}},In2[7:0]};
	 wire [31:0] sehh;
	 assign sehh=  {{16{In2[15]}},In2[15:0]};
	 wire [31:0] wsbhh;
	 assign wsbhh= {In2[23:16],In2[31:24],In2[7:0],In2[15:8]};
	
	 wire [31:0] extt1;
	 assign extt1= In1<<(5'b11111-insE[15:11]);
	 wire [31:0] extt;
	 assign extt =extt1>>(5'b11111-(insE[15:11]-insE[10:6]));
 
	 assign output1=(ALUop==5'b00000)?(In1+In2):
	                (ALUop==5'b00001)?(In1-In2):
						 (ALUop==5'b00010)?(In1&In2):
						 (ALUop==5'b00011)?(In1|In2):
						 (ALUop==5'b00100)?((~In1&In2)|(In1&~In2)):
						 (ALUop==5'b00101)?(~(In1|In2)):
						 (ALUop==5'b00110)?(In2<<(In1[4:0])):
						 (ALUop==5'b00111)?(In2>>(In1[4:0])):
						 (ALUop==5'b01000)?(In2<<move):
						 (ALUop==5'b01001)?(In2>>move):
						 (ALUop==5'b01010)?({a,In2}>>(move[4:0])):
						 (ALUop==5'b01011)?({a,In2}>>(In1[4:0])):
						 (ALUop==5'b01100)?((In1<In2)?32'h0000_0001:32'h0000_0000):
						 (ALUop==5'b01101)?((smaller)?32'h0000_0001:32'h0000_0000):
						 (ALUop==5'b01110)?(sebb):
						 (ALUop==5'b01111)?(sehh):
						 (ALUop==5'b10000)?(wsbhh):
						 (ALUop==5'b10001)?(extt):32'h0000_0000;
    assign zero=((In1-In2)==0)?1'b1:1'b0;

endmodule
