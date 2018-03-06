`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:31:15 11/28/2016 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );
    wire [31:2] ALUOutM;
	 wire [31:0] PrRD, DEV0_RD ,DEV1_RD,WritedataM;
	 wire [3:2] addr;
	 wire MemWriteM, WeDEV0,WeDEV1,IRQ0,IRQ1;
	 wire [7:2] HWInt;
	 bridge b(.PrAddr(ALUOutM),.PrRD(PrRD),.DEV0_RD(DEV0_RD),.DEV1_RD(DEV1_RD),.DEV_Addr(addr),
	          .PrWe(MemWriteM),.WeDEV0(WeDEV0),.WeDEV1(WeDEV1),.IRQ0(IRQ0),.IRQ1(IRQ1),.HWInt(HWInt));
	 CPU cpu(.clk(clk),.reset(reset),.PrAddr(ALUOutM),.PrBE(),.PrRD(PrRD),.PrWD(WritedataM),.PrWe(MemWriteM),.HWInt(HWInt));
	 COCO coco0(.clk(clk),.reset(reset),.addr(addr),.we(WeDEV0),.datain(WritedataM),.dataout(DEV0_RD),.IRQ(IRQ0));
	 COCO coco1(.clk(clk),.reset(reset),.addr(addr),.we(WeDEV1),.datain(WritedataM),.dataout(DEV1_RD),.IRQ(IRQ1));
endmodule
