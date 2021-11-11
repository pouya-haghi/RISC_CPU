`timescale 1ns / 1ps
module test_top(
    );
reg clk_in;
reg rst_in;
wire   h_sync,v_sync,red0,red1,green0,green1,blue0,blue1;
wire [15:0] dout;


//instantiation:
mytop    dut(clk_in,rst_in,h_sync,v_sync,red0,red1,green0,green1,blue0,blue1,dout);

//clock generation:
always 
begin
clk_in<=1;
#10;
clk_in<=0;
#10;
end

//initialization:
initial
begin
clk_in<=1;rst_in<=0;
#100;
rst_in<=1;
#40;
rst_in<=0;
end
endmodule