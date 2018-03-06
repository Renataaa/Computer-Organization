`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:18:02 12/07/2016 
// Design Name: 
// Module Name:    BEext 
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
module BEext(
    input [1:0] a,
	 input [2:0] BEext_c,
	 output[3:0] BE
    );
    
	 assign BE= (BEext_c==3'b001)?4'b1111:///sw
	            (BEext_c==3'b010)?((a[1]==1'b1)?4'b1100:4'b0011):///sh
					(BEext_c==3'b100)?((a==2'b00)?4'b0001:
					                   (a==2'b01)?4'b0010:
											 (a==2'b10)?4'b0100:
											 (a==2'b11)?4'b1000:4'b0000):4'b0000;
											 
										
  
endmodule
