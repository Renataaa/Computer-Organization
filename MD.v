`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:20:58 12/06/2016 
// Design Name: 
// Module Name:    MD 
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
module MD(
    input [31:0] In1,
	 input [31:0] In2,
	 input start,
	 input [1:0] MDop,
	 //output reg [31:1] out,
	 output reg [31:0] HI,
	 output reg [31:0] LO,
	 input  mthi,
	 input  mtlo,
	 input regwritemd,
	 input clk,
	 input reset,
	 input ifmsub,
	 output reg busy
    );
    
	 integer i;
	 
	 initial begin
	         HI<=32'h0000_0000;
				LO<=32'h0000_0000;
				busy<=1'b0;
	         end
	 
	 always @(posedge clk)
		begin
			if(reset)
				begin
				HI<=32'h0000_0000;
				LO<=32'h0000_0000;
				end
		     else if(regwritemd)
			          begin
						 if(mthi)
						    HI<=In1;
							 else if(mtlo)
							 LO<=In1;
						 end
		   
			if(start)
				begin if(MDop==2'b00)  //ÎÞ·ûºÅ³Ë
				          begin 
							 {HI,LO}<=In1*In2;
							 busy<=1'b1;
							 i<=4;
						//$display (" +++HI=%h LO=%h",HI,LO);
							 end
			          else if(MDop==2'b01) //ÎÞ·ûºÅ³ý
									begin
									HI<=In1%In2;
									LO<=In1/In2;
									busy<=1'b1;
							      i<=9;
									//$display (" +++HI=%h LO=%h",HI,LO);
									end
		             else if(MDop==2'b10) //ÓÐ·ûºÅ³Ë
						         begin
										if(ifmsub)begin
										           {HI,LO}<={HI,LO}-$signed(In1)*$signed(In2);
													  busy<=1'b1;
							                    i<=4;
													//$display (" +++HI=%h LO=%h",HI,LO);
										           end
											 else begin
									          {HI,LO}<=$signed(In1)*$signed(In2);
									          busy<=1'b1;
							                 i<=4;
												 //$display (" +++HI=%h LO=%h",HI,LO);
												 end
									end
						 else if(MDop==2'b11) //ÓÐ·ûºÅ³ý
		                     begin
									LO<=$signed(In1)/$signed(In2);
					            HI<=$signed(In1)%$signed(In2);
									busy<=1'b1;
							      i<=9;
									// $display (" +++HI=%h LO=%h",HI,LO);
									end
				end
				else    
            begin
		        if(i>0)
			         begin 
						i<=i-1;
				      end
		            else
			            begin busy<=1'b0; 
					      end
			    end
	end
									
									

endmodule
