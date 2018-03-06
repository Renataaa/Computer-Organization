`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:52:02 11/29/2016 
// Design Name: 
// Module Name:    comparator 
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
module comparator(
    input [31:0] A,
	 input [31:0] B,
	 input [2:0] s,
	 output out
    ); 
   //000 相等输出1  001 A>B 输出1  010 A<B 输出1 011 大于等于 100小于等于
	 wire greater;
	 assign greater=((A[31]==1'b1)&(B[31]==1'b0))?1'b0:(((A[31]==0)&(B[31]==1))?1'b1:((A[30:0]>B[30:0])?1'b1:1'b0));
     
	 wire smaller;
	 assign smaller= ((A[31]==1'b1)&(B[31]==1'b0))?1'b1:(((A[31]==0)&(B[31]==1))?1'b0:((A[30:0]<B[30:0])?1'b1:1'b0));
					
    assign out= (s==3'b000)?((A==B)?1'b1:1'b0):
	             (s==3'b001)?greater:
					 (s==3'b010)?smaller: 
					 (s==3'b011)?(greater|(A==B)):
					 (s==3'b100)?(smaller|(A==B)):1'b0;
					 
	 
endmodule

