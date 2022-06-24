`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2022 11:29:45 PM
// Design Name: 
// Module Name: main_tb
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


module main_tb(

    );

    reg CLK; // CLK
    reg S; //ser
    reg [3:0]feat; // Number of Features
    reg RST; // RST
    reg [7:0] epoch; // Number of EPOCHS
    reg [3:0] learn_rate; // Learning Rate
    reg [11:0] data_points; // Number of Data Points
    // reg SGD_DONE;// Flag for completion

    main dut(.CLK(CLK), .S(S), 
             .feat(feat), .RST(RST), 
             .epoch(epoch), .data_points(data_points), .learn_rate(learn_rate));

    initial begin
        CLK = 0;
        forever begin
            #1; CLK = ~CLK;
        end
    end

    integer i, fd, j, rv;

    reg [15:0] mem [0:3][0:11];
    integer x;
    reg [15:0]temp;

    initial begin
        RST = 1;
        S = 0;
        // Memory Load from TB
        // fd = $fopen("D:\\Class\\Sem6\\Minor\\Minor\\Minor.srcs\\sim_1\\new\\mem1.mem", "r");
        fd = $fopen("mem2.mem", "r");
        for(i = 0; i <= 4; i = i + 1) begin
            for(j = 0; j <= 11; j = j+ 1) begin
                rv = $fscanf(fd, "%h", mem[i][j]);
            end
        end

        epoch = 100;
        data_points = 4;
        learn_rate = 15;
        feat = 11;
        #20;

        RST = 0;
        #1;
        // Serial Input
        for (i = 0; i <= 3; i = i + 1) begin
            for (j = 11; j >= 0; j = j - 1) begin
                temp = mem[i][j];
                for (x = 0;x <= 15 ;x = x+1 ) begin
                    S = temp[x]; #1;
                end
            end
        end
        S = 0;
        // #100;$finish;
    end

endmodule
