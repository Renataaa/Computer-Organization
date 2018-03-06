`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:24:54 11/14/2016 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input [31:0] NPC,
    output [31:0] PC,
    input clk,
	 input EN,
    input reset
    );
	 parameter initiall=32'h0000_3000;
	 reg [31:0] pc;
	 initial begin  pc=initiall; end
    
    assign PC=pc;
	 	 
	 always@(posedge clk)
		begin
			if(reset)
				begin
					pc=initiall;
				end
			else if(EN) begin pc =NPC; end 
		end
	
endmodule
