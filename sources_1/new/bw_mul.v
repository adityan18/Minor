
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2022 15:20:52
// Design Name: 
// Module Name: bw_mul
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

module bw_mul(
    input signed [15:0]a, // 16 bit input
    input signed [15:0]b, // 16 bit input
    output signed [15:0]p // 16 bit product
);

    parameter bit = 16;

    wire signed [(bit - 2)*2+1:0]sg; // sum out gray cell
    wire signed [(bit - 2)*2+1:0]cg; // carry out gray cell

    wire signed [(bit-1)*(bit-1)+1:0]sw; // sum out white cell
    wire signed [(bit-1)*(bit-1)+1:0]cw; // carry out white cell

    wire signed [bit - 1:0]fs; // full adder sum
    wire signed [bit - 1:0]fc; // full adder carry

	carry_adder w0 (a[0], b[0], 0, 0, cw[0]);
	white w1 (a[1], b[0], 0, 0, sw[1], cw[1]);
	white w2 (a[2], b[0], 0, 0, sw[2], cw[2]);
	white w3 (a[3], b[0], 0, 0, sw[3], cw[3]);
	white w4 (a[4], b[0], 0, 0, sw[4], cw[4]);
	white w5 (a[5], b[0], 0, 0, sw[5], cw[5]);
	white w6 (a[6], b[0], 0, 0, sw[6], cw[6]);
	white w7 (a[7], b[0], 0, 0, sw[7], cw[7]);
	white w8 (a[8], b[0], 0, 0, sw[8], cw[8]);
	white w9 (a[9], b[0], 0, 0, sw[9], cw[9]);
	white w10 (a[10], b[0], 0, 0, sw[10], cw[10]);
	white w11 (a[11], b[0], 0, 0, sw[11], cw[11]);
	white w12 (a[12], b[0], 0, 0, sw[12], cw[12]);
	white w13 (a[13], b[0], 0, 0, sw[13], cw[13]);
	white w14 (a[14], b[0], 0, 0, sw[14], cw[14]);

	carry_adder w15 (a[0], b[1], cw[0], sw[1], cw[15]);
	white w16 (a[1], b[1], cw[1], sw[2], sw[16], cw[16]);
	white w17 (a[2], b[1], cw[2], sw[3], sw[17], cw[17]);
	white w18 (a[3], b[1], cw[3], sw[4], sw[18], cw[18]);
	white w19 (a[4], b[1], cw[4], sw[5], sw[19], cw[19]);
	white w20 (a[5], b[1], cw[5], sw[6], sw[20], cw[20]);
	white w21 (a[6], b[1], cw[6], sw[7], sw[21], cw[21]);
	white w22 (a[7], b[1], cw[7], sw[8], sw[22], cw[22]);
	white w23 (a[8], b[1], cw[8], sw[9], sw[23], cw[23]);
	white w24 (a[9], b[1], cw[9], sw[10], sw[24], cw[24]);
	white w25 (a[10], b[1], cw[10], sw[11], sw[25], cw[25]);
	white w26 (a[11], b[1], cw[11], sw[12], sw[26], cw[26]);
	white w27 (a[12], b[1], cw[12], sw[13], sw[27], cw[27]);
	white w28 (a[13], b[1], cw[13], sw[14], sw[28], cw[28]);
	white w29 (a[14], b[1], cw[14], sg[0], sw[29], cw[29]);
	carry_adder w30 (a[0], b[2], cw[15], sw[16], cw[30]);
	white w31 (a[1], b[2], cw[16], sw[17], sw[31], cw[31]);
	white w32 (a[2], b[2], cw[17], sw[18], sw[32], cw[32]);
	white w33 (a[3], b[2], cw[18], sw[19], sw[33], cw[33]);
	white w34 (a[4], b[2], cw[19], sw[20], sw[34], cw[34]);
	white w35 (a[5], b[2], cw[20], sw[21], sw[35], cw[35]);
	white w36 (a[6], b[2], cw[21], sw[22], sw[36], cw[36]);
	white w37 (a[7], b[2], cw[22], sw[23], sw[37], cw[37]);
	white w38 (a[8], b[2], cw[23], sw[24], sw[38], cw[38]);
	white w39 (a[9], b[2], cw[24], sw[25], sw[39], cw[39]);
	white w40 (a[10], b[2], cw[25], sw[26], sw[40], cw[40]);
	white w41 (a[11], b[2], cw[26], sw[27], sw[41], cw[41]);
	white w42 (a[12], b[2], cw[27], sw[28], sw[42], cw[42]);
	white w43 (a[13], b[2], cw[28], sw[29], sw[43], cw[43]);
	white w44 (a[14], b[2], cw[29], sg[1], sw[44], cw[44]);
	carry_adder w45 (a[0], b[3], cw[30], sw[31], cw[45]);
	white w46 (a[1], b[3], cw[31], sw[32], sw[46], cw[46]);
	white w47 (a[2], b[3], cw[32], sw[33], sw[47], cw[47]);
	white w48 (a[3], b[3], cw[33], sw[34], sw[48], cw[48]);
	white w49 (a[4], b[3], cw[34], sw[35], sw[49], cw[49]);
	white w50 (a[5], b[3], cw[35], sw[36], sw[50], cw[50]);
	white w51 (a[6], b[3], cw[36], sw[37], sw[51], cw[51]);
	white w52 (a[7], b[3], cw[37], sw[38], sw[52], cw[52]);
	white w53 (a[8], b[3], cw[38], sw[39], sw[53], cw[53]);
	white w54 (a[9], b[3], cw[39], sw[40], sw[54], cw[54]);
	white w55 (a[10], b[3], cw[40], sw[41], sw[55], cw[55]);
	white w56 (a[11], b[3], cw[41], sw[42], sw[56], cw[56]);
	white w57 (a[12], b[3], cw[42], sw[43], sw[57], cw[57]);
	white w58 (a[13], b[3], cw[43], sw[44], sw[58], cw[58]);
	white w59 (a[14], b[3], cw[44], sg[2], sw[59], cw[59]);
	carry_adder w60 (a[0], b[4], cw[45], sw[46], cw[60]);
	white w61 (a[1], b[4], cw[46], sw[47], sw[61], cw[61]);
	white w62 (a[2], b[4], cw[47], sw[48], sw[62], cw[62]);
	white w63 (a[3], b[4], cw[48], sw[49], sw[63], cw[63]);
	white w64 (a[4], b[4], cw[49], sw[50], sw[64], cw[64]);
	white w65 (a[5], b[4], cw[50], sw[51], sw[65], cw[65]);
	white w66 (a[6], b[4], cw[51], sw[52], sw[66], cw[66]);
	white w67 (a[7], b[4], cw[52], sw[53], sw[67], cw[67]);
	white w68 (a[8], b[4], cw[53], sw[54], sw[68], cw[68]);
	white w69 (a[9], b[4], cw[54], sw[55], sw[69], cw[69]);
	white w70 (a[10], b[4], cw[55], sw[56], sw[70], cw[70]);
	white w71 (a[11], b[4], cw[56], sw[57], sw[71], cw[71]);
	white w72 (a[12], b[4], cw[57], sw[58], sw[72], cw[72]);
	white w73 (a[13], b[4], cw[58], sw[59], sw[73], cw[73]);
	white w74 (a[14], b[4], cw[59], sg[3], sw[74], cw[74]);
	carry_adder w75 (a[0], b[5], cw[60], sw[61], cw[75]);
	white w76 (a[1], b[5], cw[61], sw[62], sw[76], cw[76]);
	white w77 (a[2], b[5], cw[62], sw[63], sw[77], cw[77]);
	white w78 (a[3], b[5], cw[63], sw[64], sw[78], cw[78]);
	white w79 (a[4], b[5], cw[64], sw[65], sw[79], cw[79]);
	white w80 (a[5], b[5], cw[65], sw[66], sw[80], cw[80]);
	white w81 (a[6], b[5], cw[66], sw[67], sw[81], cw[81]);
	white w82 (a[7], b[5], cw[67], sw[68], sw[82], cw[82]);
	white w83 (a[8], b[5], cw[68], sw[69], sw[83], cw[83]);
	white w84 (a[9], b[5], cw[69], sw[70], sw[84], cw[84]);
	white w85 (a[10], b[5], cw[70], sw[71], sw[85], cw[85]);
	white w86 (a[11], b[5], cw[71], sw[72], sw[86], cw[86]);
	white w87 (a[12], b[5], cw[72], sw[73], sw[87], cw[87]);
	white w88 (a[13], b[5], cw[73], sw[74], sw[88], cw[88]);
	white w89 (a[14], b[5], cw[74], sg[4], sw[89], cw[89]);
	carry_adder w90 (a[0], b[6], cw[75], sw[76], cw[90]);
	white w91 (a[1], b[6], cw[76], sw[77], sw[91], cw[91]);
	white w92 (a[2], b[6], cw[77], sw[78], sw[92], cw[92]);
	white w93 (a[3], b[6], cw[78], sw[79], sw[93], cw[93]);
	white w94 (a[4], b[6], cw[79], sw[80], sw[94], cw[94]);
	white w95 (a[5], b[6], cw[80], sw[81], sw[95], cw[95]);
	white w96 (a[6], b[6], cw[81], sw[82], sw[96], cw[96]);
	white w97 (a[7], b[6], cw[82], sw[83], sw[97], cw[97]);
	white w98 (a[8], b[6], cw[83], sw[84], sw[98], cw[98]);
	white w99 (a[9], b[6], cw[84], sw[85], sw[99], cw[99]);
	white w100 (a[10], b[6], cw[85], sw[86], sw[100], cw[100]);
	white w101 (a[11], b[6], cw[86], sw[87], sw[101], cw[101]);
	white w102 (a[12], b[6], cw[87], sw[88], sw[102], cw[102]);
	white w103 (a[13], b[6], cw[88], sw[89], sw[103], cw[103]);
	white w104 (a[14], b[6], cw[89], sg[5], sw[104], cw[104]);
	carry_adder w105 (a[0], b[7], cw[90], sw[91], cw[105]);
	white w106 (a[1], b[7], cw[91], sw[92], sw[106], cw[106]);
	white w107 (a[2], b[7], cw[92], sw[93], sw[107], cw[107]);
	white w108 (a[3], b[7], cw[93], sw[94], sw[108], cw[108]);
	white w109 (a[4], b[7], cw[94], sw[95], sw[109], cw[109]);
	white w110 (a[5], b[7], cw[95], sw[96], sw[110], cw[110]);
	white w111 (a[6], b[7], cw[96], sw[97], sw[111], cw[111]);
	white w112 (a[7], b[7], cw[97], sw[98], sw[112], cw[112]);
	white w113 (a[8], b[7], cw[98], sw[99], sw[113], cw[113]);
	white w114 (a[9], b[7], cw[99], sw[100], sw[114], cw[114]);
	white w115 (a[10], b[7], cw[100], sw[101], sw[115], cw[115]);
	white w116 (a[11], b[7], cw[101], sw[102], sw[116], cw[116]);
	white w117 (a[12], b[7], cw[102], sw[103], sw[117], cw[117]);
	white w118 (a[13], b[7], cw[103], sw[104], sw[118], cw[118]);
	white w119 (a[14], b[7], cw[104], sg[6], sw[119], cw[119]);
	carry_adder w120 (a[0], b[8], cw[105], sw[106], cw[120]);
	white w121 (a[1], b[8], cw[106], sw[107], sw[121], cw[121]);
	white w122 (a[2], b[8], cw[107], sw[108], sw[122], cw[122]);
	white w123 (a[3], b[8], cw[108], sw[109], sw[123], cw[123]);
	white w124 (a[4], b[8], cw[109], sw[110], sw[124], cw[124]);
	white w125 (a[5], b[8], cw[110], sw[111], sw[125], cw[125]);
	white w126 (a[6], b[8], cw[111], sw[112], sw[126], cw[126]);
	white w127 (a[7], b[8], cw[112], sw[113], sw[127], cw[127]);
	white w128 (a[8], b[8], cw[113], sw[114], sw[128], cw[128]);
	white w129 (a[9], b[8], cw[114], sw[115], sw[129], cw[129]);
	white w130 (a[10], b[8], cw[115], sw[116], sw[130], cw[130]);
	white w131 (a[11], b[8], cw[116], sw[117], sw[131], cw[131]);
	white w132 (a[12], b[8], cw[117], sw[118], sw[132], cw[132]);
	white w133 (a[13], b[8], cw[118], sw[119], sw[133], cw[133]);
	white w134 (a[14], b[8], cw[119], sg[7], sw[134], cw[134]);
	carry_adder w135 (a[0], b[9], cw[120], sw[121], cw[135]);
	white w136 (a[1], b[9], cw[121], sw[122], sw[136], cw[136]);
	white w137 (a[2], b[9], cw[122], sw[123], sw[137], cw[137]);
	white w138 (a[3], b[9], cw[123], sw[124], sw[138], cw[138]);
	white w139 (a[4], b[9], cw[124], sw[125], sw[139], cw[139]);
	white w140 (a[5], b[9], cw[125], sw[126], sw[140], cw[140]);
	white w141 (a[6], b[9], cw[126], sw[127], sw[141], cw[141]);
	white w142 (a[7], b[9], cw[127], sw[128], sw[142], cw[142]);
	white w143 (a[8], b[9], cw[128], sw[129], sw[143], cw[143]);
	white w144 (a[9], b[9], cw[129], sw[130], sw[144], cw[144]);
	white w145 (a[10], b[9], cw[130], sw[131], sw[145], cw[145]);
	white w146 (a[11], b[9], cw[131], sw[132], sw[146], cw[146]);
	white w147 (a[12], b[9], cw[132], sw[133], sw[147], cw[147]);
	white w148 (a[13], b[9], cw[133], sw[134], sw[148], cw[148]);
	white w149 (a[14], b[9], cw[134], sg[8], sw[149], cw[149]);
	carry_adder w150 (a[0], b[10], cw[135], sw[136], cw[150]);
	white w151 (a[1], b[10], cw[136], sw[137], sw[151], cw[151]);
	white w152 (a[2], b[10], cw[137], sw[138], sw[152], cw[152]);
	white w153 (a[3], b[10], cw[138], sw[139], sw[153], cw[153]);
	white w154 (a[4], b[10], cw[139], sw[140], sw[154], cw[154]);
	white w155 (a[5], b[10], cw[140], sw[141], sw[155], cw[155]);
	white w156 (a[6], b[10], cw[141], sw[142], sw[156], cw[156]);
	white w157 (a[7], b[10], cw[142], sw[143], sw[157], cw[157]);
	white w158 (a[8], b[10], cw[143], sw[144], sw[158], cw[158]);
	white w159 (a[9], b[10], cw[144], sw[145], sw[159], cw[159]);
	white w160 (a[10], b[10], cw[145], sw[146], sw[160], cw[160]);
	white w161 (a[11], b[10], cw[146], sw[147], sw[161], cw[161]);
	white w162 (a[12], b[10], cw[147], sw[148], sw[162], cw[162]);
	white w163 (a[13], b[10], cw[148], sw[149], sw[163], cw[163]);
	white w164 (a[14], b[10], cw[149], sg[9], sw[164], cw[164]);
	carry_adder w165 (a[0], b[11], cw[150], sw[151], cw[165]);
	white w166 (a[1], b[11], cw[151], sw[152], sw[166], cw[166]);
	white w167 (a[2], b[11], cw[152], sw[153], sw[167], cw[167]);
	white w168 (a[3], b[11], cw[153], sw[154], sw[168], cw[168]);
	white w169 (a[4], b[11], cw[154], sw[155], sw[169], cw[169]);
	white w170 (a[5], b[11], cw[155], sw[156], sw[170], cw[170]);
	white w171 (a[6], b[11], cw[156], sw[157], sw[171], cw[171]);
	white w172 (a[7], b[11], cw[157], sw[158], sw[172], cw[172]);
	white w173 (a[8], b[11], cw[158], sw[159], sw[173], cw[173]);
	white w174 (a[9], b[11], cw[159], sw[160], sw[174], cw[174]);
	white w175 (a[10], b[11], cw[160], sw[161], sw[175], cw[175]);
	white w176 (a[11], b[11], cw[161], sw[162], sw[176], cw[176]);
	white w177 (a[12], b[11], cw[162], sw[163], sw[177], cw[177]);
	white w178 (a[13], b[11], cw[163], sw[164], sw[178], cw[178]);
	white w179 (a[14], b[11], cw[164], sg[10], sw[179], cw[179]);
	white w180 (a[0], b[12], cw[165], sw[166], sw[180], cw[180]);
	white w181 (a[1], b[12], cw[166], sw[167], sw[181], cw[181]);
	white w182 (a[2], b[12], cw[167], sw[168], sw[182], cw[182]);
	white w183 (a[3], b[12], cw[168], sw[169], sw[183], cw[183]);
	white w184 (a[4], b[12], cw[169], sw[170], sw[184], cw[184]);
	white w185 (a[5], b[12], cw[170], sw[171], sw[185], cw[185]);
	white w186 (a[6], b[12], cw[171], sw[172], sw[186], cw[186]);
	white w187 (a[7], b[12], cw[172], sw[173], sw[187], cw[187]);
	white w188 (a[8], b[12], cw[173], sw[174], sw[188], cw[188]);
	white w189 (a[9], b[12], cw[174], sw[175], sw[189], cw[189]);
	white w190 (a[10], b[12], cw[175], sw[176], sw[190], cw[190]);
	white w191 (a[11], b[12], cw[176], sw[177], sw[191], cw[191]);
	white w192 (a[12], b[12], cw[177], sw[178], sw[192], cw[192]);
	white w193 (a[13], b[12], cw[178], sw[179], sw[193], cw[193]);
	white w194 (a[14], b[12], cw[179], sg[11], sw[194], cw[194]);
	white w195 (a[0], b[13], cw[180], sw[181], sw[195], cw[195]);
	white w196 (a[1], b[13], cw[181], sw[182], sw[196], cw[196]);
	white w197 (a[2], b[13], cw[182], sw[183], sw[197], cw[197]);
	white w198 (a[3], b[13], cw[183], sw[184], sw[198], cw[198]);
	white w199 (a[4], b[13], cw[184], sw[185], sw[199], cw[199]);
	white w200 (a[5], b[13], cw[185], sw[186], sw[200], cw[200]);
	white w201 (a[6], b[13], cw[186], sw[187], sw[201], cw[201]);
	white w202 (a[7], b[13], cw[187], sw[188], sw[202], cw[202]);
	white w203 (a[8], b[13], cw[188], sw[189], sw[203], cw[203]);
	white w204 (a[9], b[13], cw[189], sw[190], sw[204], cw[204]);
	white w205 (a[10], b[13], cw[190], sw[191], sw[205], cw[205]);
	white w206 (a[11], b[13], cw[191], sw[192], sw[206], cw[206]);
	white w207 (a[12], b[13], cw[192], sw[193], sw[207], cw[207]);
	white w208 (a[13], b[13], cw[193], sw[194], sw[208], cw[208]);
	sum_adder_white w209 (a[14], b[13], cw[194], sg[12], sw[209]);
	white w210 (a[0], b[14], cw[195], sw[196], sw[210], cw[210]);
	white w211 (a[1], b[14], cw[196], sw[197], sw[211], cw[211]);
	white w212 (a[2], b[14], cw[197], sw[198], sw[212], cw[212]);
	white w213 (a[3], b[14], cw[198], sw[199], sw[213], cw[213]);
	white w214 (a[4], b[14], cw[199], sw[200], sw[214], cw[214]);
	white w215 (a[5], b[14], cw[200], sw[201], sw[215], cw[215]);
	white w216 (a[6], b[14], cw[201], sw[202], sw[216], cw[216]);
	white w217 (a[7], b[14], cw[202], sw[203], sw[217], cw[217]);
	white w218 (a[8], b[14], cw[203], sw[204], sw[218], cw[218]);
	white w219 (a[9], b[14], cw[204], sw[205], sw[219], cw[219]);
	white w220 (a[10], b[14], cw[205], sw[206], sw[220], cw[220]);
	white w221 (a[11], b[14], cw[206], sw[207], sw[221], cw[221]);
	white w222 (a[12], b[14], cw[207], sw[208], sw[222], cw[222]);
	sum_adder_white w223 (a[13], b[14], cw[208], sw[209], sw[223]);
	// white w224 (a[14], b[14], cw[209], sg[13], sw[224], cw[224]);

	gray g0 (a[15], b[0], 0, 0, sg[0], cg[0]);
	gray g1 (a[15], b[1], 0, cg[0], sg[1], cg[1]);
	gray g2 (a[15], b[2], 0, cg[1], sg[2], cg[2]);
	gray g3 (a[15], b[3], 0, cg[2], sg[3], cg[3]);
	gray g4 (a[15], b[4], 0, cg[3], sg[4], cg[4]);
	gray g5 (a[15], b[5], 0, cg[4], sg[5], cg[5]);
	gray g6 (a[15], b[6], 0, cg[5], sg[6], cg[6]);
	gray g7 (a[15], b[7], 0, cg[6], sg[7], cg[7]);
	gray g8 (a[15], b[8], 0, cg[7], sg[8], cg[8]);
	gray g9 (a[15], b[9], 0, cg[8], sg[9], cg[9]);
	gray g10 (a[15], b[10], 0, cg[9], sg[10], cg[10]);
	gray g11 (a[15], b[11], 0, cg[10], sg[11], cg[11]);
	sum_adder_gray g12 (a[15], b[12], 0, cg[11], sg[12]);
	// gray g13 (a[15], b[13], 0, cg[12], sg[13], cg[13]);
	// gray g14 (a[15], b[14], 0, cg[13], sg[14], cg[14]);
	gray g15 (a[0], b[15], cw[210], sw[211], sg[15], cg[15]);
	gray g16 (a[1], b[15], cw[211], sw[212], sg[16], cg[16]);
	gray g17 (a[2], b[15], cw[212], sw[213], sg[17], cg[17]);
	gray g18 (a[3], b[15], cw[213], sw[214], sg[18], cg[18]);
	gray g19 (a[4], b[15], cw[214], sw[215], sg[19], cg[19]);
	gray g20 (a[5], b[15], cw[215], sw[216], sg[20], cg[20]);
	gray g21 (a[6], b[15], cw[216], sw[217], sg[21], cg[21]);
	gray g22 (a[7], b[15], cw[217], sw[218], sg[22], cg[22]);
	gray g23 (a[8], b[15], cw[218], sw[219], sg[23], cg[23]);
	gray g24 (a[9], b[15], cw[219], sw[220], sg[24], cg[24]);
	gray g25 (a[10], b[15], cw[220], sw[221], sg[25], cg[25]);
	gray g26 (a[11], b[15], cw[221], sw[222], sg[26], cg[26]);
	sum_adder_gray g27 (a[12], b[15], cw[222], sw[223], sg[27]);
	// gray g28 (a[13], b[15], cw[223], sw[224], sg[28], cg[28]);
	// gray g29 (a[14], b[15], cw[224], sg[14], sg[29], cg[29]);

	// white w225 (a[15], b[15], 0, cg[14], sw[225], cw[225]);

	fa fa0 (1, cg[15], sg[16], fs[0], fc[0]);
	fa fa1 (fc[0], cg[16], sg[17], fs[1], fc[1]);
	fa fa2 (fc[1], cg[17], sg[18], fs[2], fc[2]);
	fa fa3 (fc[2], cg[18], sg[19], fs[3], fc[3]);
	fa fa4 (fc[3], cg[19], sg[20], fs[4], fc[4]);
	fa fa5 (fc[4], cg[20], sg[21], fs[5], fc[5]);
	fa fa6 (fc[5], cg[21], sg[22], fs[6], fc[6]);
	fa fa7 (fc[6], cg[22], sg[23], fs[7], fc[7]);
	fa fa8 (fc[7], cg[23], sg[24], fs[8], fc[8]);
	fa fa9 (fc[8], cg[24], sg[25], fs[9], fc[9]);
	fa fa10 (fc[9], cg[25], sg[26], fs[10], fc[10]);
	fa fa11 (fc[10], cg[26], sg[27], fs[11], fc[11]);
	// fa fa12 (fc[11], cg[27], sg[28], fs[12], fc[12]);
	// fa fa13 (fc[12], cg[28], sg[29], fs[13], fc[13]);
	// fa fa14 (fc[13], cg[29], sw[225], fs[14], fc[14]);
	// fa fa15 (1, cw[225], fc[14], fs[15], fc[15]);

	assign p = {fs[11], fs[10], fs[9], fs[8], fs[7], fs[6], fs[5], fs[4], fs[3], fs[2], fs[1], fs[0], sg[15], sw[210], sw[195], sw[180]};

endmodule