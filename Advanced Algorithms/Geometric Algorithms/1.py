t = int(input())
for i in range(t):
    l = input().split(" ")
    xP = int(l[0])
    yP = int(l[1])
    xQ = int(l[2])
    yQ = int(l[3])
    xR = int(l[4])
    yR = int(l[5])
    det = xQ * yR + xP * yQ + xR * yP - xQ * yP - xR * yQ - xP * yR
    if det == 0:
        print("TOUCH")
    elif det < 0:
        print("RIGHT")
    else:
        print("LEFT")