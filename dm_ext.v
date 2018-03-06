`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:44:09 12/07/2016 
// Design Name: 
// Module Name:    dm_ext 
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
module dm_ext(
    input [1:0] A,
	 input [31:0] Din,
	 input sign, 
	 input [2:0] what,
	 output [31:0] Dout
    );
 
    wire [3:0] k;
	 assign k = (what==3'b001)?4'b1111:///lw
	            (what==3'b010)?((A[1]==1'b1)?4'b1100:4'b0011):///lh
					(what==3'b100)?((A==2'b00)?4'b0001:
					                   (A==2'b01)?4'b0010:
											 (A==2'b10)?4'b0100:
											 (A==2'b11)?4'b1000:4'b0000):4'b0000;
											 
	wire m,n,o,p,q,s;
	assign m=Din[15];
	assign n=Din[31];
	assign o=Din[7];
	assign p=Din[15];
	assign q=Din[23];
	assign s=Din[31];

	assign Dout=  (k==4'b1111)?Din://lw
					  (k==4'b0011)?(sign?{{16{m}},Din[15:0]}:{{16{1'b0}},Din[15:0]}):
					  (k==4'b1100)?(sign?{{16{n}},Din[31:16]}:{{16{1'b0}},Din[31:16]}):
					  (k==4'b0001)?(sign?{{24{o}},Din[7:0]}:{{24{1'b0}},Din[7:0]}):    
					  (k==4'b0010)?(sign?{{24{p}},Din[15:8]}:{{24{1'b0}},Din[15:8]}):
					  (k==4'b0100)?(sign?{{24{q}},Din[23:16]}:{{24{1'b0}},Din[23:16]}):
					  (k==4'b1000)?(sign?{{24{s}},Din[31:24]}:{{24{1'b0}},Din[31:24]}):32'h0000_0000;		
					  
	
endmodule
