`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/02/2022 05:38:37 PM
// Design Name:
// Module Name: mux41_tb
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module mux41_tb ();

	reg  [1:0] S;
	wire [15:0] Y;
		mux41 dut (1,2,3,4,S,Y); 

	initial begin
		S = 0;
		#10;
		S = 1;
		#10;
		S = 2;
		#10;
		S = 3;
		#10;
		$finish;
	end
endmodule
