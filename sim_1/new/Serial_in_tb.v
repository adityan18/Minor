`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2022 12:43:31
// Design Name: 
// Module Name: Serial_in_tb
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


module Serial_in_tb();
    parameter DATA_WIDTH = 128, NUM_DP = 1; //16*6 bit storage

    reg ser, clk, rst;
    wire done, oe, we;

    reg[DATA_WIDTH-1:0] full_data [NUM_DP-1:0];

    Serial_in s1(.CLK(clk), .ser(ser), .done(done), .RST(rst), .num_dp(3'd5), .feat(5'd11));


    initial begin
        clk = 0;
       forever begin
        #1; clk = ~clk;
       end
    end

    integer i, fd, j, rv;

    reg [15:0] mem [0:4][0:11];
    integer x;
    reg [15:0]temp, temp1;
    initial begin
        rst = 1;
        fd = $fopen("D:\\Class\\Sem6\\Minor\\Minor\\Minor.srcs\\sim_1\\new\\mem1.mem", "r");
        for(i = 0; i <= 4; i = i + 1) begin
            for(j = 0; j <= 11; j = j+ 1) begin
                rv = $fscanf(fd, "%h", mem[i][j]);
            end
        end
        #5;
        rst = 0;
        for (i = 0; i <= 4; i = i + 1) begin
            for (j = 11; j >= 0; j = j - 1) begin
                temp = mem[i][j];
                $display("%b -> %h", temp, temp, $time);
                for (x = 0;x <= 15 ;x = x+1 ) begin
                    // ser = temp[x];
                    ser = temp[x];
                    temp1 = {temp1, temp[x]};
                    $display("%b -> %b %d", temp, temp1, x, $time);
                    #1;
                end
                $display("%h", temp1);
            end
        end
        #100;$finish;
    end

endmodule
