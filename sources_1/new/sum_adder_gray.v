`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2022 06:52:00 PM
// Design Name: 
// Module Name: sum_adder_gray
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


module sum_adder_gray(
    input a,
    input b,
    input si,
    input ci,
    output so
    );

    wire w;
    and a1 (w, a, b);
    assign so = w ^ si ^ ci;

endmodule
