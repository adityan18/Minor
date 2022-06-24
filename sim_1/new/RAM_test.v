`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.04.2022 20:08:21
// Design Name: 
// Module Name: RAM_test
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


module RAM_test();
parameter ADDR_WIDTH = 14; 
parameter DATA_WIDTH = 32; //32 bit storage
parameter DEPTH = 1024;      //Num_data points
parameter LENGTH = 16;      //Num_features
parameter LEN_BITS = 4;

reg clk, cs, we, oe;
reg[ADDR_WIDTH-1:0] addr;
wire [DATA_WIDTH-1:0] data;
reg [DATA_WIDTH-1:0] tb_data;

RAM r1(clk,cs,we,oe,addr,data);

always #10 clk = ~clk;

assign data = (~oe)?tb_data:'hz;

initial
begin
    {clk,cs,we,addr,tb_data,oe}<=0;
    
    repeat(2) @ (posedge clk);
    
    for(integer i = 0; i < 20; i = i + 1)
    begin
        repeat(1)@(posedge clk) addr <= i;we <=1; cs<=1; oe<=0;tb_data<=$random;
    end
    for(integer i = 0; i < 20; i = i + 1)
    begin
        repeat(1)@(posedge clk) addr <= i;we <=0; cs<=1; oe<=1;
    end
    
    #20 $finish;
    
end

endmodule
