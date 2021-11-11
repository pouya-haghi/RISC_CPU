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
module mytag(
    input [15:0] add,
    input cache_we,
    input clk,
    output [9:0] data_out
    );

reg [9:0] TAG[15:0];
always@(posedge clk)
if(cache_we) TAG[add[5:2]]<=add[15:6];

assign data_out=TAG[add[5:2]];
endmodule