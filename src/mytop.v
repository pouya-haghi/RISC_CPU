`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:47:26 07/28/2017 
// Design Name: 
// Module Name:    processor 
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
module mytop(                                   
    input clk,
    input rst_in,
	output h_sync,
    output v_sync,
    output red0,
    output red1,
    output green0,
    output green1,
    output blue0,
    output blue1,
	//output locked,
	output cas,
	output ras,
	output sd_cs,
	output sd_we,
	output [12:0] sd_add,
	output [1:0] bank,
	inout [15:0] DQ,
	output dqm,
	output sd_clk
    );

wire   mem_we,clkb,rst,io_we,modified_mem_we,place_we,replace_we,hit,stall_cmis;
wire   pc_src,stall_ld,rr1_src,rr2_src,wr_src,format_sel,rfile_we,alu_src,wd_src,load_cexe,load_cmem,forget_src2,rfile_we_cexe,rfile_we_cmem,bank_en,B_taken,alu_z,stall_dummy,flush_NT_mis,flush_T_mis,flush_ir;
wire   [1:0] dr1_src,dr2_src;
wire   [3:0] alu_op,opcode,rr1,rr2,wr_exe,wr_mem;
wire   [15:0] cache_writedata,cache_readdata,cache_add;
wire   [63:0] place,replace;
	
//instantiation:
datapath    #(16) data_path(stall_cmis,cache_readdata,stall_dummy,flush_T_mis,flush_NT_mis,mem_we,rst,pc_src,stall_ld,flush_ir, bank_en,rr1_src,rr2_src,wr_src,format_sel,rfile_we,dr1_src,dr2_src,alu_src,alu_op,wd_src,clk,clkb,cache_writedata,opcode,alu_z,rr1,rr2,wr_exe,wr_mem,io_we,modified_mem_we,cache_add);
controlpath       control_path(stall_cmis,cache_writedata,flush_T_mis,B_taken,opcode,clk,rst,stall_ld,rr1_src,rr2_src,wr_src,format_sel,rfile_we,alu_src,alu_op,mem_we,wd_src,flush_ir,pc_src,load_cexe,load_cmem,forget_src2,rfile_we_cexe,rfile_we_cmem,bank_en,stall_dummy);
hazardunit        hazard_unit(rr1,rr2,wr_exe,wr_mem,load_cexe,load_cmem,forget_src2,rfile_we_cexe,rfile_we_cmem,rst,clk,dr1_src,dr2_src,stall_ld);
branchprediction  branch_prediction(alu_op,alu_z,rst,clk,B_taken,flush_T_mis,flush_NT_mis);
//mydcm             my_dcm(clk_in,clk,clkb,rst,locked);
vga_controller    my_vga(clk,cache_writedata,io_we,h_sync,v_sync,red0,red1,green0,green1,blue0,blue1);
cache             my_cache(place,cache_writedata,cache_add,modified_mem_we,place_we,rst,clk,hit,cache_readdata,replace,replace_we);
sdram_controller  my_sd(rst,replace_we,replace,cache_add,modified_mem_we,hit,load_cmem,clk,place,cas,ras,sd_cs,sd_we,sd_add,bank,DQ,dqm,stall_cmis,place_we);
assign  clkb=~clk;
assign sd_clk=clk;
assign rst=~rst_in;
endmodule