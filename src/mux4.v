`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:42:31 07/22/2017 
// Design Name: 
// Module Name:    mux4 
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
module mux4 #(parameter width=4)
	(
    input [width-1:0] a,
    input [width-1:0] b,
	input [width-1:0] c,
    input [width-1:0] d,
    input [1:0] s,
    output [width-1:0] y
    );

assign	y=s[0]?(s[1]?d:b):(s[1]?c:a);
endmodule
