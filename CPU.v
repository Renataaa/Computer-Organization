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
module CPU(
    input clk,
    input reset,
	 output [31:2]PrAddr,
	 output [2:0] PrBE,
	 input [31:0] PrRD,
	 output [31:0] PrWD,
	 output PrWe,
	 input [5:0] HWInt
    );

/*initial
begin
$display("realtime ins_W ");
$monitor("%t %h",$realtime,ins_W);
end*/

    
    wire [31:0]PC,NPC,PCin,PCPlusF,PCPlusD,PCinfinal;
	 wire [31:0]ins, ins_D, ins_E, ins_M, ins_W;
	 wire RegWriteD,MemtoRegD,MemWriteD,ALUSrcD,RegDstD,BranchD;
	 wire [4:0] ALUControlD;
	 wire EqualD,PCSrcD;
	 wire [31:0] EXToutput,EXToutput_E;
	 
	 
	 wire RegWriteE,MemtoRegE,MemWriteE,ALUSrcE,RegDstE;
	 wire [4:0] ALUControlE;
	 wire [4:0]Rs_E, Rt_E, Rd_E, WriteReg_E;
	 wire [31:0] rd1,rd2,rd1_E,rd2_E;
	 wire [31:0] ALUoutput;
	 wire [31:0] e1,e2;
	 wire [31:0] SrcAE,SrcBE,SrcBE_1;
	 wire [1:0] EXTop;
	 
	 wire RegWriteM,MemtoRegM,MemWriteM;
	 wire [31:0]ALUOutM,WriteDataM;
	 wire [4:0] WriteReg_M;
	 wire [31:0]DMoutput;
	 
	 wire RegWriteW,MemtoRegW;
	 wire [31:0]ReadDataW,ALUOutW;
	 wire [4:0] WriteReg_W;
	 wire [31:0] WD,WD1,WD2;
	 
	 wire ifjal,ifjr,ifjalW,ifj;
	 wire ifjalE;
	 wire ifjalM;
	 
	 //reg PCSrcD1
	 ///initial PCSrcD1
	 IM im(.Addr(PC[12:2]),.IMoutput(ins));
	 MUX_32_2_1 mux8(.input0(PCPlusF),.input1(NPC),.s(PCSrcD|ifjal|ifjr|ifj|ifjalr|iferetD),.out(PCin));
	 MUX_32_2_1 m5(.input0(PCin),.input1(32'h00004180),.s(Intreq),.out(PCinfinal));
    PC pc(.NPC(PCinfinal),.EN(~StallF | Intreq ),.PC(PC),.clk(clk),.reset(reset));
	 wire epccD,epccE,epccM,epccW;
	 assign epccD= PCSrcD|ifjal|ifjr|ifj|ifjalr|iferetD;
	// wire [31:0] PCPlusF;
	 assign PCPlusF=PC+4;
	 wire [31:0] PC8_E,PC8_M,PC8_W;
	 wire bgtzz,bgtz,bltz,bltzz,bgez,bgezz,blez,blezz;
    wire ifbne;
	 wire ifjalr,ifjalrE,ifjalrM,ifjalrW;
	 wire startD,mthiD,mtloD,regwritemdD,startE,mthiE,mtloE,regwritemdE;
	 wire [1:0] MDopD,mfD,MDopE,mfE;
	 wire [31:0] ALUoutputfinal,HI,LO,hilo;
	 wire [2:0] BEext_cD,BEext_cE,BEext_cM;
	
	 wire signD,signE,signM,signW;
	 wire [2:0] whatD,whatE,whatM,whatW;
	 wire ifmsubD,ifmsubE,ifmsubM;
	 wire Regwritecp0D,Regwritecp0E,Regwritecp0M,Regwritecp0W;
	 wire iferetD,iferetE,iferetM,iferetW;
	 wire ifmfc0D,ifmfc0E,ifmfc0M,ifmfc0W;
	 wire [31:0] EPC1, EPC2;
	 wire [31:0] cp0out,cp0outW;
	 pipereg F_D1(.In(ins),.Out(ins_D),.EN(~StallD),.clr(reset|Intreq|iferetD),.clk(clk));
	 pipereg F_D2(.In(PCPlusF),.Out(PCPlusD),.EN(~StallD),.clr(reset|iferetD|Intreq),.clk(clk));
	 
	 controller D(.ins(ins_D),.special(ins_D[20:16]),.special2(ins_D[10:6]),.Op(ins_D[31:26]),.Funct(ins_D[5:0]),.Regdst(RegDstD),.ALUsrc(ALUSrcD),.Memtoreg(MemtoRegD),.Regwrite(RegWriteD),
	             .Memwrite(MemWriteD),.ifbeq(BranchD),.ALUop(ALUControlD),.EXTop(EXTop)
					 ,.ifjal(ifjal),.ifjr(ifjr),.ifj(ifj),.bgtz(bgtz),.ifbne(ifbne),.bltz(bltz),.bgez(bgez),.blez(blez),.ifjalr(ifjalr),
					 .start(startD),.mthi(mthiD),.mtlo(mtloD),.regwritemd(regwritemdD),.MDop(MDopD),.mf(mfD),.BEext_c(BEext_cD),
					 .sign(signD),.what(whatD),.ifmsub(ifmsubD),.Regwritecp0(Regwritecp0D),.iferet(iferetD),.ifmfc0(ifmfc0D));
	 MUX_32_2_1 m2(.input0(EPC1),.input1(SrcBE_1),.s(Regwritecp0E & ins_E[15:11]==5'd14),.out(EPC2));///writedataE
	 NPC npc(.EPC(EPC2),.iferet(iferetD),.ifjalr(ifjalr),.bgez(bgez),.blez(blez),.bgezz(bgezz),.blezz(blezz),.ifbne(ifbne),.bgtz(bgtz),.bltz(bltz),.bltzz(bltzz),.bgtzz(bgtzz),.ifbeq(BranchD),.zero(EqualD),.ifj(ifj),.PC4(PCPlusD),.NPC(NPC),.ins_index(ins_D[25:0]),.ifjal(ifjal),.jrPC(e1),.ifjr(ifjr),.signext(EXToutput));
	 GPR gpr(.A1(ins_D[25:21]),.A2(ins_D[20:16]),.A3(WriteReg_W),.Regwrite(RegWriteW),.RD1(rd1),.RD2(rd2),.WD(WD),.clk(clk),.reset(reset));///
	 EXT extern(.EXTinput(ins_D[15:0]),.EXToutput(EXToutput),.EXTop(EXTop));
	 MUX_32_2_1 mux1(.input0(rd1),.input1(z3),.s(ForwardAD),.out(e1));
	 MUX_32_2_1 mux2(.input0(rd2),.input1(z4),.s(ForwardBD),.out(e2));
	 comparator c1(.A(e1),.B(e2),.s(3'b000),.out(EqualD));
	 comparator c2(.A(e1),.B(32'h0000_0000),.s(3'b001),.out(bgtzz)); //大于0
	 comparator c3(.A(e1),.B(32'h0000_0000),.s(3'b010),.out(bltzz)); //小于0
	 comparator c4 (.A(e1),.B(32'h0000_0000),.s(3'b011),.out(bgezz)); 
	 comparator c5 (.A(e1),.B(32'h0000_0000),.s(3'b100),.out(blezz)); 
	 wire [31:0] PC8;
	 assign PC8= PCPlusD+4;
	 //wire PCSrcD;
	 assign PCSrcD=(EqualD&BranchD)|(bgtz&bgtzz)|((~EqualD)&ifbne)|(bltz&bltzz)|(blez&blezz)|(bgez&bgezz);
	 wire [31:0] PCPlusE,PCPlusM,PCPlusW;
	 pipereg D_E1(.In(rd1),.Out(rd1_E),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg D_E2(.In(rd2),.Out(rd2_E),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));	 
	 pipereg5 D_E3(.In(ins_D[25:21]),.Out(Rs_E),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 wire [4:0] jalreg;
	 MUX_5_2_1 mux9(.input0(ins_D[20:16]),.input1(5'b11111),.s(ifjal),.out(jalreg));
	 pipereg5 D_E4(.In(jalreg),.Out(Rt_E),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg5 D_E5(.In(ins_D[15:11]),.Out(Rd_E),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg D_E6(.In(EXToutput),.Out(EXToutput_E),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg D_E7(.In(ins_D),.Out(ins_E),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));/*****************************/
	 pipereg D_E8(.In(PC8),.Out(PC8_E),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));/*111111111111111111*/
	 pipereg1 D_E9(.In(RegWriteD),.Out(RegWriteE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg1 D_E10(.In(MemtoRegD),.Out(MemtoRegE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg1 D_E11(.In(MemWriteD),.Out(MemWriteE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg5 D_E13(.In(ALUControlD),.Out(ALUControlE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg1 D_E14(.In(ALUSrcD),.Out(ALUSrcE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg1 D_E15(.In(RegDstD),.Out(RegDstE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg1 D_E16(.In(ifjal),.Out(ifjalE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg1 D_E17(.In(ifjalr),.Out(ifjalrE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg1 D_E18(.In(startD),.Out(startE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg1 D_E19(.In(mthiD),.Out(mthiE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg1 D_E20(.In(mtloD),.Out(mtloE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg1 D_E21(.In(regwritemdD),.Out(regwritemdE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg2 D_E22(.In(MDopD),.Out(MDopE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg2 D_E23(.In(mfD),.Out(mfE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg3 D_E24(.In(BEext_cD),.Out(BEext_cE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg1 D_E25(.In(signD),.Out(signE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg3 D_E26(.In(whatD),.Out(whatE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg1 D_E27(.In(ifmsubD),.Out(ifmsubE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg1 D_E28(.In(Regwritecp0D),.Out(Regwritecp0E),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg1 D_E29(.In(iferetD),.Out(iferetE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg1 D_E30(.In(ifmfc0D),.Out(ifmfc0E),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 pipereg1 D_E31(.In(epccD),.Out(epccE),.clr(FlushE|reset|Intreq),.clk(clk),.EN(1'b1));
	 //controller E(.Op(ins_E[31:26]),.Funct(ins_E[5:0]),.Regdst(RegDstE),.ALUsrc(ALUSrcE),
	 //.Memtoreg(MemtoRegE),.Regwrite(RegWriteE),.Memwrite(MemWriteE),.ALUop(ALUControlE));
	 MUX_5_2_1 mux3(.input0(Rt_E),.input1(Rd_E),.s(RegDstE),.out(WriteReg_E));
	 MUX_32_4_1 mux4(.input0(rd1_E),.input1(WD),.input2(z1),.input3(cp0out),.s(ForwardAE),.out(SrcAE));
	 MUX_32_4_1 mux5(.input0(rd2_E),.input1(WD),.input2(z2),.input3(cp0out),.s(ForwardBE),.out(SrcBE_1));
	 MUX_32_2_1 mux6(.input0(SrcBE_1),.input1(EXToutput_E),.s(ALUSrcE),.out(SrcBE));
	 ALU alu(.insE(ins_E),.In1(SrcAE),.In2(SrcBE),.ALUop(ALUControlE),.output1(ALUoutput),.move(ins_E[10:6]));
	 
	 MD md(.ifmsub(ifmsubE),.In1(SrcAE),.In2(SrcBE),.start(startE & ~Intreq),.MDop(MDopE),.HI(HI),.LO(LO),.mthi(mthiE),.mtlo(mtloE),.regwritemd(regwritemdE & ~Intreq),.clk(clk),.reset(reset),.busy(busy));
	 MUX_32_2_1 mux20(.input0(HI),.input1(LO),.s(mfE[0]),.out(hilo));
	 MUX_32_2_1 mux21(.input0(ALUoutput),.input1(hilo),.s(mfE[0]|mfE[1]),.out(ALUoutputfinal));
	 
	 wire [31:0] z1= (ifjalM|ifjalrM)?PC8_M:ALUOutM;
	 wire [31:0] z2= (ifjalM|ifjalrM)?PC8_M:ALUOutM;
	 wire [31:0] z3= (ifjalM|ifjalrM)?PC8_M:ALUOutM;
	 wire [31:0] z4= (ifjalM|ifjalrM)?PC8_M:ALUOutM;
	 
	 pipereg E_M1(.In(ALUoutputfinal),.Out(ALUOutM),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg E_M2(.In(SrcBE_1),.Out(WriteDataM),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg5 E_M3(.In(WriteReg_E),.Out(WriteReg_M),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg E_M4(.In(ins_E),.Out(ins_M),.clk(clk),.EN(1'b1),.clr(reset|Intreq));/*************************/
	 pipereg E_M5(.In(PC8_E),.Out(PC8_M),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg1 E_M6(.In(RegWriteE),.Out(RegWriteM),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg1 E_M7(.In(MemtoRegE),.Out(MemtoRegM),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg1 E_M8(.In(MemWriteE),.Out(MemWriteM),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg1 E_M9(.In(ifjalE),.Out(ifjalM),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg1 E_M10(.In(ifjalrE),.Out(ifjalrM),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg3 E_M11(.In(BEext_cE),.Out(BEext_cM),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg1 E_M12(.In(signE),.Out(signM),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg3 E_M13(.In(whatE),.Out(whatM),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg1 E_M14(.In(ifmsubE),.Out(ifmsubM),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
    pipereg1 E_M15(.In(Regwritecp0E),.Out(Regwritecp0M),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg1 E_M16(.In(iferetE),.Out(iferetM),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg1 E_M17(.In(ifmfc0E),.Out(ifmfc0M),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg1 E_M18(.In(epccE),.Out(epccM),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	//controller M(.Op(ins_M[31:26]),.Funct(ins_M[5:0]),.Memtoreg(MemtoRegM),.Regwrite(RegWriteM),.Memwrite(MemWriteM),.ifjal(ifjalM));
	
	 wire [3:0] BE;
	 BEext be(.a(ALUOutM[1:0]),.BEext_c(BEext_cM),.BE(BE));
	 DM dm(.BE(BE),.addr(ALUOutM[31:0]),.datain(WriteDataM),.dataout(DMoutput),.clk(clk),.reset(reset),.Memwrite(MemWriteM & ALUOutM[31:2]<2048));
    wire [31:0] cp0pc;
	 wire Intreq;
	 wire [31:0] cp0pc1,cp0pc2;
    MUX_32_2_1 m1(.input0(PC8_M-32'h8),.input1(PC8_E-32'h8),.s(PC8_M==32'h00000000),.out(cp0pc));/*********/
	 MUX_32_2_1 m10(.input0(cp0pc),.input1(PC8-32'h8),.s(PC8_E==32'h00000000),.out(cp0pc1));/*********/
	 MUX_32_2_1 m7(.input0(cp0pc1),.input1(PC8_W-32'h8),.s(epccW),.out(cp0pc2));
	 CP0 cp0(.A1(ins_M[15:11]),.A2(ins_M[15:11]),.Din(WriteDataM),.PC(cp0pc2),/*.ExcCode(),*/.HWint(HWInt),.we(Regwritecp0M),
	         .EXLset(Intreq),.EXLclr(iferetW),.clk(clk),.reset(reset),.Intreq(Intreq),.EPCoutput(EPC1),.Dout(cp0out));
    
	 wire [31:0] k;
	 assign k= (ALUOutM[31:2])<2048 ? DMoutput : PrRD;
    pipereg M_W1(.In(k),.Out(ReadDataW),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
    pipereg M_W2(.In(ALUOutM),.Out(ALUOutW),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
    pipereg5 M_W3(.In(WriteReg_M),.Out(WriteReg_W),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg M_W4(.In(ins_M),.Out(ins_W),.clk(clk),.EN(1'b1),.clr(reset|Intreq));/***********************/
	 pipereg M_W5(.In(PC8_M),.Out(PC8_W),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg1 M_W6(.In(RegWriteM),.Out(RegWriteW),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg1 M_W7(.In(MemtoRegM),.Out(MemtoRegW),.clk(clk),.EN(1'b1),.clr(reset|Intreq)); 
	 pipereg1 M_W8(.In(ifjalM),.Out(ifjalW),.clk(clk),.EN(1'b1),.clr(reset|Intreq)); 
	 pipereg1 M_W9(.In(ifjalrM),.Out(ifjalrW),.clk(clk),.EN(1'b1),.clr(reset|Intreq)); 
	 pipereg1 M_W10(.In(signM),.Out(signW),.clk(clk),.EN(1'b1),.clr(reset|Intreq)); 
	 pipereg3 M_W11(.In(whatM),.Out(whatW),.clk(clk),.EN(1'b1),.clr(reset|Intreq)); 
	 pipereg1 M_W12(.In(Regwritecp0M),.Out(Regwritecp0W),.clk(clk),.EN(1'b1),.clr(reset|Intreq)); 
	 pipereg1 M_W13(.In(iferetM),.Out(iferetW),.clk(clk),.EN(1'b1),.clr(reset|Intreq)); 
	 pipereg1 M_W14(.In(ifmfc0M),.Out(ifmfc0W),.clk(clk),.EN(1'b1),.clr(reset|Intreq)); 
	 pipereg M_W15(.In(cp0out),.Out(cp0outW),.clk(clk),.EN(1'b1),.clr(reset|Intreq));
	 pipereg1 M_W16(.In(epccM),.Out(epccW),.clk(clk),.EN(1'b1),.clr(reset|Intreq)); 
	 //controller W(.Op(ins_W[31:26]),.Funct(ins_W[5:0]),.Regwrite(RegWriteW),.Memtoreg(MemtoRegW),.ifjal(ifjalW));
	 wire [31:0] ReadDataWfinal;
	 dm_ext de(.A(ALUOutW[1:0]),.Din(ReadDataW),.sign(signW),.what(whatW),.Dout(ReadDataWfinal));

	 MUX_32_2_1 mux7(.input0(ALUOutW),.input1(ReadDataWfinal),.s(MemtoRegW),.out(WD1));
	 MUX_32_2_1 mux10(.input0(WD1),.input1(PC8_W),.s(ifjalW|ifjalrW),.out(WD2));
	 MUX_32_2_1 m3(.input0(WD2),.input1(cp0outW),.s(ifmfc0W),.out(WD));
	 
	 
	 wire [1:0] ForwardAE,ForwardBE;
	 wire ForwardAD,ForwardBD,StallD,StallF,FlushE;
	 hazard h(.Regwritecp0E(Regwritecp0E),.RdE(ins_E[15:11]),.ifmfc0(ifmfc0M),.busy(busy),.mf(mfD),.regwritemd(regwritemdD),.startE(startE),.startD(startD),.ifjalr(ifjalr),.ifbgez(bgez),.ifblez(blez),.ifbltz(bltz),.ifbne(ifbne),.ifbgtz(bgtz),.ifjr(ifjr),.BranchD(BranchD),.RsD(ins_D[25:21]),.RtD(ins_D[20:16]),.RsE(Rs_E),.RtE(Rt_E),.WriteRegE(WriteReg_E),.MemtoRegE(MemtoRegE),
	         .RegWriteE(RegWriteE),.WriteRegM(WriteReg_M),.MemtoRegM(MemtoRegM),.RegWriteM(RegWriteM),.WriteRegW(WriteReg_W),.RegWriteW(RegWriteW),
				.StallF(StallF),.StallD(StallD),.ForwardAD(ForwardAD),.ForwardBD(ForwardBD),.FlushE(FlushE),.ForwardAE(ForwardAE),.ForwardBE(ForwardBE));
	 
	 
	 assign PrAddr = ALUOutM[31:2];
	 //assign PrBE;
	 assign PrWD= WriteDataM;
	 assign PrWe= MemWriteM;
	 
endmodule
