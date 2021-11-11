`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:22:04 07/23/2017 
// Design Name: 
// Module Name:    flop_enr 
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
module flop_enr #(parameter width=1)
	(
    input [width-1:0] d,
    input clk,
    input en,
    input rst,
    output reg [width-1:0] q
    );

always @(posedge clk)
begin
	if(rst)		q<=0;
	else 
	begin
		if(!en)	q<=q;
		else	q<=d; 
	end
end
endmodule
