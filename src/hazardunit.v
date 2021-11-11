`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:16:13 07/29/2017 
// Design Name: 
// Module Name:    hazardunit 
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
module hazardunit(
    input [3:0] rr1,
    input [3:0] rr2,
    input [3:0] wr_exe,
    input [3:0] wr_mem,
    input load_cexe,
	input load_cmem,	
	input forget_src2,
	input rfile_we_cexe,
	input rfile_we_cmem,
    input rst,
    input clk,
    output [1:0] dr1_src,
    output [1:0] dr2_src,
    output stall_ld
    );

//care must be taken: stall signals are all active low	
reg state,nextstate;
wire l; //temp variable to know when to stall & flush

//data forwarding: 1-reg RAW hazard 2-load RAW hazard after 1 clock
assign		dr1_src=(rr1==wr_exe && rfile_we_cexe==1'b1)?2'b01:((rr1==wr_mem && rfile_we_cmem==1'b1)?((load_cmem)?2'b11:2'b00):2'b10);
assign		dr2_src=(rr2==wr_exe && forget_src2==1'b0 && rfile_we_cexe==1'b1)?2'b01:((rr2==wr_mem && forget_src2==1'b0 && rfile_we_cmem==1'b1)?((load_cmem==1'b1)?2'b11:2'b00):2'b10);
assign      l=(rr1==wr_exe && load_cexe==1'b1 || (rr2==wr_exe && forget_src2==1'b0 && load_cexe==1'b1))?1'b1:1'b0;

//load RAW hazrd:
//mealy state machine for stalling pc,ir,dec and flushing exe:
//since after stall the instruction is as before we adopt a FSM to fix it
always @(posedge clk)
if(rst)	state<=1'b0;
else    state<=nextstate;

//nextstate logic:
always @(l or state)		
case (state)
1'b0:   if(l) nextstate<=1'b1;
		else  nextstate<=1'b0;
1'b1:   if(l) nextstate<=1'b0;
		else  nextstate<=1'b0;
endcase

//output logic:
assign  stall_ld=state | ~l;
endmodule
