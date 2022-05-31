def det(x1, y1, x2, y2, x3, y3):
    return x2 * y3 + x1 * y2 + x3 * y1 - x2 * y1 - x3 * y2 - x1 * y3

n = int(input())
poligon = []
for i in range(n):
    inp = input().split()
    x, y = int(inp[0]), int(inp[1])
    poligon.append((x, y))

poligon.sort(key=lambda t: t[0])
stack = [poligon[0]]
stackCapacity = 1
stackLen = 1
for i in range (1, n):
    if stackLen == 1 or det(stack[stackLen - 2][0], stack[stackLen - 2][1], stack[stackLen - 1][0], stack[stackLen - 1][1], poligon[i][0], poligon[i][1]) > 0:
        # print(poligon[i])
        if stackCapacity == stackLen:
            stack.append(poligon[i])
            stackCapacity += 1
        else:
            stack[stackLen] = poligon[i]
        stackLen += 1
    else:
        while not (stackLen == 1 or det(stack[stackLen - 2][0], stack[stackLen - 2][1], stack[stackLen - 1][0], stack[stackLen - 1][1], poligon[i][0], poligon[i][1]) > 0):
            stackLen -= 1
        stack[stackLen] = poligon[i]
        stackLen += 1

stack2 = [poligon[n - 1]]
stackCapacity = 1
stackLen2 = 1
for i in range (n - 2, -1, -1):
    if stackLen2 == 1 or det(stack2[stackLen2 - 2][0], stack2[stackLen2 - 2][1], stack2[stackLen2 - 1][0], stack2[stackLen2 - 1][1], poligon[i][0], poligon[i][1]) > 0:
        if stackCapacity == stackLen2:
            stack2.append(poligon[i])
            stackCapacity += 1
        else:
            stack2[stackLen2] = poligon[i]
        stackLen2 += 1
    else:
        while not (stackLen2 == 1 or det(stack2[stackLen2 - 2][0], stack2[stackLen2 - 2][1], stack2[stackLen2 - 1][0], stack2[stackLen2 - 1][1], poligon[i][0], poligon[i][1]) > 0):
            stackLen2 -= 1
        stack2[stackLen2] = poligon[i]
        stackLen2 += 1

# print(stack, stackLen, stack2, stackLen2)
solution = stack[:stackLen]
solution.extend(stack2[1:stackLen2 - 1])
print(len(solution))
for s in solution:
    print(*s)