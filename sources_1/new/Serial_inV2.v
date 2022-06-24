`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2022 10:48:54
// Design Name: 
// Module Name: Serial_in
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


module Serial_in(
    input ser,
    input CLK,
    output reg done = 0
    );
    parameter ADDR_WIDTH = 11, DATA_WIDTH = 16 * 12, NUM_DP = 5; //16*6 bit storage
    reg oe = 0;
    reg we = 0;
    reg RST = 0;
    reg done_reg = 0;
    wire [ADDR_WIDTH-1:0] addr;
    wire [DATA_WIDTH-1:0] data;
    //reg [FULL*NUM_DP-1:0] full_data;
    reg [DATA_WIDTH-1:0] shift_reg;
    reg[8:0] counter = 0;//256 bit counter
    reg [ADDR_WIDTH-1:0] addr_reg;

    reg [1:0] PS;
    reg [1:0] NS;

    parameter IDLE = 0;
    parameter SERIN = 1;
    RAM2 r(oe, we, RST, addr, data);


    always @(PS) begin
        case (PS)
            IDLE: begin
                addr_reg <= 0;
                counter <= 0;
                we <= 0;
                NS <= SERIN;
            end
            SERIN: begin
                shift_reg[counter] <= ser;
                counter <= counter + 1;
                NS <= ( counter == DATA_WIDTH - 1 ) : WRITE ? SERIN;
            end
            WRITE: begin
                we <= 1;
                NS <= SERIN;
            end

        endcase
    end

    always @ (CLK) begin
        if (RST) begin
            PS <= IDLE;
        end
        else begin
            PS <= NS;
        end
    end

    always@(CLK) begin
        if (addr_reg == NUM_DP) begin
            done <= 1;
        end
        we<=0;
        shift_reg[counter] <= ser;
        if(counter==DATA_WIDTH-1) begin
            we=1;
            addr_reg = addr_reg + 1;
            counter = 0;
        end
        else
            counter <= counter + 1;
    end

    assign data = (done == 1) ? 'hz : shift_reg;
    assign addr = addr_reg;

endmodule
