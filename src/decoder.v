`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:43:07 08/18/2017 
// Design Name: 
// Module Name:    decoder 
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
module decoder(
    input [15:0] add,
    input en,
    output reg [1:0] y
    );

always@(*)
if(en) begin
if(&add[15:13]) y<=2'b10;
else            y<=2'b01;
end
else   y<=2'b00;
endmodule
