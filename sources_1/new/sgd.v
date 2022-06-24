`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2022 08:15:03 PM
// Design Name: 
// Module Name: sgd
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


module sgd(
    input CLK, // 100MHz input CLK
    output flag
    );
    parameter bits = 16; // no of bits
    parameter f = 4; // no of features
    assign flag = 1;

    reg signed [bits-1:0]Ay[0:f]; // Nets for coefficenients of weights for y_cap x0, x1....
    wire signed [bits-1:0]Py[0:f]; // Nets for Product for y_cap x1 * w1, w2 * x2 ....

    integer i, j, l, m; // Loop Variable

    reg [bits-1:0]ram[0:3][0:f+1];
    initial begin
        ram[0][0] = 16'h0400; 
        ram[0][1] = 16'h0800; //2
        ram[0][2] = 16'h1000; //4
        ram[0][3] = 16'h0b00; //3
        ram[0][4] = 16'h1800; //6
        ram[0][5] = 16'h2800; //10

        ram[1][0] = 16'h0400;
        ram[1][1] = 16'h0b00; //3
        ram[1][2] = 16'h1000; //4
        ram[1][3] = 16'h1400; //5
        ram[1][4] = 16'h1800; //6
        ram[1][5] = 16'h2800; //10
        
        ram[2][0] = 16'h0400; 
        ram[2][1] = 16'h2400; //9
        ram[2][2] = 16'h0400; //1
        ram[2][3] = 16'h0800; //2
        ram[2][4] = 16'h0b00; //3
        ram[2][5] = 16'h2800; //15

        ram[3][0] = 16'h0400;
        ram[3][1] = 16'h1c00; //7
        ram[3][2] = 16'h2000; //8
        ram[3][3] = 16'h0000; //0
        ram[3][4] = 16'h0400; //1
        ram[3][5] = 16'h2c00; //16
    end


    // Creating multiple multiplier instatinations needed for y_cap
    genvar k;
    generate
        for (k = 0; k < f+1; k = k + 1) begin
            mul mul1 (
                .CLK(CLK),  // input wire CLK
                .A(Ay[k]),      // input wire [7 : 0] A
                .B(weight[k]),      // input wire [7 : 0] B
                .P(Py[k])      // output wire [7 : 0] P
            );
        end
    endgenerate

    reg signed [bits-1:0] MUL = 16'd5; // 2 * eta / N
    reg signed [bits-1:0] error; // Y - Y_cap
    reg signed [bits-1:0] y_cap [0:3]; // Predicted Y
    reg signed [bits-1:0] weight [0:f]; // Weights
    reg [2:0]d_count = 0;

    initial begin // Initialising the weights
        weight[0] = 16'h100;
        weight[1] = 16'h100;
        weight[2] = 16'h100;
        weight[3] = 16'h100;
        weight[4] = 16'h100;
    end

    always @(posedge CLK) begin
        for (i = 0; i < f+1; i = i + 1) begin
            // Assigning X values into A and B are already declared to be weights
            // Product is found at the next posedge
            Ay[i] <= ram[d_count][i]; // Coefficeint of weights ie x1, x2 .....
        end
    end

    always @(negedge CLK) begin
        if (d_count == 3) begin
            d_count <= 0;
        end
        else
            d_count <= d_count + 1;
    end

    always @(Py) begin // Updating y_cap when y_cap Products are updated
        y_cap[d_count] = Py[0]; // Initialising y_cap to x0 * w0
        for (j = 1; j < f+1; j = j + 1) begin
            y_cap[d_count] = y_cap[d_count] + Py[j]; // Summing y_cap with x1w1 + x2w2 + ....
        end
        // error = (ram[d_count][f+1] - y_cap[d_count]); // Calculating (y - y_cap) * learning rate
        $display("y:%d.%b, y_cap:%d.%b", ram[d_count][f+1][15-:6], ram[d_count][f+1][9-:10] , y_cap[d_count][15-:6], y_cap[d_count][9-:10], $time);
    end

    reg signed [bits-1:0]Aw[0:f]; // Nets for Weight Update - Y - Y_CAP
    wire signed [bits-1:0]Pw[0:f]; // Nets for (Y - YCAP) * Y
    generate
        for (k = 0; k < f+1; k = k + 1) begin
            mul mul1 (
                .CLK(CLK),  // input wire CLK
                .A(Aw[k]),      // input wire [7 : 0] A
                .B(ram[d_count][k]),      // input wire [7 : 0] B
                .P(Pw[k])      // output wire [7 : 0] P
            );
        end
    endgenerate

    always @(negedge CLK) begin
        for (l = 0;l < f + 1; l = l + 1) begin
            Aw[l] <= (ram[d_count][f+1] - y_cap[d_count]) >>> 7;
        end
    end

    always @(Pw) begin
        for (m = 0;m < f+1; m = m + 1 ) begin
            weight[m] <= weight[m] + Pw[m];
        end
    end

endmodule