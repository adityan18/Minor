`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2022 03:12:04 PM
// Design Name: 
// Module Name: mux21
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


module mux21(
    input [15:0] A, // Mux Input 1
    input [15:0] B, // Mux Input 2
    input S, // Select
    output reg [15:0] Y // Mux Output
    );

    always @(S, A, B) begin
        case (S)
            1'b0: begin
                Y = A;
            end 
            1'b1: begin
                Y = B;
            end
            default: begin
                Y = 16'bz;
            end
        endcase
    end
endmodule
