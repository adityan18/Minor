`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2022 01:18:31 PM
// Design Name: 
// Module Name: carry_adder
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


module carry_adder(
    input a,
    input b,
    input ci,
    input si,
    output co
    );

    wire w;
    and a1 (w, a, b);
    assign co = (w & si) | (w & ci) | (ci & si);

endmodule
