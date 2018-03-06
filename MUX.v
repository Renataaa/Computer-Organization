`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:02:18 11/14/2016 
// Design Name: 
// Module Name:    MUX 
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
module MUX_32_2_1(
    input [31:0] input0,
    input [31:0] input1,
    input s,
    output [31:0] out
    );
	 assign out=s?input1:input0;
	
endmodule


module MUX_5_2_1(
    input [4:0] input0,
    input [4:0] input1,
    input  s,
    output [4:0] out
    );
	 assign out=s?input1:input0;
				
	
endmodule


module MUX_32_4_1(
    input [31:0] input0,
    input [31:0] input1,
	 input [31:0] input2,
	 input [31:0] input3,
    input  [1:0] s,
    output [31:0] out
    );
	 assign out= (s==2'b00)?input0:
	             (s==2'b01)?input1:
					 (s==2'b10)?input2:
					 (s==2'b11)?input3:0;
				
endmodule
