`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2022 03:12:04 PM
// Design Name: 
// Module Name: mux41
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


module mux41(
    input [15:0] A, // Mux Input 1
    input [15:0] B, // Mux Input 2
    input [15:0] C, // Mux Input 3
    input [15:0] D, // Mux Input 4
    input [1:0]S, // Select
    output reg [15:0] Y // Mux Output
    );

    // reg [15:0] A_reg, B_reg, C_reg, D_reg;
    always @(S) begin
        case (S)
            2'd0: begin
                Y = A;
            end 
            2'd1: begin
                Y = B;
            end
            2'd2: begin
                Y = C;
            end
            2'd3: begin
                Y = D;
            end
            default: begin
                Y = 16'bz;
            end
        endcase
    end

    // assign Y = (S == 0) ? A : ((S == 1) ? B : (S == 2 ? C : D)) ;
endmodule
