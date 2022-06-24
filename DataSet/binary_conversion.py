from numpy import dtype
from fxpmath import Fxp


x = 125.19856

y = Fxp(x, signed=True, dtype='S8.8')

print(y.bin(frac_dot=True))



