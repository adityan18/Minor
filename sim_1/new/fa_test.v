`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2022 19:49:56
// Design Name: 
// Module Name: fa_test
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


module fa_test(

    );

    reg a, b, ci;
    wire co, s;

    fa dut (a, b, ci, s, co);

    initial begin
        {a, b, ci} = 3'd5;#10;
        {a, b, ci} = 3'd6;#10;
        {a, b, ci} = 3'd4;#10;
        {a, b, ci} = 3'd1;#10;
        $finish;
    end
endmodule
