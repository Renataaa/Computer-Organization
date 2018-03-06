`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:18:59 12/14/2016 
// Design Name: 
// Module Name:    CP0 
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
module CP0(
	input [4:0] A1,//��CP0�Ĵ������
	input [4:0] A2,//д
	input [31:0] Din, //Cp0�Ĵ�����д������
	input [31:0] PC,//�ж��쳣ʱ��PC
	//input [6:2] ExcCode,//�ж��쳣������
	input [5:0]HWint,//6���豸�ж�
	input we,
	input EXLset, //������λsr��exl
	input EXLclr,
	input clk,
	input reset,
	output Intreq, //�ж����� �����CPU������
	output [31:0] EPCoutput, //�����npc
	output [31:0] Dout// cp0�Ĵ������������
    );
   
	
	reg [31:0] SR,CAUSE,EPC,PRID;
	
	initial begin
	  SR<= 32'h00000000;
	  CAUSE<= 32'h00000000;
 	  EPC<= 32'h00000000;
	  PRID<= 32'h01010101;

	end
	
	assign Intreq = |(HWint[5:0] & SR [15:10]) & ~SR[1] &  SR[0];
	assign EPCoutput = (we && SR[1] && A2==5'd14)? Din :EPC;
	assign Dout= (A1==5'd12) ? SR :
			       (A1==5'd13) ? CAUSE:
			       (A1==5'd14) ? EPC :
			       (A1==5'd15) ? PRID : 0;
	
	always@(posedge clk)
		begin
			if(|(HWint[5:0]))/******************/
				begin
				CAUSE[15:10]<=HWint[5:0];
				end
			if(reset)
				begin
				SR<= 32'h00000000;
				CAUSE<= 32'h00000000;
				EPC<= 32'h00000000;
				end
			else 
				begin
					if(we & ~Intreq)
						begin
						case(A2)
						5'd12:SR=Din;
				 //   5'd13:CAUSE=Din;
				      5'd14:EPC=Din;
						endcase
						end
					if(EXLset)
							begin SR[1]<= 1'b1; end
					else if(EXLclr)
					      begin SR[1]<= 1'b0; end
					if(Intreq)
						begin
						EPC<= PC;
						end						
				end				
		end

endmodule
