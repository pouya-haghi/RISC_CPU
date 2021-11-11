`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:59:50 08/20/2017 
// Design Name: 
// Module Name:    ins_cache 
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
module cache(
    input [63:0] data_in,//from sd_ram
	input [15:0] data,
    input [15:0] add,
	input modified_mem_we,
	input we,//when data_in from sd_ram is valid
	input rst,
	input clk,
    output hit,
    output [15:0] data_out,
	output [63:0] replace,//to sd_ram
	output sd_we //to sd_ram
    );

wire [63:0] way0,way1;
wire [15:0] data_out0,data_out1,data_in0,data_in1,data_in2,data_in3,way0_in0,way0_in1,way0_in2,way0_in3,way1_in0,way1_in1,way1_in2,way1_in3;
wire valid0,valid1,u,dirty0,dirty1,sd_we0,sd_we1;
wire temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10,temp11;	
wire hit0,hit1;
wire [9:0] tag0,tag1;
reg nextstate_a,nextstate_c,nextstate_b,state_b,state_a,nextstate_d,nextstate_e;


////////////////////////////////////////////////////////////////////////////////////////
//valid0:
always@(posedge clk)
if(rst) state_a<=1'b0;
else    state_a<=nextstate_a;
//state logic:
always@(*)
case(state_a)
1'b0:if(we) nextstate_a<=1'b1;else nextstate_a<=1'b0;
1'b1:nextstate_a<=1'b1;
endcase
//output logic:
mystatus     my_status1(nextstate_a,add[5:2],clk,we,valid0);
/////////////////////////////////////////////////////////////////////////////////////////
//valid1:
always@(posedge clk)
if(rst) state_b<=1'b0;
else    state_b<=nextstate_b;
//state logic:
always@(*)
case(state_b)
1'b0:if(we&valid0&(~hit0)) nextstate_b<=1'b1;else nextstate_b<=1'b0;
1'b1: nextstate_b<=1'b1;
endcase
//output logic:
mystatus     my_status2(nextstate_b,add[5:2],clk,(we&valid0&(~hit0)),valid1);
/////////////////////////////////////////////////////////////////////////////////////////
//used bit:
mystatus     my_status3(nextstate_c,add[5:2],clk,((u&hit1)|(~u&hit0)),u);
always@(posedge clk)
if(u&hit1) nextstate_c<=1'b0;
else if(~u&hit0) nextstate_c<=1'b1;
/////////////////////////////////////////////////////////////////////////////////////////
//dirty bit0:
mystatus     my_status4(nextstate_d,add[5:2],clk,((modified_mem_we&hit0==1'b1)||(valid0&valid1&(~hit)&(~u))==1'b1),dirty0);
always@(posedge clk)
if(modified_mem_we&hit0) nextstate_d<=1'b1;
else if(valid0&valid1&(~hit)&(~u)) nextstate_d<=1'b0;
assign sd_we0=(dirty0&valid0&valid1&(~hit)&(~u))?1'b1:1'b0;
/////////////////////////////////////////////////////////////////////////////////////////
//dirty bit1:
mystatus     my_status5(nextstate_e,add[5:2],clk,((modified_mem_we&hit1)|(valid0&valid1&(~hit)&u)),dirty1);
always@(posedge clk)
if(modified_mem_we&hit1) nextstate_e<=1'b1;
else if(valid0&valid1&(~hit)&u) nextstate_e<=1'b0;
assign sd_we1=(dirty1&valid0&valid1&(~hit)&u)?1'b1:1'b0;
/////////////////////////////////////////////////////////////////////////////////////////
//instantiation:
not         t3(temp3,u);
and         t2(temp1,we,temp3);
and         t4(temp2,we,u);
mux2  #(16) mymux3(data_in[15:0],data,(temp4|temp8),data_in0);
mux2  #(16) mymux4(data_in[31:16],data,(temp5|temp9),data_in1);
mux2  #(16) mymux5(data_in[47:32],data,(temp6|temp10),data_in2);
mux2  #(16) mymux6(data_in[63:48],data,(temp7|temp11),data_in3);
myram       cache0(add,data_in0,(temp1|temp4),clk,way0_in0);
myram       cache1(add,data_in1,(temp1|temp5),clk,way0_in1);
myram       cache2(add,data_in2,(temp1|temp6),clk,way0_in2);
myram       cache3(add,data_in3,(temp1|temp7),clk,way0_in3);
myram       cache4(add,data_in0,(temp2|temp8),clk,way1_in0);
myram       cache5(add,data_in1,(temp2|temp9),clk,way1_in1);
myram       cache6(add,data_in2,(temp2|temp10),clk,way1_in2);
myram       cache7(add,data_in3,(temp2|temp11),clk,way1_in3);
mytag       mytag0(add,temp1,clk,tag0);
mytag       mytag1(add,temp2,clk,tag1);
mux4  #(16) mymux1(way0_in0,way0_in1,way0_in2,way0_in3,add[1:0],data_out0);
mux4  #(16) mymux2(way1_in0,way1_in1,way1_in2,way1_in3,add[1:0],data_out1);

assign temp4=(modified_mem_we&hit0&(~add[0])&(~add[1]))?1'b1:1'b0;
assign temp5=(modified_mem_we&hit0&add[0]&(~add[1]))?1'b1:1'b0;
assign temp6=(modified_mem_we&hit0&(~add[0])&add[1])?1'b1:1'b0;
assign temp7=(modified_mem_we&hit0&add[0]&add[1])?1'b1:1'b0;
assign temp8=(modified_mem_we&hit1&(~add[0])&(~add[1]))?1'b1:1'b0;
assign temp9=(modified_mem_we&hit1&add[0]&(~add[1]))?1'b1:1'b0;
assign temp10=(modified_mem_we&hit1&(~add[0])&add[1])?1'b1:1'b0;
assign temp11=(modified_mem_we&hit1&add[0]&add[1])?1'b1:1'b0;
assign hit0=((tag0==add[15:6])&&(valid0==1'b1))?1'b1:1'b0;
assign hit1=((tag1==add[15:6])&&(valid1==1'b1))?1'b1:1'b0;
or     t1(hit,hit0,hit1);
or     t5(sd_we,sd_we0,sd_we1);
assign way0={way0_in3,way0_in2,way0_in1,way0_in0};
assign way1={way1_in3,way1_in2,way1_in1,way1_in0};
assign data_out=(hit1)?data_out1:data_out0;
assign replace=(u)?way1:way0;
endmodule