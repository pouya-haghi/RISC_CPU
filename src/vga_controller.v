`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:50:51 08/11/2017 
// Design Name: 
// Module Name:    vga_controller 
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
module vga_controller(
    input clk,
	input [15:0] data,
	input en,
    output h_sync,
    output v_sync,
    output red0,
    output red1,
    output green0,
    output green1,
    output blue0,
    output blue1
    );

wire [10:0] x_counter;
wire [9:0] y_counter;	
wire valid;
wire [101:0] t_green0;
wire [287:0] SIPO;

//instantiations:
vga_sync    sync_50M(clk,h_sync,v_sync,valid,x_counter,y_counter);
array_shifter  myshift(data,en,clk,SIPO);
char_pos    u1(clk,x_counter,y_counter,11'd114,10'd124,4'ha,t_green0[0]);//scheduled at x_pos=16(second dot matrix)(Y)
char_pos    u2(clk,x_counter,y_counter,11'd122,10'd124,4'h5,t_green0[1]);//scheduled at x_pos=24(third dot matrix)(O)
char_pos    u3(clk,x_counter,y_counter,11'd130,10'd124,4'h8,t_green0[2]);//...(U)
char_pos    u4(clk,x_counter,y_counter,11'd138,10'd124,4'h6,t_green0[3]);//(R)
char_pos    u5(clk,x_counter,y_counter,11'd154,10'd124,4'h1,t_green0[4]);//(A)
char_pos    u6(clk,x_counter,y_counter,11'd162,10'd124,4'h4,t_green0[5]);//(N)
char_pos    u7(clk,x_counter,y_counter,11'd170,10'd124,4'h7,t_green0[6]);//(S)
char_pos    u8(clk,x_counter,y_counter,11'd178,10'd124,4'h9,t_green0[7]);//(W)
char_pos    u9(clk,x_counter,y_counter,11'd186,10'd124,4'h2,t_green0[8]);//(E)
char_pos    u10(clk,x_counter,y_counter,11'd194,10'd124,4'h6,t_green0[9]);//(R)
char_pos    u11(clk,x_counter,y_counter,11'd210,10'd124,4'h3,t_green0[10]);//(I)
char_pos    u12(clk,x_counter,y_counter,11'd218,10'd124,4'h7,t_green0[11]);//(S)
char_pos    u13(clk,x_counter,y_counter,11'd226,10'd124,4'hb,t_green0[12]);//(:)
num_pos     u14(clk,x_counter,y_counter,11'd234,10'd124,SIPO[15:12],t_green0[13]);//#1
num_pos     u15(clk,x_counter,y_counter,11'd242,10'd124,SIPO[11:8],t_green0[14]);//#
num_pos     u16(clk,x_counter,y_counter,11'd250,10'd124,SIPO[7:4],t_green0[15]);//#
num_pos     u17(clk,x_counter,y_counter,11'd258,10'd124,SIPO[3:0],t_green0[16]);//#
char_pos    u18(clk,x_counter,y_counter,11'd266,10'd124,4'h0,t_green0[17]);//,
num_pos     u19(clk,x_counter,y_counter,11'd274,10'd124,SIPO[31:28],t_green0[18]);//#2
num_pos     u20(clk,x_counter,y_counter,11'd282,10'd124,SIPO[27:24],t_green0[19]);//#
num_pos     u21(clk,x_counter,y_counter,11'd290,10'd124,SIPO[23:20],t_green0[20]);//#
num_pos     u22(clk,x_counter,y_counter,11'd298,10'd124,SIPO[19:16],t_green0[21]);//#
char_pos    u23(clk,x_counter,y_counter,11'd306,10'd124,4'h0,t_green0[22]);//,
num_pos     u24(clk,x_counter,y_counter,11'd314,10'd124,SIPO[47:44],t_green0[23]);//#3
num_pos     u25(clk,x_counter,y_counter,11'd322,10'd124,SIPO[43:40],t_green0[24]);//#
num_pos     u26(clk,x_counter,y_counter,11'd330,10'd124,SIPO[39:36],t_green0[25]);//#
num_pos     u27(clk,x_counter,y_counter,11'd338,10'd124,SIPO[35:32],t_green0[26]);//#
char_pos    u28(clk,x_counter,y_counter,11'd346,10'd124,4'h0,t_green0[27]);//,
num_pos     u29(clk,x_counter,y_counter,11'd354,10'd124,SIPO[63:60],t_green0[28]);//#4
num_pos     u30(clk,x_counter,y_counter,11'd362,10'd124,SIPO[59:56],t_green0[29]);//#
num_pos     u31(clk,x_counter,y_counter,11'd370,10'd124,SIPO[55:52],t_green0[30]);//#
num_pos     u32(clk,x_counter,y_counter,11'd378,10'd124,SIPO[51:48],t_green0[31]);//#
char_pos    u33(clk,x_counter,y_counter,11'd386,10'd124,4'h0,t_green0[32]);//,
num_pos     u34(clk,x_counter,y_counter,11'd394,10'd124,SIPO[79:76],t_green0[33]);//#5
num_pos     u35(clk,x_counter,y_counter,11'd402,10'd124,SIPO[75:72],t_green0[34]);//#
num_pos     u36(clk,x_counter,y_counter,11'd410,10'd124,SIPO[71:68],t_green0[35]);//#
num_pos     u37(clk,x_counter,y_counter,11'd418,10'd124,SIPO[67:64],t_green0[36]);//#
char_pos    u38(clk,x_counter,y_counter,11'd426,10'd124,4'h0,t_green0[37]);//,
num_pos     u39(clk,x_counter,y_counter,11'd434,10'd124,SIPO[95:92],t_green0[38]);//#6
num_pos     u40(clk,x_counter,y_counter,11'd442,10'd124,SIPO[91:88],t_green0[39]);//#
num_pos     u41(clk,x_counter,y_counter,11'd450,10'd124,SIPO[87:84],t_green0[40]);//#
num_pos     u42(clk,x_counter,y_counter,11'd458,10'd124,SIPO[83:80],t_green0[41]);//#
char_pos    u43(clk,x_counter,y_counter,11'd466,10'd124,4'h0,t_green0[42]);//,
num_pos     u44(clk,x_counter,y_counter,11'd474,10'd124,SIPO[111:108],t_green0[43]);//#7
num_pos     u45(clk,x_counter,y_counter,11'd482,10'd124,SIPO[107:104],t_green0[44]);//#
num_pos     u46(clk,x_counter,y_counter,11'd490,10'd124,SIPO[103:100],t_green0[45]);//#
num_pos     u47(clk,x_counter,y_counter,11'd498,10'd124,SIPO[99:96],t_green0[46]);//#
char_pos    u48(clk,x_counter,y_counter,11'd506,10'd124,4'h0,t_green0[47]);//,
num_pos     u49(clk,x_counter,y_counter,11'd514,10'd124,SIPO[127:124],t_green0[48]);//#8
num_pos     u50(clk,x_counter,y_counter,11'd522,10'd124,SIPO[123:120],t_green0[49]);//#
num_pos     u51(clk,x_counter,y_counter,11'd530,10'd124,SIPO[119:116],t_green0[50]);//#
num_pos     u52(clk,x_counter,y_counter,11'd538,10'd124,SIPO[115:112],t_green0[51]);//#
char_pos    u53(clk,x_counter,y_counter,11'd546,10'd124,4'h0,t_green0[52]);//,
num_pos     u54(clk,x_counter,y_counter,11'd554,10'd124,SIPO[143:140],t_green0[53]);//#9
num_pos     u55(clk,x_counter,y_counter,11'd562,10'd124,SIPO[139:136],t_green0[54]);//#
num_pos     u56(clk,x_counter,y_counter,11'd570,10'd124,SIPO[135:132],t_green0[55]);//#
num_pos     u57(clk,x_counter,y_counter,11'd578,10'd124,SIPO[131:128],t_green0[56]);//#
char_pos    u58(clk,x_counter,y_counter,11'd586,10'd124,4'h0,t_green0[57]);//,
num_pos     u59(clk,x_counter,y_counter,11'd594,10'd124,SIPO[159:156],t_green0[58]);//#10
num_pos     u60(clk,x_counter,y_counter,11'd602,10'd124,SIPO[155:152],t_green0[59]);//#
num_pos     u61(clk,x_counter,y_counter,11'd610,10'd124,SIPO[151:148],t_green0[60]);//#
num_pos     u62(clk,x_counter,y_counter,11'd618,10'd124,SIPO[147:144],t_green0[61]);//#
char_pos    u63(clk,x_counter,y_counter,11'd626,10'd124,4'h0,t_green0[62]);//,
num_pos     u64(clk,x_counter,y_counter,11'd634,10'd124,SIPO[175:172],t_green0[63]);//#11
num_pos     u65(clk,x_counter,y_counter,11'd642,10'd124,SIPO[171:168],t_green0[64]);//#
num_pos     u66(clk,x_counter,y_counter,11'd650,10'd124,SIPO[167:164],t_green0[65]);//#
num_pos     u67(clk,x_counter,y_counter,11'd658,10'd124,SIPO[163:160],t_green0[66]);//#
char_pos    u68(clk,x_counter,y_counter,11'd666,10'd124,4'h0,t_green0[67]);//,
num_pos     u69(clk,x_counter,y_counter,11'd674,10'd124,SIPO[191:188],t_green0[68]);//#12
num_pos     u70(clk,x_counter,y_counter,11'd682,10'd124,SIPO[187:184],t_green0[69]);//#
num_pos     u71(clk,x_counter,y_counter,11'd690,10'd124,SIPO[183:180],t_green0[70]);//#
num_pos     u72(clk,x_counter,y_counter,11'd698,10'd124,SIPO[179:176],t_green0[71]);//#
char_pos    u73(clk,x_counter,y_counter,11'd706,10'd124,4'h0,t_green0[72]);//,
num_pos     u74(clk,x_counter,y_counter,11'd714,10'd124,SIPO[207:204],t_green0[73]);//#13
num_pos     u75(clk,x_counter,y_counter,11'd722,10'd124,SIPO[203:200],t_green0[74]);//#
num_pos     u76(clk,x_counter,y_counter,11'd730,10'd124,SIPO[199:196],t_green0[75]);//#
num_pos     u77(clk,x_counter,y_counter,11'd738,10'd124,SIPO[195:192],t_green0[76]);//#
char_pos    u78(clk,x_counter,y_counter,11'd746,10'd124,4'h0,t_green0[77]);//,
num_pos     u79(clk,x_counter,y_counter,11'd754,10'd124,SIPO[223:220],t_green0[78]);//#14
num_pos     u80(clk,x_counter,y_counter,11'd762,10'd124,SIPO[219:216],t_green0[79]);//#
num_pos     u81(clk,x_counter,y_counter,11'd770,10'd124,SIPO[215:212],t_green0[80]);//#
num_pos     u82(clk,x_counter,y_counter,11'd778,10'd124,SIPO[211:208],t_green0[81]);//#
char_pos    u83(clk,x_counter,y_counter,11'd786,10'd124,4'h0,t_green0[82]);//,
num_pos     u84(clk,x_counter,y_counter,11'd794,10'd124,SIPO[239:236],t_green0[83]);//#15
num_pos     u85(clk,x_counter,y_counter,11'd802,10'd124,SIPO[235:232],t_green0[84]);//#
num_pos     u86(clk,x_counter,y_counter,11'd810,10'd124,SIPO[231:228],t_green0[85]);//#
num_pos     u87(clk,x_counter,y_counter,11'd818,10'd124,SIPO[227:224],t_green0[86]);//#
char_pos    u88(clk,x_counter,y_counter,11'd826,10'd124,4'h0,t_green0[87]);//,
num_pos     u89(clk,x_counter,y_counter,11'd834,10'd124,SIPO[255:252],t_green0[88]);//#16
num_pos     u90(clk,x_counter,y_counter,11'd842,10'd124,SIPO[251:248],t_green0[89]);//#
num_pos     u91(clk,x_counter,y_counter,11'd850,10'd124,SIPO[247:244],t_green0[90]);//#
num_pos     u92(clk,x_counter,y_counter,11'd858,10'd124,SIPO[243:240],t_green0[91]);//#
char_pos    u93(clk,x_counter,y_counter,11'd866,10'd124,4'h0,t_green0[92]);//,
num_pos     u94(clk,x_counter,y_counter,11'd874,10'd124,SIPO[271:268],t_green0[93]);//#17
num_pos     u95(clk,x_counter,y_counter,11'd882,10'd124,SIPO[267:264],t_green0[94]);//#
num_pos     u96(clk,x_counter,y_counter,11'd890,10'd124,SIPO[263:260],t_green0[95]);//#
num_pos     u97(clk,x_counter,y_counter,11'd898,10'd124,SIPO[259:256],t_green0[96]);//#
char_pos    u98(clk,x_counter,y_counter,11'd906,10'd124,4'h0,t_green0[97]);//,
num_pos     u99(clk,x_counter,y_counter,11'd914,10'd124,SIPO[287:284],t_green0[98]);//#18
num_pos     u100(clk,x_counter,y_counter,11'd922,10'd124,SIPO[283:280],t_green0[99]);//#
num_pos     u101(clk,x_counter,y_counter,11'd930,10'd124,SIPO[279:276],t_green0[100]);//#
num_pos     u102(clk,x_counter,y_counter,11'd938,10'd124,SIPO[275:272],t_green0[101]);//#

assign red1=1'b0;
assign green1=1'b0;
assign blue1=1'b0;
assign green0=((|t_green0) & valid);
assign red0=1'b0;
assign blue0=1'b0;
endmodule