MAX = 99999999999999999999999
MIN = -99999999999999999999999

n = int(input())
ls = []
for i in range(n):
    inp = input().split()
    ls.append((int(inp[0]), int(inp[1]), int(inp[2])))

xMax, yMax, xMin, yMin = MAX, MAX, MIN, MIN
for tuplu in ls:
    if tuplu[0] != 0:
        if tuplu[0] > 0:
            xMax = min(xMax, -tuplu[2] / tuplu[0])
        else:
            xMin = max(-tuplu[2] / tuplu[0], xMin)
    else:
        if tuplu[1] > 0:
            yMax = min(yMax, -tuplu[2] / tuplu[1])
        else:
            yMin = max(-tuplu[2] / tuplu[1], yMin)
if xMin > xMax or yMin > yMax:
    print("VOID")
elif max(xMax, yMax) == MAX or min(xMin, yMin) == MIN:
    print("UNBOUNDED")
else:
    print("BOUNDED")
