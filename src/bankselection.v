`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:41:51 08/03/2017 
// Design Name: 
// Module Name:    bankselection 
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
module bankselection(
    input bank_en,
    input rst,
    input clk,
    output [1:0] q
    );

reg [1:0] state,nextstate;
//mealy state machine:
always @(posedge clk)
if(rst) state<=2'b0;
else    state<=nextstate;

always @(state or bank_en)
case (state)
2'b00:      if(bank_en) nextstate<=2'b01;
            else        nextstate<=2'b00;
2'b01:	    if(bank_en) nextstate<=2'b10;
            else        nextstate<=2'b01;
2'b10:      if(bank_en) nextstate<=2'b11;
            else        nextstate<=2'b10;	
2'b11:      if(bank_en) nextstate<=2'b00;
            else        nextstate<=2'b11;
default:                nextstate<=2'b00;
endcase

//output logic:
assign  q=(bank_en)?nextstate:state;
endmodule
