`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2022 09:58:53 PM
// Design Name: 
// Module Name: sgd_v3
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


module sgd_v3
    #(
        parameter LENGTH = 16, // Each Feature length
        parameter  F = 11, // Maximum Number of Features
        parameter DP = 4, // Maximum Number of Data Points
        // parameter DP = 1024, // Maximum Number of Data Points
        parameter DATA_WIDTH = (F+1) * 16 // 16 * F bit storage
    )
    (
        input CLK, // CLK,
        input RST, // RST
        input signed [DATA_WIDTH - 1 : 0] data, // DataPoint
        input [3:0] feat, // Number of Features,
        input [11:0] data_points, // Numer of Data Points
        input [7:0] epoch, // Number of Epochs
        input hold, // HOLD,
        input [3:0] learn_rate, // Learning Rate
        output [11:0] addr, // Address of DataPoint in RAM
        output done // Flag for completion of Epochs
    );

    parameter IDLE = 3'b110; // 6
    parameter S0 = 3'b000; // 0
    parameter S1 = 3'b001; // 1
    parameter S2 = 3'b011; // 3
    parameter S3 = 3'b010; // 2
    parameter HOLD = 3'b111; // 7

    reg [2:0] PS, NS; // Present State, Next State
    reg epoch_flag;

    assign addr = dp_counter;

    // reg signed [LENGTH-1:0]RAM[0:DP-1][0:F];
    // initial begin
    //     RAM[0][0] = 16'h0200; //2
    //     RAM[0][1] = 16'h0400; //4
    //     RAM[0][2] = 16'h0300; //3
    //     RAM[0][3] = 16'h0600; //6
    //     RAM[0][4] = 16'h0f00; //10

    //     RAM[1][0] = 16'h0300; //3
    //     RAM[1][1] = 16'h0400; //4
    //     RAM[1][2] = 16'h0500; //5
    //     RAM[1][3] = 16'h0600; //6
    //     RAM[1][4] = 16'h1200; //10
         
    //     RAM[2][0] = 16'h0900; //9
    //     RAM[2][1] = 16'h0100; //1
    //     RAM[2][2] = 16'h0200; //2
    //     RAM[2][3] = 16'h0300; //3
    //     RAM[2][4] = 16'h0f00; //15

    //     RAM[3][0] = 16'h0700; //7
    //     RAM[3][1] = 16'h0800; //8
    //     RAM[3][2] = 16'h0000; //0
    //     RAM[3][3] = 16'h0100; //1
    //     RAM[3][4] = 16'h1000; //16
    // end

    genvar i;
    reg signed [LENGTH-1:0]A[1:F]; // Multiplicant
    reg signed [LENGTH-1:0]B[1:F]; // Multiplier
    wire signed [LENGTH-1:0]P[1:F]; // Product
    generate
        for (i = 1; i <= F; i = i + 1) begin
            bw_mul mul (
                .a(A[i]),
                .b(B[i]),
                .p(P[i])
            );
        end
    endgenerate

    reg signed [LENGTH-1:0] error [0:DP-1]; // Error = Y- Y_CAP
    reg signed [LENGTH-1:0] y_cap [0:DP-1]; // Error = Y- Y_CAP
    reg signed [LENGTH-1:0] W [0:F]; // Weights
    reg [11:0]dp_counter; // Data point counter
    reg [7:0] epoch_counter; // Epoch Counter
    reg [LENGTH-1:0] Y ;

    integer j;
    always @(PS) begin
        case (PS)
            IDLE: begin
                for (j = 0; j <= F; j = j + 1) begin
                    W[j] <= 16'h0400;
                end
                NS <= S0;
                dp_counter = 12'd0;
                epoch_counter = 8'd0;
                epoch_flag = 0;
            end
            S0: begin
                for (j = 1; j <= F; j = j + 1) begin
                    // A[j] <= RAM[dp_counter][j-1];
                    A[j] <= data[(DATA_WIDTH - 1) - 16 - LENGTH * (j-1) -: 16];
                    B[j] <= W[j];
                end
                Y <= data[DATA_WIDTH - 1 -: 16];
                NS <= S1;
            end
            S1: begin
                y_cap[dp_counter] = W[0];
                for (j = 1;j <= F ; j = j + 1) begin
                    y_cap[dp_counter] = y_cap[dp_counter] + P[j];    
                end 
                // error[dp_counter] <= RAM[dp_counter][F] - W[0] - P[1] - P[2] - P[3] - P[4];
                // error[dp_counter] <= data[LENGTH - 1 : 0] - W[0] - P[1] - P[2] - P[3] - P[4];
                error[dp_counter] = data[DATA_WIDTH - 1 -: 16] - W[0];
                for (j = 1;j <= F ; j = j + 1) begin
                    error[dp_counter] = error[dp_counter] - P[j];    
                end                
                NS <= S2;
            end
            S2: begin
                for (j = 1; j <= F; j = j + 1) begin
                    // A[j] <= data[(DATA_WIDTH - 1) - LENGTH * (j-1) -: 16];
                    // A[j] <= RAM[dp_counter][j-1];
                    B[j] <= error[dp_counter] >>> learn_rate;
                end
                NS <= S3;
            end
            S3: begin
                W[0] <= W[0] + error[dp_counter] >>> learn_rate; 
                for (j = 1; j <= F; j = j + 1) begin
                    W[j] <= W[j] + P[j];
                end
                NS <= S0;
            end
            HOLD: begin
                for (j = 1; j <= F; j = j + 1) begin
                    W[j] <= W[j];
                end
                epoch_flag <= 1;
                NS <= IDLE;
            end
            default: begin
                NS <= IDLE;
            end
        endcase
    end

    always @(PS) begin
        case (PS)
            S3: begin
                // if (dp_counter == 3) begin
                if (dp_counter == DP-1) begin
                    dp_counter <= 0;
                    epoch_counter <= epoch_counter + 1;
                end
                else begin
                    dp_counter <= dp_counter + 1;
                end
            end 
            default: dp_counter <= dp_counter;
        endcase
    end

    always @(CLK) begin
        if(RST) begin
            PS <= IDLE;
        end
        else if (epoch_counter == epoch || hold) begin
            PS <= HOLD;
        end
        else begin
            PS <= NS;
        end
    end

    assign done = epoch_flag;

endmodule
