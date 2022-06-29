from traceback import print_tb
from numpy import dtype, sign
from fxpmath import Fxp
import numpy as np


x = 125.19856

h = np.array([['0x999', '0x999'], ['0x666', '0x666']])

z = Fxp(h, signed=True, dtype='S4.12')
y = np.array(z)
print(y)

for i in z:
    x = np.array(i)
    print(type(x))
# print(h.shape)


y = Fxp(x, signed=True, dtype='S8.8')
# print(y.info())
print(y.bin(frac_dot=True))
