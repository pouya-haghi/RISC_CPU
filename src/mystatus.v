`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:12:07 08/22/2017 
// Design Name: 
// Module Name:    mystatus 
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
module mystatus(
    input data_in,
    input [3:0]address,
    input clk,
	input we,
    output data_out
    );

reg [15:0] mem;	
always @(posedge clk)
if(we) mem[address]<=data_in;

assign data_out=mem[address];
endmodule
