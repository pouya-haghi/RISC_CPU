`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:14:34 07/30/2017 
// Design Name: 
// Module Name:    branchprediction 
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
module branchprediction(
	input [3:0] alu_op,
    input alu_z,
    input rst,
    input clk,
    output B_taken,
	output flush_T_mis,
	output flush_NT_mis
    );

parameter strong_NT=2'b00, weak_NT=2'b11, weak_T=2'b01, strong_T=2'b10;
reg [1:0] state,nextstate;

//moore state machine for B_taken and mealy for flushes:
always @(posedge clk)
if(rst)  state<=2'b00;
else     state<=nextstate;

//|(alu_op) means instrution is beq @ exe stage
always @(*)
case(state)
strong_NT: if(alu_z) nextstate<=weak_NT;
           else      nextstate<=strong_NT;
weak_NT:   begin if(alu_z) nextstate<=weak_T;
		   else if ((!alu_z) && (|alu_op)) nextstate<=strong_NT;
		   else      nextstate<=weak_NT;end
weak_T:    begin if(alu_z) nextstate<=strong_T;
		   else if ((!alu_z) && (|alu_op)) nextstate<=weak_NT;
		   else      nextstate<=weak_T;end
strong_T:  begin if(alu_z) nextstate<=strong_T;
		   else if ((!alu_z) && (|alu_op)) nextstate<=weak_T;
		   else      nextstate<=strong_T;end
endcase

//output logic:
assign   B_taken=state[0]^state[1];
assign   flush_T_mis=(((state==strong_NT && (alu_z)))||(state==weak_NT && (alu_z))||(state==weak_T && (!alu_z) && (|alu_op))||(state==strong_T && (!alu_z) && (|alu_op)))?1'b1:1'b0;
assign   flush_NT_mis=((state==weak_T && (!alu_z) && (|alu_op))||(state==strong_T && (!alu_z) && (|alu_op)))?1'b1:1'b0;
endmodule