`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2022 08:16:26 PM
// Design Name: 
// Module Name: sgd_tb
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


module sgd_tb(

    );

    reg clk;
    reg rst;
    reg en;
    reg [3:0] feat;
    reg [7:0] epoch;
    reg [11:0] data_points;
    wire done;


    main dut (.CLK(clk), .en(en) , .RST(rst), .feat(feat), .epoch(epoch), .data_points(data_points), .done(done));

    always begin
        clk = 0; #2;
        clk = 1; #2;
    end

    initial begin
        data_points = 11'd4;
        epoch = 8'd100;
        // en = 0;
        // rst = 1;
        // feat = 3'd2;
        // #20;
        // rst = 0;
        // #5000;
        en = 0;
        rst = 1;
        feat = 3'd4;
        epoch = 8'd5;
        #10;
        rst = 0;
        // en = 0;
        // rst = 1;
        // feat = 3'd4;
        // #20;
        // rst = 0;
        // #5000;
    end

    always @ (done) begin
        if (done) begin
            #50;
            $finish;
        end
    end
endmodule
