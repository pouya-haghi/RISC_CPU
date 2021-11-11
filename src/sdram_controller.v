`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:42:10 08/27/2017 
// Design Name: 
// Module Name:    sdram_controller 
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
module sdram_controller(
    input rst,
	input we_block_in,
    input [63:0] block_data_in,
    input [15:0] add,
    input modified_mem_we,
    input hit,
    input load_cmem,
	input clk,
	output [63:0] block_data_out,
    output cas,
    output ras,
    output cs,
   // output sd_clk,
    output sd_we,
    output reg [12:0] sd_add,
	output [1:0] bank,
    inout [15:0] DQ,
    output dqm,
	output reg stall_cmis,
	output reg we_block_out//to indicate when block_data_out is valid
    );

parameter ini0=5'h00,ini1=5'h01,ini2=5'h02,ini3=5'h03,ini4=5'h04,ini5=5'h05,ini6=5'h06,ini7=5'h07,ini8=5'h08,ini9=5'h09,LMR=5'h0a,ini10=5'h0b,idle=5'h0c,active=5'h0d,nop1=5'h0e,read=5'h0f,nop2=5'h10,data_in0=5'h11,data_in1=5'h12,data_in2=5'h13,data_in3=5'h14,data_out0=5'h15,data_out1=5'h16,data_out2=5'h17,data_out3=5'h18,nop3=5'h19,nop4=5'h1a,precharge=5'h1b,refresh=5'h1c,nop5=5'h1d,nop6=5'h1e,nop7=5'h1f;
parameter cmd_nop=3'b111,cmd_active=3'b011,cmd_read=3'b101,cmd_write=3'b100,cmd_refresh=3'b001,cmd_lmr=3'b000,cmd_precharge=3'b010;
reg [4:0] state,next_state;//state reg
wire EOI;//to indicate when initialization has finished(100us)
reg ack=1'b1;//to indicate when to pause 7.8us refresh counter
reg OE=1'b0;//to control bidirectional port
reg [2:0] cmd=cmd_nop;
reg [15:0] writedata;
wire [15:0] temp1,temp2,temp3,temp4;
wire carry_refresh;

////////////////////////////////////////////////////////////////////////////////////////////////////
//implement IOBUF primitve for bidirectional DQ port:
assign DQ=(OE)?writedata:16'bz;
flop_r      #(16)  myflop_1(DQ,clk,rst,temp1); 
flop_r      #(16)  myflop_2(temp1,clk,rst,temp2); 
flop_r      #(16)  myflop_3(temp2,clk,rst,temp3); 
flop_r      #(16)  myflop_4(temp3,clk,rst,temp4); 
////////////////////////////////////////////////////////////////////////////////////////////////////
assign block_data_out={temp1,temp2,temp3,temp4};//MSB is in temp1(not temp4)
assign {ras,cas,sd_we}=cmd;
//assign sd_clk=clk;
assign cs=1'b0;
assign dqm=1'b0;
assign bank=2'b00;  
////////////////////////////////////////////////////////////////////////////////////////////////////
//counters:
counter     #(8)   counter_8us(clk,rst,((~carry_refresh)|ack),carry_refresh);
counter     #(13)  counter_100us(clk,rst,1'b1,EOI);
////////////////////////////////////////////////////////////////////////////////////////////////////
//state register:
always@(posedge clk) 
if(rst) state<=5'h00;
else    state<=next_state;
//next state logic & output logic:
always@(*)
case(state)
ini0:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b1;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0; if(EOI) next_state<=ini1;else next_state<=ini0;end
ini1:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b1;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=ini2;end
ini2:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b1;stall_cmis<=1'b0;cmd<=cmd_precharge;sd_add[12:11]<=2'b0;sd_add[9:0]<=10'b0;sd_add[10]<=1'b0;next_state<=ini3;end
ini3:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b1;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=ini4;end
ini4:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b1;stall_cmis<=1'b0;cmd<=cmd_refresh;sd_add<=13'b0;next_state<=ini5;end
ini5:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b1;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=ini6;end
ini6:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b1;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=ini7;end
ini7:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b1;stall_cmis<=1'b0;cmd<=cmd_refresh;sd_add<=13'b0;next_state<=ini8;;end
ini8:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b1;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=ini9;end
ini9:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b1;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=LMR;end
LMR:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b1;stall_cmis<=1'b0;cmd<=cmd_lmr;sd_add<=13'b0000000100010;next_state<=ini10;end
ini10:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b1;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=idle;end
idle:begin  writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b1;cmd<=cmd_nop;sd_add<=13'b0; if(carry_refresh) next_state<=refresh;else if((~hit)&(load_cmem|modified_mem_we))next_state<=active;else next_state<=idle;end
active:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_active;sd_add<={6'b0,add[15:9]};next_state<=nop1;end
nop1:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0; if(we_block_in) next_state<=data_out0;else next_state<=read;end
read:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_read;sd_add[9]<=1'b0;sd_add[12:11]<=2'b0;sd_add[10]<=1'b1;sd_add[8:0]<=add[8:0];next_state<=nop2;end
nop2:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=data_in0;end
data_in0:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=data_in1;end
data_in1:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=data_in2;end
data_in2:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=data_in3;end
data_in3:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=precharge;end
data_out0:begin writedata<=block_data_in[15:0];OE<=1'b1;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_write;sd_add[9]<=1'b0;sd_add[12:11]<=2'b0;sd_add[8:0]<=add[8:0];sd_add[10]<=1'b1;next_state<=data_out1;end
data_out1:begin writedata<=block_data_in[31:16];OE<=1'b1;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=data_out2;end
data_out2:begin writedata<=block_data_in[47:32];OE<=1'b1;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=data_out3;end
data_out3:begin writedata<=block_data_in[63:48];OE<=1'b1;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=nop3;end
nop3:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=nop4;end
nop4:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=precharge;end
precharge:begin writedata<=16'b0;OE<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=idle;if(we_block_in) we_block_out<=1'b0;else we_block_out<=1'b1;end
refresh:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_refresh;sd_add<=13'b0;next_state<=nop5;end
nop5:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=nop6;end
nop6:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b0;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=nop7;end
nop7:begin writedata<=16'b0;OE<=1'b0;we_block_out<=1'b0;ack<=1'b1;stall_cmis<=1'b0;cmd<=cmd_nop;sd_add<=13'b0;next_state<=idle;end
endcase
///////////////////////////////////////////////////////////////////////////////////////////////////////////
endmodule