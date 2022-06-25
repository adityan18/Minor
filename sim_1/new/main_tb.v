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


module main_tb
    #(
        parameter ADDR_WIDTH = 12, 
        parameter MAX_FEATURES = 15,
        parameter DATA_WIDTH = 16*(MAX_FEATURES+1), //width = num_features + 1 for y values
        parameter DEPTH = 10,      //Num_data points
        parameter LENGTH = 16      //Num_data points
        // parameter DEPTH = 4      //Num_data points
        //parameter LEN_BITS = 4     // Num_bits required to get 'LENGTH' features
    );

    reg CLK; // CLK
    reg S; //ser
    reg [3:0]feat; // Number of Features
    reg RST; // RST
    reg [7:0] epoch; // Number of EPOCHS
    reg [3:0] learn_rate; // Learning Rate
    reg [ADDR_WIDTH-1:0] data_points; // Number of Data Points
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


    parameter num_feats = 11;
    parameter num_dp = 6;

    reg [LENGTH-1:0] mem [0:num_dp][0:num_feats];
    integer x;
    reg [LENGTH-1:0]temp;

    initial begin
        RST = 1;
        S = 0;
        // Memory Load from TB
        // fd = $fopen("D:\\Class\\Sem6\\Minor\\Minor\\Minor.srcs\\sim_1\\new\\mem1.mem", "r");
        fd = $fopen("mem2.mem", "r");
        for(i = 0; i <= num_dp; i = i + 1) begin
            for(j = 0; j <= num_feats; j = j+ 1) begin
                rv = $fscanf(fd, "%h", mem[i][j]);
            end
        end

        epoch = 50;
        data_points = num_dp;
        learn_rate = 5;
        feat = num_feats;
        #20;

        RST = 0;
        #1;
        // Serial Input
        for (i = 0; i <= num_dp; i = i + 1) begin
            for (j = num_feats; j >= 0; j = j - 1) begin
                temp = mem[i][j];
                for (x = 0;x <= LENGTH - 1 ;x = x+1 ) begin
                    S = temp[x]; #1;
                end
            end
        end
        S = 0;
        // #100;$finish;
    end

endmodule
