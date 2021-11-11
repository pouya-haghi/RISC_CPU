`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:48:15 08/20/2017 
// Design Name: 
// Module Name:    rom 
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
module rom
(
	input [1:0] ad,
    output  reg [63:0] data
    );

always @(*)
case(ad)	
2'b00:   data<=64'h0001000000000000;
2'b01:   data<=64'hfedcba9876543210;
2'b10:   data<=64'h0123456789abcdef;
default: data<=64'h0000000000000000;
endcase
endmodule
