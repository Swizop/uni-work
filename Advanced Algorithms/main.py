# generam numere in patratul cu centru in (0, 0) si varfurile in (-r, r), (r, r), etc
# facem raportul dintre nr care sunt in cercul cu raza r si numarul total. rapotul ala * 4 = pi
# buffon needle problem / arcul lui buffon

from math import sqrt
import random

r = 1
inCircle = 0
for i in range(10 ** 6):
    x = random.uniform(-r, r)
    y = random.uniform(-r, r)
    if sqrt(x ** 2 + y ** 2) <= r:
        inCircle += 1

print(inCircle / (10 ** 6) * 4)