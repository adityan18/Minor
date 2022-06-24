`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2022 08:18:31 PM
// Design Name: 
// Module Name: ramv2_tb
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


module ramv2_tb
#(parameter ADDR_WIDTH = 10, 
// parameter DATA_WIDTH = 256, //16*4 bit storage
parameter DATA_WIDTH = 80, //16*4 bit storage
// parameter DEPTH = 1024,      //Num_data points
parameter DEPTH = 4,      //Num_data points
parameter LENGTH = 16,      //Num_features
parameter LEN_BITS = 4 ) (

    );
    reg en;
    reg [11:0] addr;
    wire [DATA_WIDTH-1:0] data;

    RAM2 dut(en, addr, data);

    initial begin
        en = 0; #10;
        addr = 0; 
        $display("%h", data);
        $display("%h", data[(DATA_WIDTH-1) - 16 * 0-:16]);
        $display("%h", data[(DATA_WIDTH-1) - 16 * 1-:16]);
        $display("%h", data[(DATA_WIDTH-1) - 16 * 2-:16]);
        $display("%h", data[(DATA_WIDTH-1) - 16 * 3-:16]);
        #20; 
        addr = 1;
        $display("%h", data);
        $display("%h", data[(DATA_WIDTH-1) - 16 * 0-:16]);
        $display("%h", data[(DATA_WIDTH-1) - 16 * 1-:16]);
        $display("%h", data[(DATA_WIDTH-1) - 16 * 2-:16]);
        $display("%h", data[(DATA_WIDTH-1) - 16 * 3-:16]);
        #20;
        addr = 2;
        $display("%h", data);
        $display("%h", data[(DATA_WIDTH-1) - 16 * 0-:16]);
        $display("%h", data[(DATA_WIDTH-1) - 16 * 1-:16]);
        $display("%h", data[(DATA_WIDTH-1) - 16 * 2-:16]);
        $display("%h", data[(DATA_WIDTH-1) - 16 * 3-:16]);
        #20;
        addr = 3;
        $display("%h", data);
        $display("%h", data[(DATA_WIDTH-1) - 16 * 0-:16]);
        $display("%h", data[(DATA_WIDTH-1) - 16 * 1-:16]);
        $display("%h", data[(DATA_WIDTH-1) - 16 * 2-:16]);
        $display("%h", data[(DATA_WIDTH-1) - 16 * 3-:16]);
        #20;
        $finish;
    end
endmodule
