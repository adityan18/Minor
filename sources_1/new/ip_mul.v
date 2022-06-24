`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2022 10:46:10 AM
// Design Name: 
// Module Name: bw_mul_formula
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


module ip_mul(
    input CLK, // CLK
    input signed [7:0]A, // 32 bit input
    input signed [7:0]B, // 32 bit input
    output signed [15:0]P // 64 bit product
);
    
    mul mul1 (
      .CLK(CLK),  // input wire CLK
      .A(A),      // input wire [15 : 0] A
      .B(B),      // input wire [15 : 0] B
      .P(P)      // output wire [31 : 0] P
    );
    
endmodule
