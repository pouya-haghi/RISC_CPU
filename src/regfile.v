`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:05:39 07/23/2017 
// Design Name: 
// Module Name:    regfile 
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
module regfile #(parameter width=16)
	(
    input [3:0] rr1,
    input [3:0] rr2,
    input [3:0] wr,
    input [width-1:0] wd,
    input clk,
    input we,
    output [width-1:0] dr1,
    output [width-1:0] dr2
    );
reg	 [width-1:0] mem [width-1:0];

always @(posedge clk)
if(we)	mem[wr]<=wd;
else	mem[wr]<=mem[wr];

//register 0 is hardwired to 0 and register 15 to ffff	
assign	dr1=rr1?((&rr1)?16'hffff:mem[rr1]):16'b0;
assign	dr2=rr2?((&rr2)?16'hffff:mem[rr2]):16'b0;	
endmodule