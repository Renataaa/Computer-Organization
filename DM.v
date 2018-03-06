`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:50:31 11/14/2016 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input [3:0] BE,
    input [31:0] addr,
    input [31:0] datain,
    output [31:0] dataout,
    input clk,
    input reset,
    input Memwrite
    );
    
	 reg [31:0] _dm[2047:0];
	 
	 assign dataout=_dm[addr[12:2]];	 
	 integer i;
	 
	 initial 
		begin
			for(i=0;i<2047;i=i+1)
				begin
					_dm[i]=0;
				end
		end
	always@(posedge clk)begin
		if(reset)
			begin
		      for(i=0;i<2047;i=i+1)
					begin
						_dm[i]=0;
					end
		   end
		else if(Memwrite)
					begin
					  case(BE)
					  4'b1111: begin _dm[addr[12:2]]=datain;
					                $display("*%h <= %h",addr,datain);end
					  4'b0011: begin _dm[addr[12:2]][15:0]=datain[15:0];
					                $display("*%h <= %h",addr,datain[15:0]);end          
					  4'b1100: begin {_dm[addr[12:2]][31:24],_dm[addr[11:2]][23:16]}={datain[15:8],datain[7:0]};
					                $display("*%h <= %h",addr,datain[15:0]);end 
					  4'b0001: begin _dm[addr[12:2]][7:0]=datain[7:0];
					                $display("*%h <= %h",addr,datain[7:0]);end
					  4'b0010: begin _dm[addr[12:2]][15:8]=datain[7:0];
					                  $display("*%h <= %h",addr,datain[7:0]);end
					  4'b0100: begin _dm[addr[12:2]][23:16]=datain[7:0];
					                  $display("*%h <= %h",addr,datain[7:0]);end
					  4'b1000: begin _dm[addr[12:2]][31:24]=datain[7:0];	
                                $display("*%h <= %h",addr,datain[7:0]);end					  
					  endcase
						//_dm[addr[11:2]]=datain;
						//$display("*%h <= %h",addr,datain);
					end
end
endmodule
