`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:08:58 07/23/2017 
// Design Name: 
// Module Name:    alu 
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
module alu #(parameter width=16)
	(
    input [width-1:0] a,
    input [width-1:0] b,
    input [3:0] alu_op,
    output reg [width-1:0] y,
	output  alu_z
    );

wire 	[width-1:0] slt,temp;
parameter	set=16'h0001,clear=16'b0;
parameter add=4'b0000 , sub=4'b0001 , mul=4'b0010 , shr=4'b0011 , sl_t=4'b0100 , x_or=4'b0101 , o_r=4'b0110 , a_nd=4'b0111 , lui=4'b1100, beq=4'b1111 ;
//slt:
assign	temp=a-b;
assign	slt=(a[15]^b[15])?((a[15])?set:clear):(temp[15]?set:clear);

always@(*)
case(alu_op)
     add:	y<=a+b;
	 sub:	y<=temp;
     mul:	y<=a*b;
     shr:	y<={a[15],a[15:1]};
     sl_t:	y<=slt;
     x_or:	y<=a^b;
     o_r:	y<=a|b;
     a_nd:	y<=a&b;
	 lui:	y<={b[7:0],8'b0};
	 beq:   y<=a^b;
     default:	y<=clear;
endcase

//aluzero:
assign alu_z=(alu_op==beq && y==16'b0)?1'b1:1'b0;
endmodule

