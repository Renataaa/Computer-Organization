`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:35:02 12/13/2016 
// Design Name: 
// Module Name:    bridge 
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
module bridge(
	input [31:2] PrAddr,
	output [31:0] PrRD,
	input [31:0] DEV0_RD,
	input [31:0] DEV1_RD,	
	output [3:2] DEV_Addr,
	output [5:0] HWInt,
	input PrWe,
	output WeDEV0,
	output WeDEV1,
	input IRQ0,
	input IRQ1
    );
 assign DEV_Addr=PrAddr[3:2];//按需求
 
 wire HitDEV0;
 assign HitDEV0= (PrAddr[4]==1'b0) && (PrAddr[31:8]==24'h00007f);
 
 wire HitDEV1;
 assign HitDEV1= (PrAddr[4]==1'b1) && (PrAddr[31:8]==24'h00007f); //定时器的寄存器地址
 
 assign WeDEV0=PrWe & HitDEV0;
 assign WeDEV1=PrWe & HitDEV1;
 
 assign PrRD= (HitDEV0) ? DEV0_RD : DEV1_RD;
 
 assign HWInt= {3'b000,IRQ1, IRQ0};
  /*********************************/
endmodule
