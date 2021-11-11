import re
t = re.compile('rat: [0-9]+[.]*[0-9]*')
se = input("type of array: ")
for p in range(1, 9):
    with open("output.txt") as f:
        text = f.readlines()
        s = 0
        for i in range(len(text)):
            #print(text[i][7:11])
            if text[i][7:11] == se:
                l = re.findall(t, text[i+p*2])
                #print(l[0][5:])
                s+= float(l[0][5:])
        print(p, s / 5)
