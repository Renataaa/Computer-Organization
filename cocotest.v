`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:00:50 12/15/2016
// Design Name:   COCO
// Module Name:   C:/Users/zhaoyuqi/Desktop/my ise work/my ise work/pipeline/cocotest.v
// Project Name:  pipeline
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: COCO
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cocotest;

	// Inputs
	reg clk;
	reg reset;
	reg [3:2] addr;
	reg we;
	reg [31:0] datain;

	// Outputs
	wire [31:0] dataout;
	wire IRQ;

	// Instantiate the Unit Under Test (UUT)
	COCO uut (
		.clk(clk), 
		.reset(reset), 
		.addr(addr), 
		.we(we), 
		.datain(datain), 
		.dataout(dataout), 
		.IRQ(IRQ)
	);

	initial begin
		// Initialize Inputs
		
	
		
		clk= 0;
		reset=0;
      addr = 2'b01;////countºÍpreset
		we = 1;
		datain = 32'b00000000000000000000000000000101;  
		
		#20;
		addr = 0;////Ð´ctrl
		we = 1;
		datain = 32'b00000000_00000000_00000000_00001001;
		
		#2;
		we =0;
	/*	
		#20;
		addr = 2'b01;////Ð´
		we = 1;
		datain = 32'b00000000_00000000_00000000_00000111;
		#2;
		we=1'b0;
		// Add stimulus here*/
	/*	#20;
      addr = 2'b01;////countºÍpreset
		we = 1;
		datain = 32'b00000000000000000000000000001101;  
		// Add stimulus here
			
		#20;
		addr =2'b00;
		we =1;
		datain = 32'b00000000_00000000_00000000_00001011;
*/
	end
      always #1 clk=~clk;
endmodule

