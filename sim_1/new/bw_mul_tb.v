`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2022 16:18:18
// Design Name: 
// Module Name: bw_mul_tb
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


module bw_mul_tb(

    );

    reg signed [15:0]a;
    reg signed [15:0]b;
    wire signed [15:0]p;

    bw_mul dut(a, b, p);

    initial begin
        a = 16'h1000;
        b = 16'h1000;
        #10;
        a = 16'h0000;
        b = 16'h1010;
        #10;
        a = 16'h0100;
        b = 16'h1000;
        #10;
        a = 16'h0100;
        b = 16'h1010;
        #10;
        a = 16'h0100;
        b = 16'h1111;
        #10;
        a = 16'h0100;
        b = 16'h1011;
        #10;  
        a = 16'h1111;
        b = 16'h0100;
        #10;      
        a = 16'h1011;
        b = 16'h0100;
        #10;
        a = 16'h1100;
        b = 16'h0100;
        #10;   
        $finish;
    end

endmodule