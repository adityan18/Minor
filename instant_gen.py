
f = open('sources_1/new/bw_mul.v', 'w')
txt_header = '''
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
'''

bit = 16
module_def = f'''
module bw_mul(
    input signed [{bit-1}:0]a, // {bit} bit input
    input signed [{bit-1}:0]b, // {bit} bit input
    output signed [{bit*2-1}:0]p // {bit*2} bit product
);

    parameter bit = {bit};

    wire signed [(bit - 2)*2+1:0]sg; // sum out gray cell
    wire signed [(bit - 2)*2+1:0]cg; // carry out gray cell

    wire signed [(bit-1)*(bit-1)+1:0]sw; // sum out white cell
    wire signed [(bit-1)*(bit-1)+1:0]cw; // carry out white cell

    wire signed [bit - 1:0]fs; // full adder sum
    wire signed [bit - 1:0]fc; // full adder carry

'''
f.write(txt_header)
f.write(module_def)
count = bit - 1
wcount = 0
gcount = 0


# Layer 1 White
for i in range(bit - 1):
    f.write(f'\twhite w{i} (a[{i}], b[0], 0, 0, sw[{i}], cw[{i}]);\n')

print()
f.write('\n')

# Layer 2 to n-1 white
for i in range(1, bit - 1):
    for j in range(0, bit - 1):
        if j is not bit - 2:
            f.write(
                f'\twhite w{count} (a[{j}], b[{i}], cw[{wcount}], sw[{wcount+1}], sw[{count}], cw[{count}]);\n')
        else:
            f.write(
                f'\twhite w{count} (a[{j}], b[{i}], cw[{wcount}], sg[{gcount}], sw[{count}], cw[{count}]);\n')
            gcount += 1
        wcount += 1
        count = count + 1

# Layer 1 to n-1 gray
print()
f.write('\n')

f.write(f'\tgray g{0} (a[{bit - 1}], b[{0}], 0, 0, sg[{0}], cg[{0}]);\n')

for i in range(1, bit - 1):
    f.write(
        f'\tgray g{i} (a[{bit - 1}], b[{i}], 0, cg[{i-1}], sg[{i}], cg[{i}]);\n')


# Last Layer
gcount = bit - 1
count2 = (bit - 1) * (bit - 2)
for i in range(bit-1):
    if gcount is not (bit * 2 - 3):
        f.write(
            f'\tgray g{gcount} (a[{i}], b[{bit-1}], cw[{count2}], sw[{count2 + 1}], sg[{gcount}], cg[{gcount}]);\n')
    else:
        f.write(
            f'\tgray g{gcount} (a[{i}], b[{bit-1}], cw[{count2}], sg[{bit - 2}], sg[{gcount}], cg[{gcount}]);\n')

    count2 += 1
    gcount += 1
f.write('\n')


f.write(
    f'\twhite w{count} (a[{bit-1}], b[{bit-1}], 0, cg[{bit-2}], sw[{count}], cw[{count}]);\n')
f.write('\n')


# Adders
gcount = (bit-1)

f.write(f'\tfa fa{0} ({1}, cg[{gcount}], sg[{gcount+1}], fs[{0}], fc[{0}]);\n')
gcount += 1

for i in range(1, bit - 1):
    if i is not (bit - 2):
        f.write(
            f'\tfa fa{i} (fc[{i-1}], cg[{gcount}], sg[{gcount+1}], fs[{i}], fc[{i}]);\n')
    else:
        f.write(
            f'\tfa fa{i} (fc[{i-1}], cg[{gcount}], sw[{count}], fs[{i}], fc[{i}]);\n')
    gcount += 1

f.write(
    f'\tfa fa{bit-1} ({1}, cw[{count}], fc[{bit-2}], fs[{bit-1}], fc[{bit-1}]);\n')

print()

# Product
p = []
for i in range(bit-1, -1, -1):
    p.append(f'fs[{i}]')
p.append(f'sg[{bit-1}]')

for i in range((bit-1) * (bit-2), -1, -(bit-1)):
    p.append(f'sw[{i}]')
prod = '\tassign p = {'
for i in p:
    prod += i + ', '
prod = prod[:-2] + '};'
f.write('\n')
f.write(prod)
x = '\n\nendmodule'
f.write(x)
