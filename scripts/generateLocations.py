#!/bin/python

x = 37.3321116
y = -122.0307625
for i in range(0, 5):
  for j in range(0, 5):
    di = i/10000
    dj = j/10000
    print(str(x+di) + ", " + str(y+dj))
    print(str(x-di) + ", " + str(y-dj))
