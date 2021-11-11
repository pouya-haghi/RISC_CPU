`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:45:07 08/19/2017 
// Design Name: 
// Module Name:    array_shifter 
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
module array_shifter(
    input [15:0] data,
    input en,
	input clk,
    output reg [287:0] SIPO
    );
	
always @(posedge clk)
if(en) begin
SIPO[287:272]<=data;
SIPO[15:0] <=SIPO[31:16];
SIPO[31:16]<=SIPO[47:32];
SIPO[47:32]<=SIPO[63:48];
SIPO[63:48]<=SIPO[79:64];
SIPO[79:64]<=SIPO[95:80];
SIPO[95:80] <=SIPO[111:96];
SIPO[111:96] <=SIPO[127:112];
SIPO[127:112]<=SIPO[143:128];
SIPO[143:128]<=SIPO[159:144];
SIPO[159:144]<=SIPO[175:160];
SIPO[175:160]<=SIPO[191:176];
SIPO[191:176]<=SIPO[207:192];
SIPO[207:192]<=SIPO[223:208];
SIPO[223:208] <=SIPO[239:224];
SIPO[239:224] <=SIPO[255:240];
SIPO[255:240]<=SIPO[271:256];
SIPO[271:256]<=SIPO[287:272];

end
endmodule
