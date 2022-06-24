`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2022 05:39:59 PM
// Design Name: 
// Module Name: fmul
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


module fmul
    #(parameter bits = 16)(
    input signed [bits-1:0] A, // Multiplier
    input signed [bits-1:0] B, // Multiplicant
    input CLK, // Clock
    output signed [bits-1:0] P // Product
    );
    
    
    // Q 8.8
    parameter MSB = 23;
    parameter LSB = 8; 
    reg signed [31:0] P64;

    always @(posedge CLK) begin
        P64 <= A * B;
    end

    assign P = P64[MSB:LSB];
endmodule
