`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:08:59 08/22/2017
// Design Name:   mytop
// Module Name:   F:/xilinx/test2/cache/ffff.v
// Project Name:  cache
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mytop
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ffff;

	// Inputs
	reg [15:0] add;
	reg [1:0] ad;
	reg we;
	reg rst;
	reg clk;

	// Outputs
	wire hit,uu,v0,v1;
	wire [15:0] data_out;



	// Instantiate the Unit Under Test (UUT)
	top uut (
		.add(add), 
		.ad(ad), 
		.we(we), 
		.rst(rst), 
		.clk(clk), 
		.hit(hit), 
		.data_out(data_out),
		.uu(uu),
		.v0(v0),
		.v1(v1)
	);

		initial begin
		// Initialize Inputs
		ad<=2'b01;
		add <= 16'h2f6b;
		we <= 0;
		rst <= 0;
		clk <= 1;
		#100;
#10;
rst<=1;
#20;
rst<=0;
		// Wait 100 ns for global reset to finish
		#100;
        we<=1;
		#20;
		we<=0;
		#100;
		ad<=2'b10;
		add<=16'h2f7b;
		#100;
		we<=1;
		#20;
		we<=0;
		#20;
		add<=16'h2fab;
		#100;
		we<=1;
		#20;
		we<=0;
		// Add stimulus here

	end
	always begin
	clk<=1;
	#10;
	clk<=0;
	#10;
	end
endmodule

