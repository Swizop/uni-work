# import numpy
import random
import copy

from math import factorial, log2

popSize = int(input("population size="))
lowerBound = float(input("interval: left endpoint="))
upperBound = float(input("interval: right endpoint="))
a = float(input("a="))
b = float(input("b="))
c = float(input("c="))
precision = int(input("decimal precision="))
combineProbability = float(input("probability of recombining="))
if combineProbability < 0 or combineProbability > 1:
    print("Must be between 0 and 1")
    exit(0)
mutationProbability = float(input("mutation probability="))
if mutationProbability < 0 or mutationProbability > 1:
    print("Must be between 0 and 1")
    exit(0)
nrSteps = int(input("nr. of steps="))
g = open("out.txt", 'w')

# def f(x):
#     global a, b, c
#     return a * x * x + b * x + c
def sin_function(x):

    # Doing this instead of math.abs
    sym_fact = -1 if x < 0 else 1
    y = -x if x < 0 else x

    # convert input radians to [-PI, +PI]
    PI = 3.141592653589793
    pi_factor = int(y / PI)
    adj = pi_factor if pi_factor%2 == 0 else pi_factor + 1
    rad = y - PI*adj

    # Taylor expand, increase num_terms for more precision
    total = 0
    num_terms = 7
    f_sign = 1
    for i in range(1,2*num_terms+1,2):
        total += f_sign * pow(rad, i)/factorial(i)
        f_sign *= -1

    return total*sym_fact
    
def f(x):
    return sin_function(x) + 5

chromosomeLen = int(log2((upperBound - lowerBound) * (10 ** precision)))
multiplyFactor = (upperBound - lowerBound) / (2 ** chromosomeLen - 1)
chromosomes = [None] * popSize


g.write("Populatia initiala\n")
for i in range(popSize):
    chromosomes[i] = [random.randint(0, 2 ** chromosomeLen - 1)]
    x = multiplyFactor * chromosomes[i][0] + lowerBound
    # print(f"{chromosomes[i][0]} se transforma in {x} ; folosind mulFactor {multiplyFactor}")
    # print(multiplyFactor * chromosomes[i][0], chromosomes[i][0] * 1.9073504518036383e-06)
    show = "{0:b}".format(chromosomes[i][0])
    chromosomes[i].append(f(x))
    g.write(f"{i + 1}: {show.zfill(chromosomeLen)} x= {x} f= {chromosomes[i][1]}\n")


for step in range(nrSteps):
    totalSum = sum(c[1] for c in chromosomes)
    intervals = [0]
    maxF = chromosomes[0][1]
    maxChromIndex = 0

    for i in range(popSize):
        if step == 0:
            chromosomes[i].append(chromosomes[i][1] / totalSum)     # probabilitatea
        else:
            chromosomes[i][2] = chromosomes[i][1] / totalSum
        
        intervals.append(intervals[-1] + chromosomes[i][2])
        if chromosomes[i][1] > maxF:
            maxF = chromosomes[i][1]
            maxChromIndex = i
        
        if step == 0:
            g.write(f"cromozom    {i + 1}  probabilitate {chromosomes[i][2]}\n")
    intervals[-1] = 1       # altfel e 0.9999999

    if step == 0:
        g.write("\nIntervale probabilitati selectie\n")
        for x in intervals:
            g.write(f"{x} ")
        g.write("\n")

    newChromosomes = [copy.copy(chromosomes[maxChromIndex])]        # elitist
    if step > 0:
        g.write(f"{maxF}\n")

    for i in range(popSize - 1):
        # generate number and see which interval it's in
        x = random.random()
        j = 1
        while j < len(intervals) and x > intervals[j]:
            j += 1
        newChromosomes.append(copy.copy(chromosomes[j - 1]))
        if step == 0:
            g.write(f"generat={x} selectam cromozomul {j}\n")
    
    if step == 0:
        g.write('\nDupa selectie:\n')
        for i in range(len(newChromosomes)):
            show = "{0:b}".format(newChromosomes[i][0])
            x = multiplyFactor * newChromosomes[i][0] + lowerBound
            g.write(f"{i + 1}: {show.zfill(chromosomeLen)} x= {x} f= {newChromosomes[i][1]}\n")
        g.write(f'\nProbabilitatea de incrucisare {combineProbability}\n')

    participants = []
    for i in range(1, len(newChromosomes)):
        x = random.random()
        if x < combineProbability:
            participants.append(i)
        
        if step == 0:
            show = "{0:b}".format(newChromosomes[i][0])
            g.write(f"{i + 1}: {show.zfill(chromosomeLen)} u={x}")
            if x < combineProbability:
                g.write(f"<{combineProbability} participa")
            g.write('\n')
    
    if len(participants) % 2 != 0:
        participants.append(len(newChromosomes) - 1)
    i = 0
    while i < len(participants):
        x = "{0:b}".format(newChromosomes[participants[i]][0]).zfill(chromosomeLen)
        y = "{0:b}".format(newChromosomes[participants[i + 1]][0]).zfill(chromosomeLen)
        newX = x[:(chromosomeLen // 2)] + y[(chromosomeLen // 2):]
        newY = y[:(chromosomeLen // 2)] + x[(chromosomeLen // 2):]

        newChromosomes[participants[i]][0] = int(newX, base=2)
        newChromosomes[participants[i + 1]][0] = int(newY, base=2)

        val1 = int(newX, base=2) * multiplyFactor + lowerBound
        val2 = int(newY, base=2) * multiplyFactor + lowerBound

        newChromosomes[participants[i]][1] = f(val1)
        newChromosomes[participants[i + 1]][1] = f(val2)

        if step == 0:
            g.write(f"Recombinare crm {participants[i] + 1} cu crm {participants[i + 1] + 1}:\n{x} {y}\nRezultat: {newX}    {newY}\n")
        i += 2

    if step == 0:
        g.write("\nDupa recombinare:\n")
        for i in range(len(newChromosomes)):
            show = "{0:b}".format(newChromosomes[i][0])
            x = multiplyFactor * newChromosomes[i][0] + lowerBound
            g.write(f"{i + 1}: {show.zfill(chromosomeLen)} x= {x} f= {newChromosomes[i][1]}\n")
        g.write(f"\nProbabilitate de mutatie pentru fiecare gena {mutationProbability}\nAu fost modificati cromozomii:\n")

    

    # mutatia individuala
    for i in range(1, len(newChromosomes)):
        x = "{0:b}".format(newChromosomes[i][0]).zfill(chromosomeLen)
        newX = ''
        for bit in x:
            rand = random.random()
            if rand < mutationProbability:
                if bit == '0':
                    newX += '1'
                else:
                    newX += '0'
            else:
                newX += bit
        if x != newX:
            newX = int(newX, base=2)
            newChromosomes[i][0] = newX
            val1 = newX * multiplyFactor + lowerBound
            newChromosomes[i][1] = f(val1)
            # newChromosomes[i][2] = f(newChromosomes[i][1])
            if step == 0:
                g.write(f"{i + 1}\n")
        
    if step == 0:
        g.write("\nDupa mutatie:\n")
        for i in range(len(newChromosomes)):
            show = "{0:b}".format(newChromosomes[i][0])
            x = multiplyFactor * newChromosomes[i][0] + lowerBound
            g.write(f"{i + 1}: {show.zfill(chromosomeLen)} x= {x} f= {newChromosomes[i][1]}\n")

    if step == 0:
        g.write("\nEvolutia maximului:\n")
    chromosomes = newChromosomes