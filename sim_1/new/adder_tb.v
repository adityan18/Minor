`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2022 01:23:49 PM
// Design Name: 
// Module Name: adder_tb
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


module adder_tb(

    );

    reg a;
    reg b;
    reg ci;
    reg si;
    wire out1;
    wire out2;


    carry_adder dut1 (a, b, ci, si, out1);
    sum_adder_gray dut2 (a, b, ci, si, out2);

    integer i;

    initial begin
        for (i = 0; i < 16; i= i + 1) begin
            {si, ci, b, a} = i; #10;
        end
        $finish;
    end


endmodule
