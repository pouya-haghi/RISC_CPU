`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:39:46 07/24/2017 
// Design Name: 
// Module Name:    datapath 
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
module datapath #(parameter numbits=16)
	(
	input stall_dummy,
	input mem_we,
    input rst,
    input pc_src,
	input stall_ld,
	input stall_jmp,
    input bank_en,
    input rr1_src,
    input rr2_src,
    input wr_src,
    input format_sel,
    input rfile_we,
	input [1:0] dr1_src,
	input [1:0] dr2_src,
    input alu_src,
    input [3:0] alu_op,
	input wd_src,
    input clk,
    //input clkb,
	output [numbits-1:0] datamem_writedata,        
    output [3:0] opcode,
    output alu_z,
	output [3:0] rr1,
	output [3:0] rr2,
	output [3:0] wr_exe,
	output [3:0] wr_mem
    );
wire  [15:0] datamem_readdata;
//parameter one=16'h0001;
wire   [numbits-1:0] pc_in,ir_in,mem_in,pc_src_in2,alu_in2,dr1_out,dr2_out,mux2_5_out,mux2_7_out,adder4_out,pc_out,ir_out;
wire   [51:0] exe_out;
wire   [35:0] mem_out;
wire   [31:0] exe_in; 
//wire   [15:0] wb_in;
wire   [19:0] wb_out;
wire   [11:0] dec_in;
wire   [27:0] dec_out;
wire   [1:0] adder_2_in1;
wire stall_ir;

//registers:
flop_enr   #(numbits) 	 pc(pc_in,clk,stall_ld,rst,pc_out);
flop_enr   #(numbits) 	 ir(ir_in,clk,stall_ir,rst,ir_out);
flop_enr   #(28) 		 dec({{8{ir_out[7]}},ir_out[7:0],dec_in},clk,stall_ld,rst,dec_out);
flop_r	   #(52) 		 exe({dec_out[27:12],exe_in,dec_out[3:0]},clk,rst,exe_out);
flop_enr   #(36)	     mem({exe_out[35:20],mem_in,exe_out[3:0]},clk,stall_dummy,rst,mem_out);
flop_r	   #(20) 		 wb({mem_out[19:4],mem_out[3:0]},clk,rst,wb_out);

//fetch instantiation:
insmem	                 ins_mem(pc_out,ir_in);
//adder      #(numbits)    adder_1(pc_out,one,pc_src_in1);
adder      #(numbits)    adder_4(pc_out,mux2_5_out,adder4_out);
mux2	   #(numbits)    mux2_1(pc_out+16'h0001,pc_src_in2,pc_src,pc_in);
mux2       #(numbits)    mux2_8(adder4_out,mux2_5_out,format_sel,pc_src_in2);
and                      and_1(stall_ir,stall_ld,stall_jmp);

//predecode instantiation:
//sign1     sign_ext_1(ir_out[7:0],extended1);
//sign2    sign_ext_2(ir_out[11:0],extended2);
bankselection            bank_selection(bank_en,rst,clk,adder_2_in1);
//adder	   #(4)			 adder_2({adder_2_in1,2'b0},{2'b0,ir_out[11:10]},rr1_src_in1);
//adder	   #(4)			 adder_3({adder_2_in1,2'b0},{2'b0,ir_out[9:8]},rr2_src_in1);
mux2	   #(4)			 mux2_2(ir_out[3:0],{2'b0,ir_out[9:8]},wr_src,dec_in[3:0]);
mux2	   #(4)			 mux2_3({adder_2_in1,ir_out[11:10]},ir_out[11:8],rr1_src,dec_in[7:4]);
mux2	   #(4)			 mux2_4({adder_2_in1,ir_out[9:8]},ir_out[7:4],rr2_src,dec_in[11:8]);
mux2	   #(numbits)	 mux2_5({{8{ir_out[7]}},ir_out[7:0]},{{4{ir_out[11]}},ir_out[11:0]},format_sel,mux2_5_out);

//decode instantiation:
regfile    #(numbits)  reg_file(dec_out[7:4],dec_out[11:8],wb_out[3:0],mux2_7_out,clk,rfile_we,dr1_out,dr2_out);
mux4	   #(numbits)    mux4_2(mem_out[19:4],mem_in[15:0],dr1_out,datamem_readdata,dr1_src,exe_in[15:0]);
mux4       #(numbits)    mux4_3(mem_out[19:4],mem_in[15:0],dr2_out,datamem_readdata,dr2_src,exe_in[31:16]);

//exe instantiation:
mux2	   #(numbits)	 mux2_6(exe_out[35:20],exe_out[51:36],alu_src,alu_in2);
alu		   #(numbits)    ALU(exe_out[19:4],alu_in2,alu_op,mem_in[15:0],alu_z);
//zero_det   #(numbits)	 zero_detect(mem_in[15:0],B,alu_z);

//mem instantiation:
datamem           data_mem(mem_out[35:20],mem_out[17:4],clk,mem_we,datamem_readdata);

//wb instantiation:
mux2	   #(numbits)	 mux2_7(wb_out[19:4],datamem_readdata,wd_src,mux2_7_out); 

//assignments:
assign opcode=ir_out[15:12];
assign rr1=dec_out[7:4];
assign rr2=dec_out[11:8];
assign wr_exe=exe_out[3:0];
assign wr_mem=mem_out[3:0];
assign datamem_writedata=mem_out[35:20];
endmodule