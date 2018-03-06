`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:15:14 11/30/2016 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [12:2] Addr,
    output [31:0] IMoutput
    );
    reg [31:0] _im[2047:0];
	 wire [12:2] Addr1;
	            assign Addr1=Addr-1024;
	 assign IMoutput =_im[Addr1];
	 
	initial begin
		$readmemh("code.txt",_im);
		$readmemh("code1.txt",_im,11'h460,11'h7ff);
	end

endmodule