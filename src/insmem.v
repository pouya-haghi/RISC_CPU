`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:00:50 07/23/2017 
// Design Name: 
// Module Name:    insmem 
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
module insmem #(parameter width=16)
	(
	input [15:0] add,
    output  reg [width-1:0] data
    );

always @(*)
case(add)	
16'h0000:   data<=16'h8112;
16'h0001:   data<=16'h0002;
16'h0002:   data<=16'h0003;
16'h0003:   data<=16'h10f4;
16'h0004:   data<=16'hd905;
16'h0005:   data<=16'h0343;
16'h0006:   data<=16'h1344;
16'h0007:   data<=16'h12f2;
16'h0008:	data<=16'h93ff;
16'h0009:   data<=16'heffa;
16'h000a:   data<=16'h0000;
16'h000b:   data<=16'heffe;
default:    data<=16'h0000;
endcase
endmodule
