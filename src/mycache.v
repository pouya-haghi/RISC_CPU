`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:17:48 08/20/2017 
// Design Name: 
// Module Name:    mycache 
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
module myram(
    input [15:0] add,
    input [15:0] data_in,
    input  cache_we,
    input clk,
    output [15:0] data_out
    );

reg [15:0] RAM[15:0];
always@(posedge clk)
if(cache_we) RAM[add[5:2]]<=data_in;

assign data_out=RAM[add[5:2]];
endmodule