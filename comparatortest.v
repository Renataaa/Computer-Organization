`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:35:09 12/01/2016
// Design Name:   comparator
// Module Name:   C:/Users/zhaoyuqi/Desktop/my ise work/my ise work/pipeline/comparatortest.v
// Project Name:  pipeline
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: comparator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module comparatortest;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg [2:0] s;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	comparator uut (
		.A(A), 
		.B(B), 
		.s(s), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		A = 32'b1001_0000_0000_0000_0000_1000_0000_0000;
		B = 32'b0000_0010_0000_0000_0000_0000_0000_0000;
		s = 3'b001;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

