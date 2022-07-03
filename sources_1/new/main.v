`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 06/10/2022 03:25:06 PM
// Design Name:
// Module Name: main
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


module main
    #(
         //parameter ADDR_WIDTH = 10,
         parameter ADDR_WIDTH = 12,
         parameter MAX_FEATURES = 15,
         parameter LENGTH = 16,      //Num_data points
         parameter DATA_WIDTH = LENGTH * (MAX_FEATURES+1), //width = num_features + 1 for y values
         parameter DEPTH = 100      // Num_data points
         // parameter DEPTH = 4      // Num_data points
         //parameter LEN_BITS = 4     // Num_bits required to get 'LENGTH' features
     )
     (
         input CLK, // CLK
         input S, //ser
         input [3:0]feat, // Number of Features
         input RST, // RST
         input [7:0] epoch, // Number of EPOCHS
         input [3:0] learn_rate, // Learning Rate
         input [ADDR_WIDTH-1:0] data_points, // Number of Data Points
         output done_ // Flag for completion
     );

    wire [DATA_WIDTH-1:0] data;
    wire [ADDR_WIDTH-1:0] addr;


    parameter IDLE = 0;
    parameter SER_IN = 1;
    parameter SGD = 3;
    parameter HOLD = 2;

    // serial s ()
    reg ser_rst;
    reg ram_rst;
    reg ram_we;
    reg ram_we_reg;
    reg ram_oe;
    reg ram_oe_reg;
    reg sgd_rst;
    reg sgd_hold;
    wire SER_DONE;
    wire SGD_DONE;
    wire flag;

    wire [ADDR_WIDTH-1:0] sgd_addr;
    wire [ADDR_WIDTH-1:0] ser_addr;

    Serial_in ser (.ser(S), .done(SER_DONE),
                   .CLK(CLK), .addr(ser_addr),
                   .RST(ser_rst), .num_dp(data_points),
                   .feat(feat), .data(data), .flag(flag));

    RAM2 ram (.oe(ram_oe), .we(ram_we),
              .addr(addr), .data(data),
              .RST(ram_rst));

    sgd_v3 lin_reg (.CLK(CLK), .data(data),
                    .addr(sgd_addr), .RST(sgd_rst),
                    .feat(feat), .epoch(epoch),
                    .data_points(data_points),
                    .done(SGD_DONE), .hold(sgd_hold), .learn_rate(learn_rate));

    reg [1:0] PS;
    reg [1:0] NS;

    assign addr = (SER_DONE == 1) ? sgd_addr : ser_addr;

    always @(PS, SGD_DONE, SER_DONE, flag)
    begin
        case(PS)
            IDLE:
            begin
                ser_rst <= 1;
                ram_rst <= 1;
                ram_we <= 0;
                ram_oe <= 0;
                sgd_rst <= 1;
                sgd_hold <= 0;
                NS <= SER_IN;
            end
            SER_IN:
            begin
                ser_rst <= 0;
                ram_rst <= 0;
                // ram_we <= 1;
                ram_oe <= 0;
                sgd_rst <= 1;
                sgd_hold <= 0;
                NS <= SER_DONE ? SGD : SER_IN;
                ram_we <= flag ? 0 : 1;
                $display(flag);
                if (SER_DONE)
                begin
                    ram_we <= 0;
                    ram_oe <= 0;
                end
            end
            SGD:
            begin
                ser_rst <= 0;
                ram_rst <= 0;
                // ram_we <= 0;
                // ram_oe <= 1;
                sgd_rst <= 0;
                sgd_hold <= 0;
                NS <= SGD_DONE ? HOLD : SGD;
                {ram_we, ram_oe} <= SGD_DONE ? {1, 0} : {0, 1};
                // if (SGD_DONE) begin
                //     ram_we <= 1;
                //     ram_oe <= 0;
                // end
            end
            HOLD:
            begin
                ser_rst <= 0;
                ram_rst <= 0;
                ram_we <= 1;
                ram_oe <= 0;
                sgd_rst <= 0;
                sgd_hold <= 1;
                NS <= HOLD;
                #500;
                $finish;
            end
        endcase
    end

    always @(CLK)
    begin
        if (RST)
        begin
            PS <= IDLE;
        end
        else
        begin
            PS <= NS;
        end
    end

    assign done_ = sgd_hold;

endmodule
