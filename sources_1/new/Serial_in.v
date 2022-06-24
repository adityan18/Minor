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
        input [11:0] num_dp,
        input [3:0] feat,
        input ser,
        input CLK,
        input RST,
        output [11:0] addr,
        output [191:0] data,
        output reg flag,
        output done
    );
    parameter ADDR_WIDTH = 12, DATA_WIDTH = 16 * 12, NUM_DP = 4; //16*6 bit storage
    reg reg_oe = 0;
    reg reg_we = 0;
    reg reg_done = 0;
    reg [DATA_WIDTH-1:0] shift_reg, temp = 0;
    reg [8:0] counter ;//256 bit counter
    reg [ADDR_WIDTH-1:0] addr_reg;

    // RAM2 r(0, 1, RST, addr, data);

    always@(CLK) begin
        // if(done==0) begin
        if(RST) begin
            addr_reg <= -1;
            shift_reg <= 0;
            reg_we <= 0;
            reg_oe <= 0;
            reg_done <= 0;
            counter <= 0;
            flag <= 0;
        end
        else if (done != 1) begin
        //     shift_reg[counter] <= ser;
        //     if(counter == ((feat+1)*16)-1) begin
        //         counter <= 0;
        //         // shift_reg <= temp;
        //         addr_reg <= addr_reg + 1;
        //         $display("%h, %d", shift_reg , addr_reg, $time);
        //     end
        //     else
        //         counter <= counter + 1;
        //     // end
        //     if (addr_reg == num_dp - 1) begin
        //         reg_done <= 1;
        //     end

            shift_reg[counter] = ser;
            if (counter != (feat+1)*16 - 1) begin
                counter = counter + 1;
                if (addr_reg == num_dp - 1) begin
                    if (counter == DATA_WIDTH / 2) begin
                        $display("%d", counter, $time);
                        flag = 1;
                    end
                end
            end                
            else begin
                counter = 0;
                addr_reg = addr + 1;
                if (addr_reg == num_dp) begin
                    reg_done = 1;
                end
            end
        end
    end
        

    assign data = (done == 1) ? 'hz : shift_reg;
    assign done = reg_done;
    assign addr = (done==1) ? 'hz : addr_reg;

endmodule