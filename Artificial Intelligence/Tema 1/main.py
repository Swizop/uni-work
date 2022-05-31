import sys
import os
import copy
from queue import Queue
from queue import PriorityQueue

import stopit

E = '>'
S = 'v'
W = '<'
N = '^'
class InputFileError(Exception):
    pass


class Human():
    def __init__(self, xStart, yStart, xEnd, yEnd) -> None:
        self.xStart = xStart
        self.yStart = yStart
        self.xEnd = xEnd
        self.yEnd = yEnd

        self.xCurr = xStart
        self.yCurr = yStart
        self.successor = None
        
        if xStart == xEnd:
            if yStart < yEnd:
                self.direction = E
            else:
                self.direction = W
        else:
            if xStart < xEnd:
                self.direction = S
            else:
                self.direction = N


    def checkCorrectInput(self, harta):
        
        if self.xStart == self.xEnd and self.yStart == self.yEnd or (self.xStart != self.xEnd and self.yStart != self.yEnd):
            raise InputFileError
        
        if self.direction == E:
            for i in range(self.yStart, self.yEnd + 1):
                if harta[self.xStart][i] == '#':
                    raise InputFileError
        
        elif self.direction == W:
            for i in range(self.yStart, self.yEnd - 1, -1):
                if harta[self.xStart][i] == '#':
                    raise InputFileError
        
        elif self.direction == S:
            for i in range(self.xStart, self.xEnd + 1):
                if harta[i][self.yStart] == '#':
                    raise InputFileError
        
        else:
            for i in range(self.xStart, self.xEnd - 1, -1):
                if harta[i][self.yStart] == '#':
                    raise InputFileError


    def getSuccessor(self):
        if self.successor == None:
            if self.direction == N:
                if self.xCurr == self.xEnd:
                    self.successor = Human(self.xEnd, self.yEnd, self.xStart, self.yStart)
                else:
                    self.successor = Human(self.xStart, self.yStart, self.xEnd, self.yEnd)
                    self.successor.xCurr = self.xCurr - 1
                    self.successor.yCurr = self.yCurr

            elif self.direction == E:
                if self.yCurr == self.yEnd:
                    self.successor = Human(self.xEnd, self.yEnd, self.xStart, self.yStart)
                else:
                    self.successor = Human(self.xStart, self.yStart, self.xEnd, self.yEnd)
                    self.successor.xCurr = self.xCurr
                    self.successor.yCurr = self.yCurr + 1
            
            elif self.direction == W:
                if self.yCurr == self.yEnd:
                    self.successor = Human(self.xEnd, self.yEnd, self.xStart, self.yStart)
                else:
                    self.successor = Human(self.xStart, self.yStart, self.xEnd, self.yEnd)
                    self.successor.xCurr = self.xCurr
                    self.successor.yCurr = self.yCurr - 1

            else:
                if self.xCurr == self.xEnd:
                    self.successor = Human(self.xEnd, self.yEnd, self.xStart, self.yStart)
                else:
                    self.successor = Human(self.xStart, self.yStart, self.xEnd, self.yEnd)
                    self.successor.xCurr = self.xCurr + 1
                    self.successor.yCurr = self.yCurr
        return self.successor

        
class Node():
    hartaMain = None        # harta fara oameni si fara nava
    def __init__(self, nava, capturati, oameni, d, cost = 0, father = None) -> None:
        self.nava = nava    # tuplu: (xnava, ynava)
        self.capturati = capturati
        self.oameni = oameni

        self.actualMap = copy.deepcopy(Node.hartaMain)
        self.actualMap[self.nava[0]][self.nava[1]] = '@'
        for o in self.oameni:
            if type(self.actualMap[o.xCurr][o.yCurr]) != int:
                if self.actualMap[o.xCurr][o.yCurr] not in (N, S, E, W):
                    self.actualMap[o.xCurr][o.yCurr] = o.direction
                else:
                    self.actualMap[o.xCurr][o.yCurr] = 2
            else:
                self.actualMap[o.xCurr][o.yCurr] += 1
        
        self.visitedDict = copy.deepcopy(d)
        self.visitedDict[nava] = 1
        self.father = father
        self.cost = cost
        self.heuristic = None

    def __repr__(self) -> str:
        retVal = ''
        for l in self.actualMap:
            for x in l:
                if type(x) == int:
                    retVal += 'o'
                else:
                    retVal += x
            retVal += '\n'
        return retVal
    
    def __lt__(self, other):
        return self.cost < other.cost

    def isSeen(self):
        """
        Check if UFO can be seen by someone in current node
        """

        # look to the east of the ship. if someone there is looking west, then UFO is seen
        # otherwise, stop the search at the first obstacle in that direction

        for k in range(self.nava[1] + 1, len(self.actualMap[0])):
            if self.actualMap[self.nava[0]][k] == W:
                return True
            elif self.actualMap[self.nava[0]][k] != '.':
                break
        
        for k in range(self.nava[1] - 1, -1, -1):
            if self.actualMap[self.nava[0]][k] == E:
                return True
            elif self.actualMap[self.nava[0]][k] != '.':
                break

        for k in range(self.nava[0] - 1, -1, -1):
            if self.actualMap[k][self.nava[1]] == S:
                return True
            elif self.actualMap[k][self.nava[1]] != '.':
                break
        
        for k in range(self.nava[0] + 1, len(self.actualMap)):
            if self.actualMap[k][self.nava[1]] == N:
                return True
            elif self.actualMap[k][self.nava[1]] != '.':
                break
        return False


    def getSuccessors(self):
        ret = []
        # move UFO north, south, west, east
        newShips = [(self.nava[0] - 1, self.nava[1]), (self.nava[0] + 1, self.nava[1]),\
             (self.nava[0], self.nava[1] - 1), (self.nava[0], self.nava[1] + 1)]
        for i in range(4):
            if newShips[i] not in self.visitedDict and 0 <= newShips[i][0] < len(self.actualMap)\
                and 0 <= newShips[i][1] < len(self.actualMap[0]):
                newPeople = []
                for o in self.oameni:
                    nO = o.getSuccessor()
                    if nO.xCurr != newShips[i][0] or nO.yCurr != newShips[i][1]:
                        newPeople.append(nO)
                
                addedCost = len(self.oameni)
                if self.actualMap[newShips[i][0]][newShips[i][1]] == '#':
                    addedCost *= 2
                    
                newNode = Node(newShips[i], self.capturati + len(self.oameni) - len(newPeople), newPeople,\
                    self.visitedDict, self.cost + 1 + addedCost, self)
                if not newNode.isSeen():
                    ret.append(newNode)
        return ret

    def showPath(self, output, nrOrd):
        if self.father == None:
            output.write("__________________\nDRUM SOLUTIE:\n")
            nrOrd[0] += 1
            output.write(f"Nod {nrOrd[0]}\n")
            output.write(str(self))
            output.write(f"COST MUTARI: {self.cost}  NR. CAPTURED: {self.capturati}\n\n")
        else:
            self.father.showPath(output, nrOrd)
            nrOrd[0] += 1
            output.write(f"Nod {nrOrd[0]}\n")
            output.write(str(self))
            output.write(f"COST MUTARI: {self.cost}  NR. CAPTURED: {self.capturati}\n\n")

    def showUFOHistory(self, output):
        goneThrough = copy.deepcopy(Node.hartaMain)
        for k in self.visitedDict.keys():
            goneThrough[k[0]][k[1]] = '@'
        for l in goneThrough:
            for x in l:
                output.write(x)
            output.write('\n')
        output.write('\n\n')


class Graph():
    def __init__(self, f) -> None:
        f = f.readlines()
        pozNava = f[0].split()
        pozNava = (int(pozNava[0]), int(pozNava[1]))
        self.deRapit = int(f[1].split()[0])

        i = 2
        harta = []
        while f[i] != 'oameni\n':
            harta.append(list(f[i][:-1]))         # pana la poz -1 ca sa evitam /n-ul
            i += 1
        i += 1

        self.hartaMain = harta
        oameni = []
        while i < len(f):
            om = f[i].split()
            oameni.append(Human(int(om[0]), int(om[1]), int(om[2]), int(om[3])))
            i += 1

        Node.hartaMain = self.hartaMain
        self.root = Node(pozNava, 0, oameni, dict())
        if self.root.isSeen():
            raise InputFileError

    def test_scope(self, nod):
        if self.deRapit > nod.capturati:
            return False
        return True

    # def get_heuristic(self, node):
    #     """
    #         euristica banala: cati oameni mai sunt de rapit
    #     """
    #     if node.heuristic == None:
    #         node.heuristic = self.deRapit - node.capturati
    #     return node.heuristic

    # def get_heuristic(self, node):
    #     """
    #         euristica neadmisibila: distanta manhattan pana la un om random 
    #         se presupune ca drumul va trece prin casute goale, deci euristica va fi
    #         (1 + nr_oameni_harta) * manhattan
    #     """
    #     if node.heuristic == None:
    #         node.heuristic = (1 + len(node.oameni)) * (abs(node.oameni[0].xCurr - node.nava[0]) + abs(node.oameni[0].yCurr - node.nava[1]))
    #     return node.heuristic

    def get_heuristic(self, node):
        """
            distanta manhattan pana la al k-lea cel mai departat om
        """
        if node.heuristic == None:
            node.heuristic = self.deRapit - node.capturati
            if node.heuristic > 0:
                node.oameni.sort(key=lambda o: abs(o.xCurr - node.nava[0]) + abs(o.yCurr - node.nava[1]))
                node.heuristic = (1 + len(node.oameni)) * (abs(node.oameni[node.heuristic - 1].xCurr - node.nava[0]) + abs(node.oameni[node.heuristic - 1].yCurr - node.nava[1]))
        return node.heuristic

    # def get_heuristic(self, node):
    #     """
    #         cea mai mica distanta pana la o coloana / linie pe care se plimba un om
    #     """
    #     if node.heuristic == None:
    #         if len(node.oameni) == 0:
    #             node.heuristic = 0
    #         else:
    #             node.heuristic = len(self.hartaMain)
    #             for o in node.oameni:
    #                 if o.direction in (E, W):
    #                     node.heuristic = min(node.heuristic, abs(o.xCurr - node.nava[0]))
    #                 else:
    #                     node.heuristic = min(node.heuristic, abs(o.yCurr - node.nava[1]))
    #     return node.heuristic


def solve(f, output, nrSol, maxTime):
    @stopit.threading_timeoutable(default="Function timed out")
    def bf(g : Graph, nrSol, output):
        q = Queue()
        q.put(g.root)
        while not q.empty():
            curr = q.get()
            if g.test_scope(curr):
                nrSol -= 1
                curr.showPath(output, [0])
                curr.showUFOHistory(output)
                if nrSol == 0:
                    return True
            else:
                li = curr.getSuccessors()
                for x in li:
                    q.put(x)
        return False

    @stopit.threading_timeoutable(default="Function timed out")
    def df(g : Graph, nrSol, output, curr):
        if g.test_scope(curr):
            nrSol[0] -= 1
            curr.showPath(output, [0])
            curr.showUFOHistory(output)

        else:
            li = curr.getSuccessors()
            for x in li:
                if nrSol[0] > 0:
                    df(g, nrSol, output, x)

    @stopit.threading_timeoutable(default="Function timed out")
    def astar(g : Graph, nrSol, output):
        pq = PriorityQueue()
        pq.put((g.get_heuristic(g.root), g.root))
        while not pq.empty():
            curr = pq.get()[1]
            if g.test_scope(curr):
                nrSol -= 1
                curr.showPath(output, [0])
                curr.showUFOHistory(output)
                if nrSol == 0:
                    return True
            else:
                li = curr.getSuccessors()
                for x in li:
                    pq.put((x.cost + g.get_heuristic(x), x))
        return False
    
    try:
        g = Graph(f)
        
        for o in g.root.oameni:
            o.checkCorrectInput(g.hartaMain)

        # # BFS CALL
        # ret = bf(g, nrSol, output, timeout=maxTime)
        # if ret == False:
        #     output.write('Nu exista destule solutii')
        # elif ret != True:
        #     output.write(ret)

        # # DFS CALL
        # nrSol = [nrSol]
        # ret = df(g, nrSol, output, g.root, timeout=maxTime)
        # if ret != None:
        #     output.write(ret)
        # elif nrSol[0] > 0:
        #     output.write('Nu sunt destule solutii')
        # output.close()

        # ASTAR CALL
        ret = astar(g, nrSol, output, timeout=maxTime)
        if ret == False:
            output.write('Nu exista destule solutii')
        elif ret != True:
            output.write(ret)


        # print(g.root)
        # print()
        
        # li = g.root.getSuccessors()
        # for x in li:
        #     print(x)
        #     print()

    except InputFileError:
        output.write("Input file doesn't meet requirements")
        return


def main():
    if len(sys.argv) != 5:
        print("Call method: python main.py {input folder} {output folder} {nr of solutions_wanted} {timeout}")
        return
    files = os.listdir(sys.argv[1])
    for fi in files:
        f = open(sys.argv[1] + '/' + fi, 'r')
        i = 1
        while i < len(fi) and fi[i] != '.':
            i += 1

        g = open(sys.argv[2] + '/' + fi[:i] + '.out', 'w')
        nrSolutions = int(sys.argv[3])
        maxTime = int(sys.argv[4])
        # print(fi)
        solve(f, g, nrSolutions, maxTime)
        # print()


if __name__ == '__main__':
    main()