`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2022 05:56:42 PM
// Design Name: 
// Module Name: sgd_v2
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


module sgd_v2
    #(  parameter bits = 16,
        parameter f = 4,
        parameter dp = 4)(
    input CLK, // CLK
    output temp // temp output
    );

    assign temp = 1;

    reg signed [bits-1:0]ram[0:dp-1][0:f];
    initial begin
        ram[0][0] = 16'h0100; //2
        ram[0][1] = 16'h0000; //4
        ram[0][2] = 16'h0800; //3
        ram[0][3] = 16'h0700; //6
        ram[0][4] = 16'h1000; //10

        ram[1][0] = 16'h0300; //3
        ram[1][1] = 16'h0200; //4
        ram[1][2] = 16'h0100; //5
        ram[1][3] = 16'h0900; //6
        ram[1][4] = 16'h0f00; //10
         
        ram[2][0] = 16'h0600; //9
        ram[2][1] = 16'h0500; //1
        ram[2][2] = 16'h0400; //2
        ram[2][3] = 16'h0300; //3
        ram[2][4] = 16'h1200; //15

        ram[3][0] = 16'h0600; //7
        ram[3][1] = 16'h0300; //8
        ram[3][2] = 16'h0400; //0
        ram[3][3] = 16'h0200; //1
        ram[3][4] = 16'h0f00; //16
    end
    
    // Multiplier Instatniations for Error Multiplication
    genvar i;
    reg signed [bits-1:0]Ae[1:f];
    wire signed [bits-1:0]Pe[1:f];
    generate
        for (i = 1; i <= f; i = i + 1) begin
            fmul mul1 (
                .CLK(CLK),
                .A(Ae[i]),
                .B(W[i]),
                .P(Pe[i])
            );
        end
    endgenerate

    reg signed [bits-1:0] y_cap [0:dp-1];
    reg signed [bits-1:0] W [0:f];
    reg signed lr = 16'h0090;

    initial begin // Initialising the weights
        W[0] = 16'h0040;
        W[1] = 16'h0040;
        W[2] = 16'h0040;
        W[3] = 16'h0040;
        W[4] = 16'h0040;
    end

    reg [2:0]dp_counter = -1;
    reg [2:0]dp_counter_prev = -2;
    always @(negedge CLK) begin
        if (dp_counter == dp-1) begin
            dp_counter <= 0;
        end
        else
            dp_counter <= dp_counter + 1;
        if (dp_counter_prev == dp - 1) begin
            dp_counter_prev <= 0;
        end
        else
            dp_counter_prev <= dp_counter_prev + 1;

        // $display("%d ", dp_counter, $time);
    end

    integer j;
    always @(dp_counter) begin
        for (j = 0; j < f; j = j + 1) begin
            Ae[j+1] <= ram[dp_counter][j];
        end
    end

    integer k;
    reg signed [bits-1:0] temp2 = 0;
    reg signed [bits-1:0] error [0:dp-1];
    always @(Pe) begin
        temp2 = W[0];
        for (k = 1; k <= f; k = k + 1) begin
            temp2 = temp2 + Pe[k]; 
        end
    end
    always @(temp2) begin
        y_cap[dp_counter] = temp2;
        error[dp_counter] = ram[dp_counter][f] - y_cap[dp_counter];
    end
    // always @(negedge CLK) begin
    //     error[dp_counter] <= ram[dp_counter][f] - y_cap[dp_counter]; // Y - Y_CAP
    //     $display("error:%h, s:%h", error[dp_counter], error[dp_counter] >>> 7, $time);
    // end

    reg signed [bits-1:0] error_shift [0:dp-1];

    wire signed [bits-1:0]Pw[1:f];
    genvar l;
    generate
        for (l = 1; l <= f; l = l + 1) begin
            fmul mul2 (
                .CLK(CLK),  // input wire CLK
                .A(error[dp_counter_prev] >>> 7),      // Error * lr
                .B(ram[dp_counter_prev][l]),      // Xi
                .P(Pw[l])      // Error * lr * Xi
            );
        end
    endgenerate

    // Weight Update
    integer m;
    always @(Pw) begin
        W[0] <= W[0] + (error[dp_counter_prev] >>> 7);
        for (m = 1; m <= f; m = m + 1) begin
            W[m] <= W[m] + Pw[m];
        end
    end
endmodule
