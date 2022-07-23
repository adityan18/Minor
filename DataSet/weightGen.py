from lib2to3.pytree import convert
from traceback import print_tb
import numpy as np
from numpy import dtype, sign
from fxpmath import Fxp


# y = np.array([16, 15, 18, 15])

# y_cap = np.array([0.0, 0.0, 0.0, 0.0])

file = open('sim_1\\new\\mem2.mem', 'r+')
# x = file.readlines()
# print(x)

# size_ = len(file.readlines()) - 1
# print(size_)


def convert(lst):
    for i, ele in enumerate(lst):
        lst[i] = '0x' + ele
    return lst


y = np.zeros((0, 9), dtype=float)
# y_cap = np.empty((0, 9), dtype=float)
y_cap = [0]*10
dps = []

for i, line in enumerate(file):
    lst = line[:-1].split(' ')
    lst = convert(lst)
    lst = Fxp(lst, signed=True, dtype='S4.12')
    lst = np.array(lst)
    # print(lst)
    # print(lst)
    if i == 0:
        wt = np.empty((0, len(line[:-1].split(' '))))
        wt = np.append(wt, lst)
        # wt = np.array(wt)
        # print(wt)
    else:
        y = np.append(y, lst[0])
        # print(lst[1:])
        dps.append(lst[1:])

# print(y)
dps = np.array(dps)
# print(dps)
y = np.array(y)
# print(y)


# print(wt)
# print(wt.shape)
# print(dps.shape)
# print(y.shape)
# print(y_cap.shape)


for i in range(1, 26):
    # print(f"-------------epoch{i}-----------")
    for j in range(10):
        prod = wt[1:]*dps[j]
        # print("\nProducts0123: ", wt[1:]*dps[j])
        # print("\nSum of product of errors")
        y_cap[j] = np.sum(prod, dtype=np.float32) + wt[0]
        # print("\ny_cap: \n", y_cap)
        wt[0] = wt[0] + (y[j] - y_cap[j]) / 4
        wt[1:] = wt[1:] + (y[j] - y_cap[j]) / 4 * dps[j]
    # print("\nwt: \n", wt)
    # print('#####')

# wt = Fxp(wt, signed=True, dtype='S4.12')
# print(wt)


wt2 = np.array([['0xffff', '0x40f', '0xff75', '0x0512', '0x0073', '0x023c',
                 '0x0031', '0xfe83', '0xff48', '0x0aa3', '0xffbc', '0x065f']])

wt2 = np.array(Fxp(wt2, signed=True, dtype='S4.12'))

dps2 = np.array([['0x53d', '0x55e', '0x4cc', '0x150', '0x1ec', '0x240', '0x27c', '0x860', '0x850', '0x2ae', '0x46e'],
                 ['0x487', '0x42a', '0x4cc', '0x118', '0x1ae', '0x193',
                     '0xe7', '0x6d9', '0x72e', '0x234', '0x4ec'],
                 ['0x4f4', '0x4a8', '0x2e1', '0x118', '0x1d0', '0x2b4',
                  '0x1a3', '0x860', '0x70e', '0x27d', '0x17a'],
                 ['0x4f4', '0x4fc', '0x385', '0x150', '0x1bc', '0x27a',
                  '0x355', '0x7c9', '0x6ed', '0x1b9', '0x1f8'],
                 ['0x3ae', '0x40e', '0x3d7', '0x16c', '0x18c', '0xe6 ',
                  '0x1b2', '0x6f7', '0x76e', '0x16f', '0x276'],
                 ['0x4f4', '0x4fc', '0x385', '0x150', '0x1bc', '0x27a',
                  '0x355', '0x7c9', '0x6ed', '0x1b9', '0x1f8'],
                 ['0x487', '0x32d', '0xae1', '0xe0', '0xc27', '0x3d4',
                  '0x38f', '0x87e', '0x448', '0x963', '0x237'],
                 ['0x243', '0x596', '0x4f5', '0xe0', '0x207', '0x327',
                  '0x347', '0x806', '0x912', '0x468', '0x237'],
                 ['0x4d0', '0x24d', '0x87a', '0x1c0', '0x21c', '0x3d4',
                  '0x42f', '0x8d8', '0x7ef', '0x480', '0x2f4'],
                 ['0x4f4', '0x749', '0x851', '0x134', '0x2f0', '0x81c', '0x84f', '0x806', '0x5eb', '0x372', '0x237']])

dps2 = np.array(Fxp(dps2, signed=True, dtype='S4.12'))
# print(dps2)
# print(wt2)

# print(wt[0] + np.sum(wt[1:] * dps[0]))
# print(wt2[0][0] + np.sum(wt2[0][1:] * dps[0]))

print(f'Py Wt:{wt}')
print(f'Ver Wt:{wt2}')

for i in range(len(wt)):
    act = wt[0] + np.sum(wt[1:] * dps2[i])
    rec = wt2[0][0] + np.sum(wt2[0][1:] * dps2[i])
    print(f'Actual:{act}\tReceived:{rec}')
