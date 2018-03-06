`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:19:22 11/14/2016 
// Design Name: 
// Module Name:    controller 
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
module controller(
    input [5:0] Op,
    input [5:0] Funct,
	 input [4:0] special,
	 input [4:0] special2,
    output  reg Regdst,
    output  reg ALUsrc,
    output  reg Memtoreg,
    output  reg Regwrite,
    output  reg Memwrite,	 
    output  reg ifbeq,
	 output  reg ifbne,
	 output  reg ifjal,	
	 output  reg ifjalr,
	 output  reg ifjr,
	 output  reg ifj,
    output  reg [1:0] EXTop,
    output  reg [4:0] ALUop,
	 output  reg [2:0] BEext_c,
	 output  reg [2:0] what,
	 //output  reg [2:0] Op,
	 output  reg sign,
	 
	 output  reg mthi,
	 output  reg mtlo,
	 output  reg regwritemd,
	 output  reg [1:0] MDop,
	 output  reg [1:0] mf,
	 output  ifmsub,
	 
	 output   bgtz,
	 output   bltz,
	 output bgez,
	 output blez,
	 output reg start,
	 
	 output reg Regwritecp0,
	 output reg iferet,
	 output reg ifmfc0,
	 input [31:0] ins
    );

initial begin 
  Regdst<=1'b0;
	 ALUsrc<=1'b0;
	 Memtoreg<=1'b0;
	Regwrite<=1'b0;
	  Memwrite<=1'b0;
	 ifbeq<=1'b0;
	 ifbne<=1'b0;
	  ifjal<=1'b0;
	 ifjr<=1'b0;
	 ifj<=1'b0;
	  EXTop[0]<=1'b0;
	 EXTop[1]<=1'b0; 
	 BEext_c<=3'b000;
	 what<=3'b000;
	 
	 ALUop[0]<=1'b0;
	  ALUop[1]<=1'b0;
	 ALUop[2]<=1'b0;
	 ALUop[3]<=1'b0;
	 ALUop[4]<=1'b0;
	 mthi<=1'b0;
	 mtlo<=1'b0;
	 regwritemd<=1'b0;
	 MDop<=2'b00;
	 start<=1'b0;
	 mf<=2'b00;
	// Op<=3'b000;
	 sign<=1'b0;
	 Regwritecp0<=1'b0;
	 iferet<=1'b0;
	 ifmfc0<=1'b0;
	
end
	
    wire addu=((Op==6'b000000)&(Funct==6'b100001));
	 wire add= ((Op==6'b000000)&(Funct==6'b100000));
	 wire subu=((Op==6'b000000)&(Funct==6'b100011));
	 wire sub= ((Op==6'b000000)&(Funct==6'b100010));
	 wire ori= (Op==6'b001101);
	 wire lw=  (Op==6'b100011);
	 wire sw=  (Op==6'b101011);
	 wire beq= (Op==6'b000100);
	 wire lui= (Op==6'b001111);
	 wire jal= (Op==6'b000011);//+instr_indext26
	 wire jr=  ((Op==6'b000000)&(Funct==6'b001000));
	 wire j=   (Op==6'b000010);
	 wire addi =(Op==6'b001000);
	 wire andi= (Op==6'b001100);
	 wire xorr= ((Op==6'b000000)&(Funct==6'b100110));
	 wire xori=  (Op==6'b001110);
	 wire addiu=(Op==6'b001001); //符号扩展
	 wire andd= ((Op==6'b000000)&(Funct==6'b100100));
	 wire orr=  ((Op==6'b000000)&(Funct==6'b100101));
	 wire norr= ((Op==6'b000000)&(Funct==6'b100111));
   
	 wire bne= (Op==6'b000101);
	 wire jalr= ((Op==6'b000000)&(Funct==6'b001001));
	 wire sllv= ((Op==6'b000000)&(Funct==6'b000100));
	 wire srlv= ((Op==6'b000000)&(Funct==6'b000110));
	 wire sll=  ((Op==6'b000000)&(Funct==6'b000000));
	 wire srl=  ((Op==6'b000000)&(Funct==6'b000010));
	 wire sra=  ((Op==6'b000000)&(Funct==6'b000011));
	 wire srav=  ((Op==6'b000000)&(Funct==6'b000111));
	 
	 wire sltu = ((Op==6'b000000)&(Funct==6'b101011));
	 wire sltiu= (Op==6'b001011);
	 wire slt =  ((Op==6'b000000)&(Funct==6'b101010));
	 wire slti= (Op==6'b001010);
	 
	 wire mult = ((Op==6'b000000)&(Funct==6'b011000));
	 wire multu= ((Op==6'b000000)&(Funct==6'b011001));
	 wire div =  ((Op==6'b000000)&(Funct==6'b011010));
	 wire divu=  ((Op==6'b000000)&(Funct==6'b011011));
	 wire mthii= ((Op==6'b000000)&(Funct==6'b010001));
	 wire mtloo= ((Op==6'b000000)&(Funct==6'b010011));
	 wire mflo=  ((Op==6'b000000)&(Funct==6'b010010));
	 wire mfhi=  ((Op==6'b000000)&(Funct==6'b010000));
	 
	 wire msub= ((Op==6'b011100)&(Funct==6'b000100));
	 assign ifmsub = ((Op==6'b011100)&(Funct==6'b000100))?1'b1:1'b0;
	 
	 assign bgtz= ((Op==6'b000111)&(special==5'b00000))?1'b1:1'b0;
	 assign bltz= ((Op==6'b000001)&(special==5'b00000))?1'b1:1'b0;
	 assign blez= ((Op==6'b000110)&(special==5'b00000))?1'b1:1'b0;//小于等于0
	 assign bgez= ((Op==6'b000001)&(special==5'b00001))?1'b1:1'b0;//大于等于0
	 
	 wire sb= (Op==6'b101000);
	 wire sh= (Op==6'b101001);
	 
	 wire lb= (Op==6'b100000);
	 wire lh= (Op==6'b100001);
	 wire lbu=(Op==6'b100100);
	 wire lhu=(Op==6'b100101);
	 
	 wire seb= ((Op==6'b011111)&(Funct==6'b100000)&(special2==5'b10000));
	 wire seh =((Op==6'b011111)&(Funct==6'b100000)&(special2==5'b11000));
	 wire wsbh=((Op==6'b011111)&(Funct==6'b100000)&(special2==5'b00010));
	 wire ext =((Op==6'b011111)&(Funct==6'b000000));
	 
	 wire mtc0= (Op==6'b010000)& (ins[25:21]== 5'b00100);
	 wire mfc0= (Op==6'b010000)& (ins[25:21]== 5'b00000);/***************/
	 wire eret= ins[31:0]==32'b0100_0010_0000_0000_0000_0000_0001_1000;

	 always@(*)begin
	 ///写给rd
	  Regdst<=wsbh|addu|subu|xorr|andd|orr|add|sub|norr|jalr|sllv|srlv|sll|srl|sra|srav|sltu|slt|mfhi|mflo|seb|seh;
	  ///alu要扩展出来的值
	  ALUsrc<=ori|lw|lb|lh|lbu|lhu|sw|sb|sh|lui|addi|andi|addiu|xori|sltiu|slti;
	 Memtoreg<=lw|lb|lh|lbu|lhu;
	 Regwrite<=(ins!=32'h00000000)&(mfc0|ext|wsbh|seh|seb|lb|lh|lbu|lhu|mfhi|mflo|slti|slt|sltiu|sltu|srav|addu|subu|add|sub|ori|lw|lui|jal|sltiu|addi|xorr|andi|addiu|andd|orr|norr|xori|jalr|sllv|srlv|sll|srl|sra);
	  Memwrite<=sw|sb|sh;
	 ifbeq<=beq;
	 ifbne<=bne;
	  ifjal<=jal;
	  ifjalr<=jalr;
	 ifjr<=jr;
	 ifj<=j;
	 EXTop[0]<=lw|sw|sb|sh|beq|bgtz|bltz|addi|addiu|bgez|blez|sltiu|slti|lb|lh|lbu|lhu|bne;
	 EXTop[1]<=lui; 
	 
	 ALUop[0]<=subu|sub|ori|beq|orr|norr|srlv|srl|srav|slt|slti|seh|ext;
	 ALUop[1]<=ori|andi|andd|orr|sllv|srlv|sra|srav|seb|seh;
	 ALUop[2]<=xorr|norr|xori|sllv|srlv|sltu|sltiu|slt|slti|seb|seh;
	 ALUop[3]<=sll|srl|sra|srav|sltu|sltiu|slt|slti|seb|seh;
	 ALUop[4]<=wsbh|ext;
	 
	 
	 
	 BEext_c[0]<=sw;
	 BEext_c[1]<=sh;
	 BEext_c[2]<=sb;
	 
	 what[0]<=lw;
	 what[1]<=lh|lhu;
	 what[2]<=lb|lbu;
	 
	 sign<=lb|lh;
	 
	 mthi<=mthii;
	 mtlo<=mtloo;
	 regwritemd<=mthii|mtloo;
	 
	 MDop[0]<=divu|div;
	 MDop[1]<=mult|div|msub;
	 mf[0]<=mflo;
	 mf[1]<=mfhi;
	 	 
	 start<=mult|multu|div|divu|msub;
	 
	 Regwritecp0<=mtc0;
	 iferet<= eret;
	 ifmfc0<= mfc0;
	 end
	 
endmodule
