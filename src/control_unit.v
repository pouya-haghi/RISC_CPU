`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:56:34 07/27/2017 
// Design Name: 
// Module Name:    control_unit 
// Proflush_irect Name: 
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
module control_unit(
    input B_taken, 
    input [3:0] aluop_cdec, 
    input [3:0] opcode,
	input clk,
	input rst,
	output reg pc_src,
    output reg rr1_src,
    output reg rr2_src,
    output reg wr_src,
    output reg format_sel,
    output reg [9:0] c_dec_in,
	output reg flush_ir,
	output bank_en
    );

//care must be taken: stall signals are all active low	
parameter add=4'b0000, sub=4'b0001, mul=4'b0010, shr=4'b0011, slt=4'b0100, xo_r=4'b0101, o_r=4'b0110, a_nd=4'b0111, adi=4'b1000, st=4'b1001, ld=4'b1010, div=4'b1011, lui=4'b1100, beq=4'b1101, jmp=4'b1110 , jal=4'b1111;

always @(*)
case(opcode[3:0])
//R-format:
add:   begin pc_src<=1'b0;rr1_src<=1'b1;rr2_src<=1'b1;wr_src<=1'b0;c_dec_in[0]<=1'b0;c_dec_in[4:1]<=opcode;c_dec_in[5]<=1'b0;c_dec_in[6]<=1'b0;c_dec_in[7]<=1'b1;flush_ir<=1'b0;format_sel<=1'b0;c_dec_in[8]<=1'b0;c_dec_in[9]<=1'b0;end
sub:   begin pc_src<=1'b0;rr1_src<=1'b1;rr2_src<=1'b1;wr_src<=1'b0;c_dec_in[0]<=1'b0;c_dec_in[4:1]<=opcode;c_dec_in[5]<=1'b0;c_dec_in[6]<=1'b0;c_dec_in[7]<=1'b1;flush_ir<=1'b0;format_sel<=1'b0;c_dec_in[8]<=1'b0;c_dec_in[9]<=1'b0;end
mul:   begin pc_src<=1'b0;rr1_src<=1'b1;rr2_src<=1'b1;wr_src<=1'b0;c_dec_in[0]<=1'b0;c_dec_in[4:1]<=opcode;c_dec_in[5]<=1'b0;c_dec_in[6]<=1'b0;c_dec_in[7]<=1'b1;flush_ir<=1'b0;format_sel<=1'b0;c_dec_in[8]<=1'b0;c_dec_in[9]<=1'b0;end
shr:   begin pc_src<=1'b0;rr1_src<=1'b1;rr2_src<=1'b1;wr_src<=1'b0;c_dec_in[0]<=1'b0;c_dec_in[4:1]<=opcode;c_dec_in[5]<=1'b0;c_dec_in[6]<=1'b0;c_dec_in[7]<=1'b1;flush_ir<=1'b0;format_sel<=1'b0;c_dec_in[8]<=1'b0;c_dec_in[9]<=1'b1;end
slt:   begin pc_src<=1'b0;rr1_src<=1'b1;rr2_src<=1'b1;wr_src<=1'b0;c_dec_in[0]<=1'b0;c_dec_in[4:1]<=opcode;c_dec_in[5]<=1'b0;c_dec_in[6]<=1'b0;c_dec_in[7]<=1'b1;flush_ir<=1'b0;format_sel<=1'b0;c_dec_in[8]<=1'b0;c_dec_in[9]<=1'b0;end
xo_r:  begin pc_src<=1'b0;rr1_src<=1'b1;rr2_src<=1'b1;wr_src<=1'b0;c_dec_in[0]<=1'b0;c_dec_in[4:1]<=opcode;c_dec_in[5]<=1'b0;c_dec_in[6]<=1'b0;c_dec_in[7]<=1'b1;flush_ir<=1'b0;format_sel<=1'b0;c_dec_in[8]<=1'b0;c_dec_in[9]<=1'b0;end
o_r:   begin pc_src<=1'b0;rr1_src<=1'b1;rr2_src<=1'b1;wr_src<=1'b0;c_dec_in[0]<=1'b0;c_dec_in[4:1]<=opcode;c_dec_in[5]<=1'b0;c_dec_in[6]<=1'b0;c_dec_in[7]<=1'b1;flush_ir<=1'b0;format_sel<=1'b0;c_dec_in[8]<=1'b0;c_dec_in[9]<=1'b0;end
a_nd:  begin pc_src<=1'b0;rr1_src<=1'b1;rr2_src<=1'b1;wr_src<=1'b0;c_dec_in[0]<=1'b0;c_dec_in[4:1]<=opcode;c_dec_in[5]<=1'b0;c_dec_in[6]<=1'b0;c_dec_in[7]<=1'b1;flush_ir<=1'b0;format_sel<=1'b0;c_dec_in[8]<=1'b0;c_dec_in[9]<=1'b0;end
//I-format:
adi:   begin flush_ir<=1'b0;pc_src<=1'b0;rr1_src<=1'b0;rr2_src<=1'b0;wr_src<=1'b1;format_sel<=1'b0;c_dec_in[0]<=1'b1;c_dec_in[4:1]<=4'b0000;c_dec_in[5]<=1'b0;c_dec_in[6]<=1'b0;c_dec_in[7]<=1'b1;c_dec_in[8]<=1'b0;c_dec_in[9]<=1'b1;end
st:	   begin flush_ir<=1'b0;pc_src<=1'b0;rr1_src<=1'b0;rr2_src<=1'b0;format_sel<=1'b0;c_dec_in[0]<=1'b1;c_dec_in[4:1]<=4'b0000;c_dec_in[5]<=1'b1;c_dec_in[7]<=1'b0;wr_src<=1'b1;c_dec_in[6]<=1'b0;c_dec_in[8]<=1'b0;c_dec_in[9]<=1'b0;end
ld:    begin flush_ir<=1'b0;pc_src<=1'b0;rr1_src<=1'b0;rr2_src<=1'b0;wr_src<=1'b1;format_sel<=1'b0;c_dec_in[0]<=1'b1;c_dec_in[4:1]<=4'b0000;c_dec_in[5]<=1'b0;c_dec_in[6]<=1'b1;c_dec_in[7]<=1'b1;c_dec_in[8]<=1'b1;c_dec_in[9]<=1'b1;end
div:   begin pc_src<=1'b0;rr1_src<=1'b1;rr2_src<=1'b1;wr_src<=1'b0;c_dec_in[0]<=1'b0;c_dec_in[4:1]<=opcode;c_dec_in[5]<=1'b0;c_dec_in[6]<=1'b0;c_dec_in[7]<=1'b1;flush_ir<=1'b0;format_sel<=1'b0;c_dec_in[8]<=1'b0;c_dec_in[9]<=1'b0;end
lui:   begin flush_ir<=1'b0;pc_src<=1'b0;rr1_src<=1'b0;rr2_src<=1'b0;wr_src<=1'b1;format_sel<=1'b0;c_dec_in[0]<=1'b1;c_dec_in[4:1]<=4'b1100;c_dec_in[5]<=1'b0;c_dec_in[6]<=1'b0;c_dec_in[7]<=1'b1;c_dec_in[8]<=1'b0;c_dec_in[9]<=1'b0;end
beq:   begin flush_ir<=(B_taken);rr1_src<=1'b0;rr2_src<=1'b0;wr_src<=1'b1;format_sel<=1'b0;c_dec_in[0]<=1'b0;c_dec_in[4:1]<=4'b1111;c_dec_in[5]<=1'b0;c_dec_in[7]<=1'b0;c_dec_in[6]<=1'b0;c_dec_in[8]<=1'b0;c_dec_in[9]<=1'b0;pc_src<=(B_taken);end
//j-format:
jmp:   begin pc_src<=1'b1;format_sel<=1'b1;flush_ir<=1'b1;rr1_src<=1'b1;rr2_src<=1'b1;wr_src<=1'b0;c_dec_in[0]<=1'b0;c_dec_in[4:1]<=4'b0000;c_dec_in[6]<=1'b0;c_dec_in[8]<=1'b0;c_dec_in[9]<=1'b0;
//internal flush:
c_dec_in[5]<=1'b0;c_dec_in[7]<=1'b0;end
jal:   begin pc_src<=1'b1;format_sel<=1'b1;flush_ir<=1'b1;rr1_src<=1'b1;rr2_src<=1'b1;wr_src<=1'b0;c_dec_in[0]<=1'b0;c_dec_in[4:1]<=4'b0000;c_dec_in[6]<=1'b0;c_dec_in[8]<=1'b0;c_dec_in[9]<=1'b0;
//internal flush:
c_dec_in[5]<=1'b0;c_dec_in[7]<=1'b0;end
default: begin flush_ir<=1'b0;pc_src<=1'b0;c_dec_in[5]<=1'b0;c_dec_in[7]<=1'b0;format_sel<=1'b0;c_dec_in[6]<=1'b0;c_dec_in[4:1]<=4'b0000;c_dec_in[0]<=1'b0;rr1_src<=1'b1;rr2_src<=1'b1;wr_src<=1'b0;c_dec_in[8]<=1'b0;c_dec_in[9]<=1'b0;end
endcase

//bank selection: I-format after shr instruction
assign bank_en=(aluop_cdec==4'b0011 && opcode[3]==1'b1 && opcode[2:1]!=2'b11)?1'b1:1'b0;
	

endmodule