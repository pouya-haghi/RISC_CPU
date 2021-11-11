`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:42:46 08/28/2017 
// Design Name: 
// Module Name:    counter 
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
module counter #(parameter numbit=8)
(
    input clk,
    input rst,
    input en,
    output reg carry
    );

reg [numbit-1:0] count;
always@(posedge clk)
if(rst) {carry,count}<=0;
else begin
if(en) {carry,count}<=count+1;
end
endmodule
