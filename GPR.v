`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:51:57 11/14/2016 
// Design Name: 
// Module Name:    GPR 
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
module GPR(
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input Regwrite,
    output [31:0] RD1,
    output [31:0] RD2,
    input [31:0] WD,
	 input clk,
	 input reset
    );
    
	 reg[31:0] _reg[31:0];
	 
	 assign RD1=_reg[A1];
	 assign RD2=_reg[A2];
	 
    integer i;
	 initial begin
	 for(i=0;i<32;i=i+1)
		begin 
			_reg[i]=0;
		end
	// _reg[29]=32'h00002ffc;
	 end
	
	always@(negedge clk)
		begin
			if(reset)
				begin
					for(i=0;i<32;i=i+1)
						begin 
							_reg[i]=0;
						end
				end
			else if(Regwrite) 
			          begin
							  _reg[A3]=(A3==5'b00000)?32'h00000000:WD;
							 if(A3!=5'b00000)begin $display("$%d <= %h",A3,WD);end
					    end
		end
endmodule
