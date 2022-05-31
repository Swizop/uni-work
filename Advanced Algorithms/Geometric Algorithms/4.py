n = int(input(""))
readPoligon = []
for i in range(n):
    inp = input("").split()
    readPoligon.append((int(inp[0]), int(inp[1])))

poligon = []
minX = readPoligon[0][0]
minY = readPoligon[0][1]
minPos = 0
for i in range(n):
    if readPoligon[i][0] < minX or (readPoligon[i][0] == minX and readPoligon[i][1] > minY):
        minX = readPoligon[i][0]
        minY = readPoligon[i][1]
        minPos = i

for i in range(minPos, len(readPoligon)):
    poligon.append(readPoligon[i])

for i in range(0, minPos):
    poligon.append(readPoligon[i])

# print(poligon)
n = int(input(""))

for i in range(n):
    inp = input("").split()
    x, y = int(inp[0]), int(inp[1])

    s, d = 0, len(poligon) - 1
    while s <= d:
        m = (s + d) // 2
        # x2 * y3 + x1 * y2 + x3 * y1 - x2 * y1 - x3 * y2 - x1 * y3
        det = poligon[m][0] * y + poligon[0][0] * poligon[m][1] + x * poligon[0][1] - poligon[m][0] * poligon[0][1] - x * poligon[m][1] - poligon[0][0] * y
        if det == 0:
            d = m
            break
        elif det < 0:
            d = m - 1
        else:
            s = m + 1
    
    if d == 0 or d == len(poligon) - 1:
        print("OUTSIDE")
    elif poligon[d][0] * y + poligon[d - 1][0] * poligon[d][1] + x * poligon[d - 1][1] - poligon[d][0] * poligon[d - 1][1] - x * poligon[d][1] - poligon[d - 1][0] * y == 0:
        print("BOUNDARY")
    else:
        det = poligon[d + 1][0] * y + poligon[d][0] * poligon[d + 1][1] + x * poligon[d][1] - poligon[d + 1][0] * poligon[d][1] - x * poligon[d + 1][1] - poligon[d][0] * y
        if det == 0:
            print("BOUNDARY")
        elif det < 0:
            print("OUTSIDE")
        else:
            print("INSIDE")