`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 06/04/2022 09:58:53 PM
// Design Name:
// Module Name: sgd_v3
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


module sgd_v3
    // #(
    //     parameter LENGTH = 16, // Each Feature length
    //     parameter  F = 15, // Maximum Number of Features
    //     parameter DP = 10, // Maximum Number of Data Points
    //     // parameter DP = 1024, // Maximum Number of Data Points
    //     parameter DATA_WIDTH = (F+1) * 16 // 16 * F bit storage
    // )
    #(
        parameter ADDR_WIDTH = 12,
        parameter MAX_FEATURES = 15,
        parameter LENGTH = 16,      //Num_data points
        parameter DATA_WIDTH = LENGTH * (MAX_FEATURES+1), //width = num_features + 1 for y values
        parameter DP = 1024,      //Num_data points
		parameter MAX_MUL = 4 // Maximum Multipliers
    )
    (
        input CLK, // CLK,
        input RST, // RST
        inout signed [DATA_WIDTH - 1 : 0] data, // DataPoint
        input [3:0] feat, // Number of Features,
        input [ADDR_WIDTH-1:0] data_points, // Numer of Data Points
        input [7:0] epoch, // Number of Epochs
        input hold, // HOLD,
        input [3:0] learn_rate, // Learning Rate
        output [ADDR_WIDTH-1:0] addr, // Address of DataPoint in RAM
        output done // Flag for completion of Epochs
    );

	parameter IDLE     = 3'b110; // 6
	parameter LOADW    = 3'b100; // 4
	parameter MUL_YCAP = 3'b000; // 0
	parameter ER_CALC  = 3'b001; // 1
	parameter MUL_WT   = 3'b011; // 3
	parameter WT_UP    = 3'b010; // 2
	parameter HOLD     = 3'b111; // 7

	reg [2:0] PS;
	reg [2:0] NS        ; // Present State, Next State
	reg       epoch_flag;
	
	
	reg signed [    LENGTH-1:0] error        [          1:DP]; // Error = Y- Y_CAP
	reg signed [    LENGTH-1:0] y_cap        [          1:DP]; // Error = Y- Y_CAP
	reg signed [    LENGTH-1:0] W            [0:MAX_FEATURES]; // Weights
	reg        [ADDR_WIDTH-1:0] dp_counter                   ; // Data point counter
	reg        [           7:0] epoch_counter                ; // Epoch Counter
	reg signed [    LENGTH-1:0] Y            [          1:DP];
	reg signed [DATA_WIDTH-1:0] buffer                       ;
	reg [1:0] cycle_count; // Cycle count for cycling through multiplier for one dataset
	reg mux21_flag;

	assign addr = dp_counter;

	// X MUX
	wire [15:0] Yx [1:4];
	mux41 muxx1 (.A(data[(ADDR_WIDTH-1-16*1) -: 16]), .B(data[(ADDR_WIDTH-1-16*2) -: 16]), .C(data[(ADDR_WIDTH-1-16*2) -: 16]), .D(data[(ADDR_WIDTH-1-16*4) -: 16]), .S(cycle_count), .Y(Yx[1]));
	mux41 muxx2 (.A(data[(ADDR_WIDTH-1-16*5) -: 16]), .B(data[(ADDR_WIDTH-1-16*6) -: 16]), .C(data[(ADDR_WIDTH-1-16*7 -: 16]), .D(data[(ADDR_WIDTH-1-16*8) -: 16]), .S(cycle_count), .Y(Yx[2]));
	mux41 muxx3 (.A(data[(ADDR_WIDTH-1-16*9) -: 16]), .B(data[(ADDR_WIDTH-1-16*10) -: 16]), .C(data[(ADDR_WIDTH-1-16*11) -: 16]), .D(data[(ADDR_WIDTH-1-16*12) -: 16]), .S(cycle_count), .Y(Yx[3]));
	mux41 muxx4 (.A(data[(ADDR_WIDTH-1-16*13) -: 16]), .B(data[(ADDR_WIDTH-1-16*14) -: 16]), .C(data[(ADDR_WIDTH-1-16*15) -: 16]), .D(0), .S(cycle_count), .Y(Yx[4]));

	// Weight MUX
	wire [15:0] Yw [1:4];
	mux41 muxw1 (.A(W[1]), .B(W[2]), .C(W[3]), .D(W[4]), .S(cycle_count), .Y(Yw[1]));
	mux41 muxw2 (.A(W[5]), .B(W[6]), .C(W[7]), .D(W[8]), .S(cycle_count), .Y(Yw[2]));
	mux41 muxw3 (.A(W[9]), .B(W[10]), .C(W[11]), .D(W[12]), .S(cycle_count), .Y(Yw[3]));
	mux41 muxw4 (.A(W[13]), .B(W[14]), .C(W[15]), .D(0), .S(cycle_count), .Y(Yw[4]));

	// MUX21
	wire [15:0] Yb [1:4];
	mux21 muxB1 (.A(), .B(error[dp_counter]), .S(mux21_flag), .Y(Yb[1]));
	mux21 muxB2 (.A(), .B(error[dp_counter]), .S(mux21_flag), .Y(Yb[2]));
	mux21 muxB3 (.A(), .B(error[dp_counter]), .S(mux21_flag), .Y(Yb[3]));
	mux21 muxB4 (.A(), .B(error[dp_counter]), .S(mux21_flag), .Y(Yb[4]));



	// Multiplier
	reg signed [LENGTH-1:0]A[1:MAX_MUL]; // Multiplicant
	reg signed [LENGTH-1:0]B[1:MAX_MUL]; // Multiplier
	wire signed [LENGTH-1:0]P[1:MAX_MUL]; // Product

	bw_mul mul1 (.a(Yx[1]), .b(Yb[1]), .p(P[1]));
	bw_mul mul2 (.a(Yx[2]), .b(Yb[2]), .p(P[2]));
	bw_mul mul3 (.a(Yx[3]), .b(Yb[3]), .p(P[3]));
	bw_mul mul4 (.a(Yx[4]), .b(Yb[4]), .p(P[4]));


	integer j;
	always @(PS, epoch_counter) begin
		case (PS)
			IDLE : begin
				NS            <= MUL_YCAP;
				dp_counter    = 12'd0;
				epoch_counter = 8'd0;
				epoch_flag    = 0;
				NS            <= LOADW;
				cycle_count <= 0;
				for (j = 1; j <= DP; j = j + 1) begin
					error[j] <= 0;
					y_cap[j] <= 0;
				end
			end
			LOADW : begin
				for (j = 0; j <= MAX_FEATURES; j = j + 1) begin
					W[j] <= data[(DATA_WIDTH - 1) - LENGTH * (j) -: 16];
				end
				NS <= MUL_YCAP;
			end
			MUL_YCAP : begin
				// for (j = 1; j <= MAX_FEATURES; j = j + 1) begin
				// 	A[j] <= data[(DATA_WIDTH - 1) - 16 - LENGTH * (j-1) -: 16];
				// 	B[j] <= W[j];
				// end
				// Y[dp_counter] <= data[DATA_WIDTH - 1 -: 16];
				NS            <= ER_CALC;
			end
			ER_CALC : begin
				Y[dp_counter] <= data[DATA_WIDTH - 1 -: 16];
				if (cycle_count == 0) begin
					error[dp_counter] <= error[dp_counter] - W[0] - P[1] - P[2] - P[3] - P[4];
				end
				else begin
					error[dp_counter] <= error[dp_counter] - P[1] - P[2] - P[3] - P[4];
				end
				// y_cap[dp_counter] = W[0];
				// for (j = 1;j <= MAX_FEATURES ; j = j + 1) begin
				// 	y_cap[dp_counter] = y_cap[dp_counter] + P[j];
				// end
				// error[dp_counter] = data[DATA_WIDTH - 1 -: 16] - W[0];
				// for (j = 1;j <= MAX_FEATURES ; j = j + 1) begin
				// 	error[dp_counter] = error[dp_counter] - P[j];
				// end
				cycle_count <= cycle_count + 1;
				NS <= (cycle_count == 2) ? MUL_WT : MUL_YCAP;
			end
			MUL_WT : begin
				$finish;
				for (j = 1; j <= MAX_FEATURES; j = j + 1) begin
					B[j] <= error[dp_counter] >>> learn_rate;
				end
				NS <= WT_UP;
			end
			WT_UP : begin
				W[0] <= W[0] + error[dp_counter] >>> learn_rate;
				for (j = 1; j <= MAX_FEATURES; j = j + 1) begin
					W[j] <= W[j] + P[j];
				end
				NS <= (epoch_counter == epoch) ? HOLD : MUL_YCAP;
			end
			HOLD : begin
				epoch_flag <= 1;
				NS         <= HOLD;
			end
			default : begin
				NS <= IDLE;
			end
		endcase
	end

	always @(PS) begin
		case (PS)
			LOADW : begin
				dp_counter <= dp_counter + 1;
			end
			WT_UP : begin
				// if (dp_counter == 3) begin
				if (dp_counter == data_points) begin
					dp_counter    <= 1;
					epoch_counter <= epoch_counter + 1;
				end
				else begin
					dp_counter <= dp_counter + 1;
				end
			end
			HOLD : begin
				dp_counter <= 0;
			end
			default : dp_counter <= dp_counter;
		endcase
	end

	always @(CLK) begin
		if(RST) begin
			PS <= IDLE;
		end
		else if ((epoch_counter == epoch) && hold) begin
			PS <= HOLD;
		end
		else begin
			PS <= NS;
		end
	end

	assign done = epoch_flag;
	assign data = epoch_flag ? {W[0], W[1], W[2], W[3],
		W[4], W[5], W[6], W[7],
		W[8], W[9], W[10], W[11],
		W[12], W[13], W[14], W[15]} : 'hz;

endmodule
