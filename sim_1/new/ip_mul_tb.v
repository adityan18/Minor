`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2022 10:55:54 AM
// Design Name: 
// Module Name: bw_mul_formula_test
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


module ip_mul_test(

    );

    reg signed [15:0]a;
    reg signed [15:0]b;
    reg clk;
    wire signed [15:0]p;

    fmul dut(a, b, clk, p);

    always begin
        clk = 0;         #5;
        clk = 1;         #5;
    end
    

    initial begin
        a = 16'h0b00;
        b = 16'h1000;
        #10;
        $display("%b.%b * %b.%b = %b.%b", a[7:4], a[3:0], b[7:4], b[3:0], p[15:8],p[7:0]);
        // $display("P:%b", p);
        a = 16'h1800;
        b = 16'h2800;
        #10;
        $display("%b.%b * %b.%b = %b.%b", a[7:4], a[3:0], b[7:4], b[3:0], p[15:8],p[7:0]);
        // $display("P:%b", p);
        a = 16'h1400;
        b = 16'h2400;
        #10;
        $display("%b.%b * %b.%b = %b.%b", a[7:4], a[3:0], b[7:4], b[3:0], p[15:8],p[7:0]);
        a = 8'b0001_0010;
        b = 8'b1001_0000;
        #10;
        $display("%b.%b * %b.%b = %b.%b", a[7:4], a[3:0], b[7:4], b[3:0], p[15:8],p[7:0]);
        a = 8'b1111_0000;
        b = 8'b0000_1111;
        #10;
        $display("%b.%b * %b.%b = %b.%b", a[7:4], a[3:0], b[7:4], b[3:0], p[15:8],p[7:0]);
        a = 8'b1100_0011;
        b = 8'b0011_1100;
        #10;
        $display("%b.%b * %b.%b = %b.%b", a[7:4], a[3:0], b[7:4], b[3:0], p[15:8],p[7:0]);
        // $display("P:%b", p);
        $finish;
    end;
endmodule
