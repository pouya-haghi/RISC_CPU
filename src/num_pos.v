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
module num_pos(
    input clk,
    input [10:0] x_count,
    input [9:0] y_count,
	input [10:0] x_pos,
    input [9:0] y_pos,
    input [3:0] num_add,
    output reg num_green0
    );

reg color;
reg [63:0] num_rom;
reg [7:0] temp;
reg [2:0] incrementer;	

always @(posedge clk) begin
   if(x_count==x_pos) begin //x_pos will always one pixel ahead of you want
      if(y_count==y_pos) begin
         color<=1'b1;
         temp<=num_rom[63:56];
	  end
	  else if(y_count==y_pos+10'd1) begin
         color<=1'b1;
         temp<=num_rom[55:48];
	  end
	  else if(y_count==y_pos+10'd2) begin
         color<=1'b1;
         temp<=num_rom[47:40];
	  end
	  else if(y_count==y_pos+10'd3) begin
         color<=1'b1;
         temp<=num_rom[39:32];
	  end
	  else if(y_count==y_pos+10'd4) begin
         color<=1'b1;
         temp<=num_rom[31:24];
	  end
	  else if(y_count==y_pos+10'd5) begin
         color<=1'b1;
         temp<=num_rom[23:16];
	  end
	  else if(y_count==y_pos+10'd6) begin
         color<=1'b1;
         temp<=num_rom[15:8];
	  end
	  else if(y_count==y_pos+10'd7) begin
         color<=1'b1;
         temp<=num_rom[7:0];
	  end
      else 
         color<=1'b0;
   end
   else 
      color<=1'b0;
end

always@(posedge clk) begin
if((color)||(incrementer)) begin num_green0<=(temp[3'd7-incrementer]);incrementer<=incrementer+3'd1;end
else      num_green0<=1'b0;
end

// due to concurrency between multiple always blocks, screen will print x_pos+2(not x_pos) but y_pos is ok!
always @(*) 
case(num_add)
4'h0:num_rom=64'b0011110001100110011001100110011001100110011001100011110000000000;//0
4'h1:num_rom=64'b0001100000011000001110000001100000011000000110000111111000000000;//1
4'h2:num_rom=64'b0011110001100110000001100000110000110000011000000111111000000000;//2
4'h3:num_rom=64'b0011110001100110000001100001110000000110011001100011110000000000;//3
4'h4:num_rom=64'b0000011000001110000111100110011001111111000001100000011000000000;//4
4'h5:num_rom=64'b0111111001100000011111000000011000000110011001100011110000000000;//5
4'h6:num_rom=64'b0011110001100110011000000111110001100110011001100011110000000000;//6
4'h7:num_rom=64'b0111111001100110000011000001100000011000000110000001100000000000;//7
4'h8:num_rom=64'b0011110001100110011001100011110001100110011001100011110000000000;//8
4'h9:num_rom=64'b0011110001100110011001100011111000000110011001100011110000000000;//9
4'ha:num_rom=64'b0001100000111100011001100111111001100110011001100110011000000000;//A
4'hb:num_rom=64'b0111110001100110011001100111110001100110011001100111110000000000;//B
4'hc:num_rom=64'b0011110001100110011000000110000001100000011001100011110000000000;//C
4'hd:num_rom=64'b0111100001101100011001100110011001100110011011000111100000000000;//D
4'he:num_rom=64'b0111111001100000011000000111100001100000011000000111111000000000;//E
4'hf:num_rom=64'b0111111001100000011000000111100001100000011000000110000000000000;//F
endcase		
endmodule
