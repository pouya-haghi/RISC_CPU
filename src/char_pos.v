`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:51:45 08/11/2017 
// Design Name: 
// Module Name:    char_pos 
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
module char_pos(
    input clk,
    input [10:0] x_count,
    input [9:0] y_count,
	input [10:0] x_pos,
    input [9:0] y_pos,
    input [3:0] char_add,
    output reg char_green0
	//output reg char_red0
    );

reg color;
reg [63:0] char_rom;
reg [7:0] temp;
reg [2:0] incrementer;	

always @(posedge clk) begin
   if(x_count==x_pos) begin //x_pos will always one pixel ahead of you want
      if(y_count==y_pos) begin
         color<=1'b1;
         temp<=char_rom[63:56];
	  end
	  else if(y_count==y_pos+10'd1) begin
         color<=1'b1;
         temp<=char_rom[55:48];
	  end
	  else if(y_count==y_pos+10'd2) begin
         color<=1'b1;
         temp<=char_rom[47:40];
	  end
	  else if(y_count==y_pos+10'd3) begin
         color<=1'b1;
         temp<=char_rom[39:32];
	  end
	  else if(y_count==y_pos+10'd4) begin
         color<=1'b1;
         temp<=char_rom[31:24];
	  end
	  else if(y_count==y_pos+10'd5) begin
         color<=1'b1;
         temp<=char_rom[23:16];
	  end
	  else if(y_count==y_pos+10'd6) begin
         color<=1'b1;
         temp<=char_rom[15:8];
	  end
	  else if(y_count==y_pos+10'd7) begin
         color<=1'b1;
         temp<=char_rom[7:0];
	  end
      else 
         color<=1'b0;
   end
   else 
      color<=1'b0;
end


always@(posedge clk) begin
if((color)||(incrementer)) begin char_green0<=(temp[3'd7-incrementer]);incrementer<=incrementer+3'd1;end
else      begin char_green0<=1'b0;end
end

// due to concurrency between multiple always blocks, screen will print x_pos+2(not x_pos) but y_pos is ok!
always @(*)
case (char_add)
4'h0: char_rom=64'b0000000000000000000000000000000000000000000110000001100000110000;//,
4'h1: char_rom=64'b0001100000111100011001100111111001100110011001100110011000000000;//A
4'h2: char_rom=64'b0111111001100000011000000111100001100000011000000111111000000000;//E
4'h3: char_rom=64'b0011110000011000000110000001100000011000000110000011110000000000;//I
4'h4: char_rom=64'b0110011001110110011111100111111001101110011001100110011000000000;//N
4'h5: char_rom=64'b0011110001100110011001100110011001100110011001100011110000000000;//O
4'h6: char_rom=64'b0111110001100110011001100111110001111000011011000110011000000000;//R
4'h7: char_rom=64'b0011110001100110011000000011110000000110011001100011110000000000;//S
4'h8: char_rom=64'b0110011001100110011001100110011001100110011001100011110000000000;//U
4'h9: char_rom=64'b0110001101100011011000110110101101111111011101110110001100000000;//W
4'ha: char_rom=64'b0110011001100110011001100011110000011000000110000001100000000000;//Y
4'hb: char_rom=64'b0000000000011000000110000000000000000000000110000001100000000000;//:
default: char_rom=64'b0;
endcase	
endmodule
