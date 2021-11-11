`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:51:32 08/20/2017 
// Design Name: 
// Module Name:    top 
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
module top(
input [15:0] data,
input [15:0] add,
input [1:0] ad,
input modified_mem_we,
	input we,
	input rst,
	input clk,
    output hit,
    output [15:0] data_out,
	output [3:0] replacu,
	output uu,
	output v0,
	output v1,
	output d0,
	output d1,
	output sd_we
    );
	
wire [63:0] data_in;
wire [63:0]replace;
cache     mm(data_in,data,add,modified_mem_we,we,rst,clk,hit,data_out,replace,uu,v0,v1,d0,d1,sd_we);
rom       rr(ad,data_in);
assign replacu=replace[19:16];
endmodule