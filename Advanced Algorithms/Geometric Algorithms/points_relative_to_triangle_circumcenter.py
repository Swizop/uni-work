from math import sqrt

 
def centruCircumscris(A, B, C):
    D = 2 * (A[0] * (B[1] - C[1]) + B[0] * (C[1] - A[1]) + C[0] * (A[1] - B[1]))
    x = ((A[0] ** 2 + A[1] ** 2) * (B[1] - C[1]) + (B[0] ** 2 + B[1] ** 2) * (C[1] - A[1]) + (C[0] ** 2 + C[1] ** 2) * (A[1] - B[1])) / D
    y = ((A[0] ** 2 + A[1] ** 2) * (C[0] - B[0]) + (B[0] ** 2 + B[1] ** 2) * (A[0] - C[0]) + (C[0] ** 2 + C[1] ** 2) * (B[0] - A[0])) / D
    return (x, y)
    

if __name__ == '__main__':
    inp = input().split()
    A = (int(inp[0]), int(inp[1]))
    inp = input().split()
    B = (int(inp[0]), int(inp[1]))
    inp = input().split()
    C = (int(inp[0]), int(inp[1]))

    centru = centruCircumscris(A, B, C)
    # print(centru[0], centru[1])
    raza = sqrt( (centru[0] - A[0]) ** 2 + (centru[1] - A[1]) ** 2 )
    m = int(input())
    for i in range(m):
        inp = input().split()
        x, y = int(inp[0]), int(inp[1])
        distanta = sqrt( (centru[0] - x) ** 2 + (centru[1] - y) ** 2 )
        if abs(distanta - raza) < 0.00001:
            print("BOUNDARY")
        elif distanta > raza:
            print("OUTSIDE")
        else:
            print("INSIDE")
            #print(raza, distanta)

