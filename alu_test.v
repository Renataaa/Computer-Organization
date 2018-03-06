`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:18:45 12/06/2016
// Design Name:   ALU
// Module Name:   C:/Users/zhaoyuqi/Desktop/my ise work/my ise work/pipeline/alu_test.v
// Project Name:  pipeline
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu_test;

	// Inputs
	reg [31:0] In1;
	reg [31:0] In2;
	reg [4:0] ALUop;
	reg [4:0] move;

	// Outputs
	wire [31:0] output1;
	wire zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.In1(In1), 
		.In2(In2), 
		.ALUop(ALUop), 
		.output1(output1), 
		.zero(zero), 
		.move(move)
	);

	initial begin
		// Initialize Inputs
		In1 = 32'hf0100000;
		In2 = 32'hf0100000;
		ALUop = 5'b01010;
		move = 5'b00100;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

