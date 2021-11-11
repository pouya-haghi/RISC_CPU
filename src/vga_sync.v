`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:48:54 08/11/2017 
// Design Name: 
// Module Name:    vga_sync 
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
module vga_sync(
    input clk,
    output reg h_sync,
    output reg v_sync,
    output reg valid,
    output reg [10:0] x_counter,
    output reg [9:0] y_counter
    );
	
reg  x_rst,y_rst;
wire y_en;
//resolution: 1288*480 @pixel clock=50Mhz
//counters for positioning pixels and synchronizing:
always @(posedge clk)
begin
if(x_rst) x_counter<=11'b0;
else      x_counter<=x_counter+11'd1;

if(y_rst) y_counter<=10'b0;
  else if(y_en) y_counter<=y_counter+10'd1;
    else           y_counter<=y_counter;
end

//reset and enable signals:
always @(posedge clk) 
begin
x_rst<=(x_counter==11'd1586);
y_rst<=(y_counter==10'd527 && x_counter==11'd1586);
end

//synchronization:
always @(posedge clk) 
begin
h_sync<=~((x_counter>=11'd1304) && (x_counter<=11'd1493));
v_sync<=~((y_counter==10'd493) || (y_counter==10'd494));
valid<=((x_counter==11'd1587) || (y_counter<=10'd479 && x_counter<=11'd1287));
end

assign y_en=x_rst;
endmodule
