
// ///////////////////////////////////////

// `timescale 1ns / 1ps
// //////////////////////////////////////////////////////////////////////////////////
// // Company: 
// // Engineer: 
// // 
// // Create Date: 30.04.2022 15:52:18
// // Design Name: 
// // Module Name: RAM
// // Project Name: 
// // Target Devices: 
// // Tool Versions: 
// // Description: 
// // 
// // Dependencies: 
// // 
// // Revision:
// // Revision 0.01 - File Created
// // Additional Comments:
// // 
// //////////////////////////////////////////////////////////////////////////////////


// module RAM2#(
//         //parameter ADDR_WIDTH = 10, 
//         parameter ADDR_WIDTH = 3, 
//         parameter MAX_FEATURES = 6,
//         // parameter DATA_WIDTH = 16*(MAX_FEATURES+1), //width = num_features + 1 for y values
//         parameter DATA_WIDTH = 128, //width = num_features + 1 for y values
//         //parameter DEPTH = 1024,      //Num_data points
//         parameter DEPTH = 6      //Num_data points
//         //parameter LEN_BITS = 4     // Num_bits required to get 'LENGTH' features
//     )
//     (
//         input we,
//         // input en/,
//         input RST,
//         input [ADDR_WIDTH-1:0] addr,
//         inout [DATA_WIDTH-1:0] data
//     );
// //512kb


//     integer i;
//     reg [DATA_WIDTH-1:0] mem[DEPTH-1:0];
//     reg [DATA_WIDTH-1:0] buffer;
//     //4 bits for features, 10 bits for data points

//     initial begin
//         // $readmemh("E:/Dhanush/Minor_project/Minor_project.srcs/sources_1/new/data_points.txt",mem);
//     end

//     //For Writing, enable cs, we, and make sure data is available at data bus on posedge.
//     always@(addr or RST)
//     begin
//         if(RST) begin
//             for(i=0;i<DEPTH-1;i=i+1) begin
//                 mem[i]<=0;
//             end
//         end
//         else if(we) begin
//             mem[addr] <= data;
//         end
//     end

//     //For Reading, enable cs, oe, disable we, and data will be available on data bus at posedge
//     always@(addr)
//     begin
//         if(~we)
//         begin
//             buffer <= mem[addr];
//         end
//     end

//     assign data = (~we)?buffer:'hz; 

// endmodule


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


module RAM2
    #(
        //parameter ADDR_WIDTH = 10, 
        parameter ADDR_WIDTH = 12, 
        parameter MAX_FEATURES = 15,
        parameter LENGTH = 16,      //Num_data points
        parameter DATA_WIDTH = LENGTH * (MAX_FEATURES+1), //width = num_features + 1 for y values
        parameter DEPTH = 100     //Num_data points
        // parameter DEPTH = 4      //Num_data points
        //parameter LEN_BITS = 4     // Num_bits required to get 'LENGTH' features
    )
    (
        input oe, we, RST,
        input [ADDR_WIDTH-1:0] addr,
        inout [DATA_WIDTH-1:0] data
    );
//512kb

    integer i;
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    reg [DATA_WIDTH-1:0] buffer;
    //4 bits for features, 10 bits for data points

    //For Writing, enable cs, we, and make sure data is available at data bus on posedge.
    always@(addr or RST or we or data) begin
        if(RST) begin
            for(i=0;i<DEPTH;i=i+1) begin
                mem[i]<=0;
            end
        end
        else if(we) begin
            $display("%h", data);
            mem[addr] <= data;
        end
    end

    //For Reading, enable cs, oe, disable we, and data will be available on data bus at posedge
    always@(addr) begin
        if(~we) begin
            buffer <= mem[addr];
        end
    end

    assign data = (~we && oe) ? buffer : 'hz; 

endmodule
