`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:04:56 11/28/2016 
// Design Name: 
// Module Name:    pipeline_reg 
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
module pipereg(
    input [31:0]In,
	 input clr,
	 output [31:0]Out,
	 input clk,
	 input EN
    );
    
	 reg [31:0] out;
	 assign Out=out;
	 initial begin out=32'h00000000; end
	 
    always @(posedge clk)
	    begin 
		    if(clr)
			     begin 
			    out<=32'h0000_0000; 
				  end
				 else if(EN)begin
				 out<=In;
				 end			  
		 end
endmodule


module pipereg1(
    input In,
	 input clr,
	 output Out,
	 input clk,
	 input EN
    );
    
	 reg  out;
	 assign Out=out;
	 initial begin out=1'b0; end
	 
    always @(posedge clk)
	    begin 
		    if(clr)
			     begin 
			    out<=1'b0; 
				  end
				 else if(EN)begin
				 out<=In;
				 end			  
		 end
endmodule


module pipereg5(
    input [4:0]In,
	 input clr,
	 output [4:0] Out,
	 input clk,
	 input EN
    );
    
	 reg [4:0] out;
	 assign Out=out;
	 initial begin out=5'b00000; end
	 
    always @(posedge clk)
	    begin 
		    if(clr)
			     begin 
			    out<=5'b00000; 
				  end
				 else if(EN)begin
				 out<=In;
				 end			  
		 end
endmodule

module pipereg2(
    input [1:0]In,
	 input clr,
	 output [1:0] Out,
	 input clk,
	 input EN
    );
    
	 reg [1:0] out;
	 assign Out=out;
	 initial begin out=2'b00; end
	 
    always @(posedge clk)
	    begin 
		    if(clr)
			     begin 
			    out<=2'b00; 
				  end
				 else if(EN)begin
				 out<=In;
				 end			  
		 end
endmodule


module pipereg3(
    input [2:0]In,
	 input clr,
	 output [2:0] Out,
	 input clk,
	 input EN
    );
    
	 reg [2:0] out;
	 assign Out=out;
	 initial begin out=3'b000; end
	 
    always @(posedge clk)
	    begin 
		    if(clr)
			     begin 
			    out<=3'b000; 
				  end
				 else if(EN)begin
				 out<=In;
				 end			  
		 end
endmodule 