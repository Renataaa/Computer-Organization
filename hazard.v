`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:10:14 11/29/2016 
// Design Name: 
// Module Name:    hazard 
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
module hazard(
    
	 input BranchD,
	 input ifbne,
	 input [4:0]RsD,
	 input [4:0]RtD,
	 input [4:0]RsE,
	 input [4:0]RtE, 
	 input [4:0] WriteRegE,
	 input MemtoRegE,
	 input RegWriteE,
	 input [4:0] WriteRegM,
	 input MemtoRegM,	 
	 input RegWriteM,
	 input [4:0]WriteRegW,
	 input RegWriteW,
	 input ifjr,
	 input ifbgtz,
	 input ifbltz,
	 input ifbgez,
	 input ifblez,
	 input ifjalr,
	 
	 input busy,
	 input [1:0]mf, //两位
	 input regwritemd,
	 input startE,
	 input startD,
	 
	 output StallF,
	 output StallD,
	
	 output ForwardAD,
	 output ForwardBD,
	 output FlushE,
	 output [1:0]ForwardAE,
	 output [1:0]ForwardBE,
	 output ForwardM,
	 input ifmfc0,
	 input Regwritecp0E,
	 input [4:0] RdE
    );
	
	 assign ForwardAE=((RsE!=5'b00000)&(RsE==WriteRegM)&RegWriteM&ifmfc0)?2'b11:
	                  ((RsE!=5'b00000)&(RsE==WriteRegM)&RegWriteM)?2'b10:
	                  ((RsE!=5'b00000)&(RsE==WriteRegW)&RegWriteW)?2'b01:2'b00;
							
	 assign ForwardBE=((RtE!=5'b00000)&(RtE==WriteRegM)&RegWriteM&ifmfc0)?2'b11:
	                  ((RtE!=5'b00000)&(RtE==WriteRegM)&RegWriteM)?2'b10:
	                  ((RtE!=5'b00000)&(RtE==WriteRegW)&RegWriteW)?2'b01:2'b00;
							
	 assign ForwardAD =(RsD!=5'b00000)&(RsD==WriteRegM)&RegWriteM;
	 assign ForwardBD =(RtD!=5'b00000)&(RtD==WriteRegM)&RegWriteM;
///assign ForwardM=(MemWriteM && RegWriteW && WriteRegW==RtM && DatatoregW==2'b01 && WriteRegW!=0)||(MemWriteM && RegWriteW && WriteRegW==RtM && DatatoregW==2'b11  && WriteRegW!=0);

    //assign ForwardM = (MemWriteM && RegWriteW && WriteRegW==RtM && ifmtc0  && WriteRegW!=0);	/// W
    
    wire lwstall;
    assign lwstall= ((RsD==RtE)|(RtD==RtE))& (MemtoRegE);
       
	 wire branchstall;
	 assign branchstall =(BranchD & RegWriteE &(WriteRegE==RsD | WriteRegE ==RtD)) 
	                     |(BranchD & MemtoRegM &(WriteRegM==RsD | WriteRegM ==RtD));
	 
	 wire bnestall;
	 assign bnestall =(ifbne & RegWriteE &(WriteRegE==RsD | WriteRegE ==RtD)) 
	                     |(ifbne & MemtoRegM &(WriteRegM==RsD | WriteRegM ==RtD));
								
	wire bgtzstall;
	assign bgtzstall= ((ifbgtz|ifbgez) & RegWriteE &(WriteRegE==RsD)) 
	                     |((ifbgtz|ifbgez) & MemtoRegM &(WriteRegM==RsD));
  
   wire bltzstall;
	assign bltzstall= ((ifbltz|ifblez) & RegWriteE &(WriteRegE==RsD)) 
	                     |((ifbltz|ifblez) & MemtoRegM &(WriteRegM==RsD));
								
	 wire jrstall;
    assign jrstall =((ifjr|ifjalr) & RegWriteE &(WriteRegE==RsD)) 
	                     |((ifjr|ifjalr) & MemtoRegM &(WriteRegM==RsD));
								
	 wire mdstall;
    assign mdstall= ((busy|startE)&(mf!=0|regwritemd!=0|startD!=0));	 
    
	 wire cp0stall;
	 assign cp0stall= (Regwritecp0E && RdE==5'd14);////为什么只有14暂停
	 
	 assign StallF=lwstall|branchstall|jrstall|bgtzstall|bnestall|bltzstall|mdstall;	 
	 assign StallD=lwstall|branchstall|jrstall|bgtzstall|bnestall|bltzstall|mdstall;	  	 
	 assign FlushE=lwstall|branchstall|jrstall|bgtzstall|bnestall|bltzstall|mdstall;	  	 
	 
	 
endmodule
