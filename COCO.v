`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:42:41 12/14/2016 
// Design Name: 
// Module Name:    COCO 
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
module COCO(
    input clk,
	 input reset,
	 input [3:2] addr,
	 input we,
	 input  [31:0] datain,
	 output [31:0] dataout,
	 output IRQ
    );
    
	 reg [31:0] ctrl;// 0位 1允许计数； 2：1 模式00方式0 01方式1 ；3 1允许中断
	 reg [31:0] preset;
	 reg [31:0] count;
	 
	 	 
	 initial
        begin
          ctrl<=0;
          preset<=1000;///////*********************
          count<=0;
        end
	 always@(posedge clk)
		begin
			if(reset)
				begin
					ctrl<=0;
               preset<=1000;///////*********************
               count<=0;
				end
			else if(we)
			        begin
						  case(addr[3:2])
						  2'b00: begin 
						         ctrl[3:0] <= datain[3:0];
									count<= preset;
									end
						  2'b01: begin 
						         preset<= datain;
						         count<= datain;  
									end
							endcase
							//count<=preset;
					  end
			else begin
			
          if(ctrl[2:1]==2'b00 & ctrl[0])
			   begin			
				if(ctrl[0]&count>0)
				    begin
					    count <= count-1;
					 end
			   if(count == 32'h00000001)
					 begin
						 ctrl[0] <= 1'b0;
				    end
				end
		


		else if(ctrl[2:1] == 2'b01)
			      begin 
					   if(count >0 & ctrl[0])
						  begin
						    count<=count-1;  
						  end
						else if(count==0)
						    begin
							 count<=preset;
							 end
					end    
          end					
		end
	 
	 assign IRQ= (ctrl[3] & (count==32'h00000000) /*& (ctrl[2:1]==3'b00)*/)? 1'b1: 1'b0;
    
	 assign dataout= (addr[3:2]==2'b00)? ctrl :
	                 (addr[3:2]==2'b01)? preset: count;



endmodule
