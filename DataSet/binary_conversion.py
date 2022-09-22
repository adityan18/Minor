from traceback import print_tb
from numpy import dtype, sign
from fxpmath import Fxp
import numpy as np


x = 125.19856

h = np.array([["0xe8c9","0x0415","0xf12d","0x13bb","0xfb42","0xf512","0x0114","0xf619"]])

z = Fxp(h, signed=True, dtype='S4.12')
y = np.array(z)
print(y)
# e8c9,0415,f12d,13bb,fb42,f512,0114,f619,154d,ef8f,0aee,fe23,fc33,08c3,031a,f874,0557,feb1,ffe6,f64a,0d9b,f72e,029a,03e6,f9f3,07b1,fe28,fc9d,f83c,009c,0191,03c0,0299,fa50,06f4,f8d6,0aad,fb23,033a,f8cd,ff4d,ffeb,00ff,06d0,fbb7,0161,0334,00b2,01a0,f920,04b8,fff7,fd4d,0876,f146,06fd,0256,ff7f,fc89,0207,03fc,fa65,0500,feda,fd89,...
# 0001,0ff8,fffa,000b,000c,fffe,0004,fffe,0002,ffff,0000,0009,fffb,fffa,0005,0000
for i in z:
    x = np.array(i)
    print(type(x))
# print(h.shape)


y = Fxp(x, signed=True, dtype='S8.8')
# print(y.info())
print(y.bin(frac_dot=True))
