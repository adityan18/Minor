`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.04.2022 15:52:18
// Design Name: 
// Module Name: RAM
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


module RAM23
    #(
        // parameter ADDR_WIDTH = 12, 
        parameter ADDR_WIDTH = 3, 
        // parameter DATA_WIDTH = 256, //16*4 bit storage
        // parameter DATA_WIDTH = 80, //16*4 bit storage
        parameter DATA_WIDTH = 128, //16*4 bit storage
        // parameter DEPTH = 1024,      //Num_data points
        parameter DEPTH = 4,      //Num_data points
        parameter LENGTH = 16,      //Num_features
        parameter LEN_BITS = 4 // Num_bits required to get 'LENGTH' features
    )    
    (
        input we, // Write Enable
        input RST, // RST
        input [ADDR_WIDTH-1:0] addr, // Address
        inout [DATA_WIDTH-1:0] data // Data latch
    );
    //512kb
    reg [DATA_WIDTH-1:0] mem [DEPTH-1:0]; // Memory Vector
    reg [DATA_WIDTH-1:0] buffer;
    //4 bits for features, 10 bits for data points

    // initial begin
    //     mem[0] = {16'h0200, 16'h0400, 16'h0300, 16'h0600, 16'h0f00}; //10
    //     mem[0] = {16'h0200, 16'h0400, 16'h0300, 16'h0600, 16'h0f00}; //10

    //     mem[1] = {16'h0300, 16'h0400, 16'h0500, 16'h0600, 16'h1200}; //10
    //     mem[1] = {16'h0300, 16'h0400, 16'h0500, 16'h0600, 16'h1200}; //10
            
    //     mem[2] = {16'h0900, 16'h0100, 16'h0200, 16'h0300, 16'h0f00}; //15
    //     mem[2] = {16'h0900, 16'h0100, 16'h0200, 16'h0300, 16'h0f00}; //15

    //     mem[3] = {16'h0700, 16'h0800, 16'h0000, 16'h0100, 16'h1000}; //16
    // end

    //For Writing, enable cs, we, and make sure data is available at data bus on posedge.
    integer i;
    always@(addr or RST) begin
        if (RST) begin
            for (i = 0; i < DEPTH-1; i = i + 1) begin
                mem[i] <= 0;
            end
        end
        else if(we) begin
            mem[addr] <= data;
        end
    end

    //For Reading, enable cs, oe, disable we, and data will be available on data bus at posedge
    always@(addr) begin
        if(~we) begin
            buffer <= mem[addr];
        end
    end

    assign data = (~we)?buffer:'hz; 

endmodule