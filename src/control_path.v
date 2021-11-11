`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:51:25 07/27/2017 
// Design Name: 
// Module Name:    controlunit 
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
module controlpath(
input stall_cmis,
input  [15:0] datamem_writedata,
    input flush_T_mis,
    input B_taken,
    input [3:0] opcode,
	input clk,
	input rst,
	input stall_ld,
    output rr1_src,
    output rr2_src,
    output wr_src,
    output format_sel,
    output rfile_we,
    output alu_src,
    output [3:0] alu_op,
    output mem_we,
    output wd_src,
	output flush_ir,
	output pc_src,
	output load_cexe,
	output load_cmem,
	output forget_scr2,
	output rfile_we_cexe,
	output rfile_we_cmem,
	output bank_en,
	output stall_dummy
    );
wire [9:0] c_dec_in;
wire [8:0] c_dec_out;
wire [1:0] c_exe_out;
wire c_mem_out,flush_cexe,c_dec_rst,c_exe_rst,temp_rst;

//registers:
flop_enr #(10)		c_dec(c_dec_in,clk,stall_ld,c_dec_rst,{forget_scr2,c_dec_out});		
flop_r   #(9)		c_exe(c_dec_out,clk,c_exe_rst,{load_cexe,rfile_we_cexe,c_exe_out,alu_op,alu_src});
flop_r   #(4) 		c_mem({load_cexe,rfile_we_cexe,c_exe_out},clk,rst,{load_cmem,rfile_we_cmem,c_mem_out,mem_we});
flop_r	 #(2)       c_wb({rfile_we_cmem,c_mem_out},clk,(rst|(~stall_cmis)),{rfile_we,wd_src});

//instantiation:
control_unit        controller(B_taken,c_dec_out[4:1],opcode,clk,rst,pc_src,rr1_src,rr2_src,wr_src,format_sel,c_dec_in,flush_ir,bank_en);
or                  or_1(c_exe_rst,temp_rst,flush_cexe);
or                  or_5(c_dec_rst,rst,flush_T_mis);
or                  or_6(temp_rst,rst,flush_T_mis);
not					not_1(flush_cexe,stall_ld);
////////////////////////////////////////////////////////////
assign stall_dummy=(datamem_writedata==16'h0a18)?1'b0:1'b1;
endmodule