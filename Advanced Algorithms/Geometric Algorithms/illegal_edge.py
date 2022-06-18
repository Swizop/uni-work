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
    inp = input().split()
    D = (int(inp[0]), int(inp[1]))
    # print(A, B, C, D)
    centru = centruCircumscris(A, B, C)
    raza = sqrt( (centru[0] - A[0]) ** 2 + (centru[1] - A[1]) ** 2 )
    
    distanta = sqrt( (centru[0] - D[0]) ** 2 + (centru[1] - D[1]) ** 2 )
    # print("AC: ", end="")
    if abs(distanta - raza) < 0.0001:
        print("AC: LEGAL\nBD: LEGAL")
    elif distanta < raza:
        print("AC: ILLEGAL\nBD: LEGAL")
    else:
        print("AC: LEGAL\nBD: ILLEGAL")
# AC: ILLEGAL
# BD: LEGAL