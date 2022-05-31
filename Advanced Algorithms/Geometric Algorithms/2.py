# f = open("roby.in", 'r')
# g = open("roby.out", 'w')
n = int(input())

line = input().split(" ")
firstX = x1 = int(line[0])
firstY = y1 =int(line[1])
line = input().split(" ")
x2 = int(line[0])
y2 = int(line[1])

right = 0
left = 0
straight = 0
for i in range(n - 2):
    line = input().split(" ")
    x3 = int(line[0])
    y3 = int(line[1])
    # P 1 Q 2 R 3
    det = x2 * y3 + x1 * y2 + x3 * y1 - x2 * y1 - x3 * y2 - x1 * y3
    if det == 0:
        straight += 1
    elif det < 0:
        right += 1
    else:
        left += 1
    x1, y1 = x2, y2
    x2, y2 = x3, y3

det = x2 * firstY + x1 * y2 + firstX * y1 - x2 * y1 - firstX * y2 - x1 * firstY
if det == 0:
    straight += 1
elif det < 0:
    right += 1
else:
    left += 1

print(f"{left} {right} {straight}")
# g.close()
# f.close()