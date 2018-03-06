`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:39:00 11/30/2016
// Design Name:   NPC
// Module Name:   C:/Users/zhaoyuqi/Desktop/my ise work/my ise work/pipeline/npc_test.v
// Project Name:  pipeline
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: NPC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module npc_test;

	// Inputs
	reg [31:0] PC4;
	reg ifbeq;
	reg zero;
	reg [31:0] signext;
	reg [25:0] ins_index;
	reg ifjal;
	reg [31:0] jrPC;
	reg ifjr;
	reg ifj;

	// Outputs
	wire [31:0] NPC;

	// Instantiate the Unit Under Test (UUT)
	NPC uut (
		.PC4(PC4), 
		.NPC(NPC), 
		.ifbeq(ifbeq), 
		.zero(zero), 
		.signext(signext), 
		.ins_index(ins_index), 
		.ifjal(ifjal), 
		.jrPC(jrPC), 
		.ifjr(ifjr), 
		.ifj(ifj)
	);

	initial begin
		// Initialize Inputs
		PC4 = 32'h00001000;
		ifbeq = 0;
		zero = 0;
		signext = 0;
		ins_index = 26'h10101010101010101010101010;
		ifjal = 1;
		jrPC = 0;
		ifjr = 0;
		ifj = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

