`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2022 14:13:28
// Design Name: 
// Module Name: ha
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


module ha(
    input a, // 1 Bit input
    input b, // 1 bit input
    output s, // Sum Out
    output co // Carry Out
    );

    assign {s, co} = a + b;
    
endmodule
