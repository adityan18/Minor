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
    // #(
    //     parameter LENGTH = 16, // Each Feature length
    //     parameter  F = 15, // Maximum Number of Features
    //     parameter DP = 10, // Maximum Number of Data Points
    //     // parameter DP = 1024, // Maximum Number of Data Points
    //     parameter DATA_WIDTH = (F+1) * 16 // 16 * F bit storage
    // )
    #(
        //parameter ADDR_WIDTH = 10, 
        parameter ADDR_WIDTH = 12, 
        parameter MAX_FEATURES = 15,
        parameter LENGTH = 16,      //Num_data points
        parameter DATA_WIDTH = LENGTH * (MAX_FEATURES+1), //width = num_features + 1 for y values
        parameter DP = 100      //Num_data points
        // parameter DEPTH = 4      //Num_data points
        //parameter LEN_BITS = 4     // Num_bits required to get 'LENGTH' features
    )
    (
        input CLK, // CLK,
        input RST, // RST
        inout signed [DATA_WIDTH - 1 : 0] data, // DataPoint
        input [3:0] feat, // Number of Features,
        input [ADDR_WIDTH-1:0] data_points, // Numer of Data Points
        input [7:0] epoch, // Number of Epochs
        input hold, // HOLD,
        input [3:0] learn_rate, // Learning Rate
        output [ADDR_WIDTH-1:0] addr, // Address of DataPoint in RAM
        output done // Flag for completion of Epochs
    );

    parameter IDLE = 3'b110; // 6
    parameter LOADW = 3'b100; // 4
    parameter S0 = 3'b000; // 0
    parameter S1 = 3'b001; // 1
    parameter S2 = 3'b011; // 3
    parameter S3 = 3'b010; // 2
    parameter HOLD = 3'b111; // 7

    reg [2:0] PS, NS; // Present State, Next State
    reg epoch_flag;

    assign addr = dp_counter;

    genvar i;
    reg signed [LENGTH-1:0]A[1:MAX_FEATURES]; // Multiplicant
    reg signed [LENGTH-1:0]B[1:MAX_FEATURES]; // Multiplier
    wire signed [LENGTH-1:0]P[1:MAX_FEATURES]; // Product
    generate
        for (i = 1; i <= MAX_FEATURES; i = i + 1) begin
            bw_mul mul (
                .a(A[i]),
                .b(B[i]),
                .p(P[i])
            );
        end
    endgenerate

    reg signed [LENGTH-1:0] error [1:DP]; // Error = Y- Y_CAP
    reg signed [LENGTH-1:0] y_cap [1:DP]; // Error = Y- Y_CAP
    reg signed [LENGTH-1:0] W [0:MAX_FEATURES]; // Weights
    reg [ADDR_WIDTH-1:0]dp_counter; // Data point counter
    reg [7:0] epoch_counter; // Epoch Counter
    reg signed [LENGTH-1:0] Y [1:DP];
    reg signed [DATA_WIDTH - 1 : 0] buffer; 

    integer j;
    always @(PS, epoch_counter) begin
        case (PS)
            IDLE: begin
                NS <= S0;
                dp_counter = 12'd0;
                epoch_counter = 8'd0;
                epoch_flag = 0;
                NS <= LOADW;
                for (j = 1; j <= DP; j = j + 1) begin
                    error[j] <= 0;
                    y_cap[j] <= 0;
                end
            end
            LOADW: begin
                for (j = 0; j <= MAX_FEATURES; j = j + 1) begin
                    W[j] <= data[(DATA_WIDTH - 1) - LENGTH * (j) -: 16];
                end
                NS <= S0;
            end
            S0: begin
                for (j = 1; j <= MAX_FEATURES; j = j + 1) begin
                    // A[j] <= RAM[dp_counter][j-1];
                    A[j] <= data[(DATA_WIDTH - 1) - 16 - LENGTH * (j-1) -: 16];
                    B[j] <= W[j];
                end
                Y[dp_counter] <= data[DATA_WIDTH - 1 -: 16];
                NS <= S1;
            end
            S1: begin
                y_cap[dp_counter] = W[0];
                for (j = 1;j <= MAX_FEATURES ; j = j + 1) begin
                    y_cap[dp_counter] = y_cap[dp_counter] + P[j];    
                end 
                // error[dp_counter] <= RAM[dp_counter][F] - W[0] - P[1] - P[2] - P[3] - P[4];
                // error[dp_counter] <= data[LENGTH - 1 : 0] - W[0] - P[1] - P[2] - P[3] - P[4];
                error[dp_counter] = data[DATA_WIDTH - 1 -: 16] - W[0];
                for (j = 1;j <= MAX_FEATURES ; j = j + 1) begin
                    error[dp_counter] = error[dp_counter] - P[j];    
                end                
                NS <= S2;
            end
            S2: begin
                for (j = 1; j <= MAX_FEATURES; j = j + 1) begin
                    // A[j] <= data[(DATA_WIDTH - 1) - LENGTH * (j-1) -: 16];
                    // A[j] <= RAM[dp_counter][j-1];
                    B[j] <= error[dp_counter] >>> learn_rate;
                end
                NS <= S3;
            end
            S3: begin
                W[0] <= W[0] + error[dp_counter] >>> learn_rate; 
                for (j = 1; j <= MAX_FEATURES; j = j + 1) begin
                    W[j] <= W[j] + P[j];
                end
                NS <= (epoch_counter == epoch) ? HOLD : S0;
            end
            HOLD: begin
                // for (j = 0; j <= MAX_FEATURES; j = j + 1) begin
                //     buffer[(DATA_WIDTH - 1) - LENGTH * (j) -: 16] <= W[j];
                // end
                epoch_flag <= 1;
                NS <= HOLD;
            end
            default: begin
                NS <= IDLE;
            end
        endcase
    end

    always @(PS) begin
        case (PS)
            LOADW: begin
                dp_counter <= dp_counter + 1;
            end
            S3: begin
                // if (dp_counter == 3) begin
                if (dp_counter == data_points) begin
                    dp_counter <= 1;
                    epoch_counter <= epoch_counter + 1;
                end
                else begin
                    dp_counter <= dp_counter + 1;
                end
            end 
            HOLD: begin
                dp_counter <= 0;
            end
            default: dp_counter <= dp_counter;
        endcase
    end

    always @(CLK) begin
        if(RST) begin
            PS <= IDLE;
        end
        else if ((epoch_counter == epoch) && hold) begin
            PS <= HOLD;
        end
        else begin
            PS <= NS;
        end
    end

    assign done = epoch_flag;
    assign data = epoch_flag ? {W[0], W[1], W[2], W[3],
                                W[4], W[5], W[6], W[7],
                                W[8], W[9], W[10], W[11],
                                W[12], W[13], W[14], W[15]} : 'hz;

endmodule
