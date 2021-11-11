`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:32:34 07/24/2017 
// Design Name: 
// Module Name:    flopr 
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
module flop_r #(parameter width=1)
	(
    input [width-1:0] d,
    input clk,
    input rst,
    output  reg [width-1:0] q
    );

always @(posedge clk)
if(rst)		q<=0;
else		q<=d;
endmodule
