# in order for a polygon to be convex:
# "descending" from the max Y point should only happen once.
# "ascending" from the min X point should only happen once.


n = int(input())
pozPunctMinX = 0
pozPunctMaxY = 0
puncte = []
inp = input().split()
x = int(inp[0])
y = int(inp[1])
puncte.append((x, y))
minX = x
maxY = y

for i in range(1, n):
    inp = input().split()
    x = int(inp[0])
    y = int(inp[1])
    puncte.append((x, y))
    if x < minX:
        minX = x
        pozPunctMinX = i
    
    if y > maxY:
        maxY = y
        pozPunctMaxY = i

# print(maxY, pozPunctMaxY)
desc = False
for i in range(pozPunctMinX + 1, n):
    if puncte[i][0] == puncte[i - 1][0]:
        print("NO")
        break
    if desc == False and puncte[i][0] < puncte[i - 1][0]:
        desc = True
    elif desc == True and puncte[i][0] > puncte[i - 1][0]:
        print("NO")
        break
else:
    if puncte[0][0] == puncte[n - 1][0] or (desc == True and puncte[0][0] > puncte[n - 1][0]):
        print("NO")
    else:
        if desc == False and puncte[0][0] < puncte[n - 1][0]:
            desc = True
        for i in range(1, pozPunctMinX):
            if puncte[i][0] == puncte[i - 1][0]:
                print("NO")
                break
            if desc == False and puncte[i][0] < puncte[i - 1][0]:
                desc = True
            elif desc == True and puncte[i][0] > puncte[i - 1][0]:
                print("NO")
                break
        else:
            print("YES")

desc = True
for i in range(pozPunctMaxY + 1, n):
    if puncte[i][1] == puncte[i - 1][1]:
        print("NO")
        break
    if desc == True and puncte[i][1] > puncte[i - 1][1]:
        desc = False
    elif desc == False and puncte[i][1] < puncte[i - 1][1]:
        # print(i, pozPunctMaxY)
        print("NO")
        break
else:
    if puncte[0][1] == puncte[n - 1][1] or (desc == False and puncte[0][1] < puncte[n - 1][1]):
        print("NO")
    else:
        if desc == True and puncte[0][1] > puncte[n - 1][1]:
            desc = False
        for i in range(1, pozPunctMaxY):
            if puncte[i][1] == puncte[i - 1][1]:
                print("NO")
                break
            if desc == True and puncte[i][1] > puncte[i - 1][1]:
                desc = False
            elif desc == False and puncte[i][1] < puncte[i - 1][1]:
                print("NO")
                break
        else:
            print("YES")