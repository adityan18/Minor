`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2022 14:13:28
// Design Name: 
// Module Name: fa
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


module fa(
    input a, // 1 Bit input
    input b, // 1 bit input
    input ci, // Carry in
    output s, // Sum Out
    output co // Carry Out
    );

    assign {co, s} = a + b + ci;
    
endmodule
