`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:58:35 07/23/2017 
// Design Name: 
// Module Name:    datamem 
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
module datamem #(parameter width=16)
	(
	input [width-1:0] di,
    input [13:0] ad,
    input clk,
    input we,
    output reg [width-1:0] dout
    );
reg [width-1:0] mem [16383:0];
always @(posedge clk)
begin

	if(we)	mem[ad]<=di;
	else 	dout<=mem[ad];
	
end
endmodule
