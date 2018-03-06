`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:39:44 11/14/2016 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [31:0] PC4,
    output [31:0] NPC,
    input ifbeq, 
    input zero,
	 input ifbne,
	 input bgtz,
	 input bgtzz,
	 input bltz,
	 input bltzz,
	 input bgez,
	 input bgezz,
	 input blez,
	 input blezz,
    input [31:0] signext,
	 input [25:0] ins_index,
	 input ifjal,
	 input [31:0] jrPC,
	 input ifjr,
	 input ifj,
	 input ifjalr,
	 input [31:0] EPC,
	 input iferet
	 //output [31:0] PC4
    );
	 
	 wire [31:0] PC_beq;
	 assign PC_beq=PC4+(signext<<2);
	 
	 wire [31:0] PCbybeq;
	 assign PCbybeq= ((ifbeq&zero)|(bgtz&bgtzz)|(ifbne&(~zero))|(bltz&bltzz)|(blez&blez)|(bgez&bgezz))?PC_beq:PC4;//
	 
	 wire [31:0] PC_jal;
	 assign PC_jal = {PC4[31:28], ins_index,1'b0,1'b0};
	 
	 wire [31:0] PCbyjal;
	 assign PCbyjal=(ifjal|ifj)?PC_jal:PCbybeq;//	 
	 
	 assign NPC=(iferet)? EPC: 
	            (ifjr|ifjalr) ? jrPC : PCbyjal;
	
endmodule
