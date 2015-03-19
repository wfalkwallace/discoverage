from __future__ import division

x = 37.3321116
y = -122.0307625
for i in range(0, 20, 2):
  for j in range(0, 30, 3):
    di = i/1000
    dj = j/1000
    print(str(x+di) + ", " + str(y+dj))
    print(str(x-di) + ", " + str(y-dj))
