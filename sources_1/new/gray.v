`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2022 14:08:18
// Design Name: 
// Module Name: gray
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


module gray(
    input a, //  1 bit input of multiplier
    input b, // 1 bit input of multiplicant
    input si, // sum in
    input ci, // carry in
    output so, // sum out
    output co // carry out
    );

    wire y, x;

    and a1(y, a, b);
    not n1(x, y);

    fa fa1(.a(x), .b(ci), .ci(si), .co(co), .s(so));

endmodule
