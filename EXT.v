`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:30:58 11/14/2016 
// Design Name: 
// Module Name:    EXT 
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
////00零扩展 01符号扩展 10高位扩展
module EXT(
    input [15:0] EXTinput,
    output [31:0] EXToutput,
    input [1:0] EXTop
    );
    wire a=EXTinput[15];
	 assign EXToutput=(EXTop==2'b00)?{16'b0000000000000000,EXTinput}:
	                  (EXTop==2'b01)?{a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,EXTinput}:
						   (EXTop==2'b10)?{EXTinput,16'b0000000000000000}:0;
							
						/*	always@(*)begin
							    $display("+++%h",EXToutput);end*/

endmodule
