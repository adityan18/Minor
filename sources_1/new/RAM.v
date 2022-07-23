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


module RAM
    #(parameter ADDR_WIDTH = 14,
      parameter DATA_WIDTH = 32, //32 bit storage
      parameter DEPTH = 1024,      //Num_data points
      parameter LENGTH = 16,      //Num_features
      parameter LEN_BITS = 4 )    // Num_bits required to get 'LENGTH' features
     (
         input clk, cs, we, oe,
         input [ADDR_WIDTH-1:0] addr,
         inout [DATA_WIDTH-1:0] data
     );
    //512kb
    reg [DATA_WIDTH-1:0] mem[DEPTH-1:0][LENGTH-1:0];
    reg [DATA_WIDTH-1:0] buffer;
    //4 bits for features, 10 bits for data points

    //For Writing, enable cs, we, and make sure data is available at data bus on posedge.
    always@(posedge clk)
    begin
        if(cs & we)
        begin
            mem[addr[ADDR_WIDTH-1:LEN_BITS]][addr[LEN_BITS-1:0]] <= data;
        end
    end

    //For Reading, enable cs, oe, disable we, and data will be available on data bus at posedge
    always@(posedge clk)
    begin
        if(cs & ~we)
        begin
            buffer <= mem[addr[ADDR_WIDTH-1:LEN_BITS]][addr[LEN_BITS-1:0]];
        end
    end

    assign data = (cs & oe & ~we)?buffer:'hz;

endmodule
