`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2022 05:39:10 PM
// Design Name: 
// Module Name: sum_adder_white
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


module sum_adder_white(
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
