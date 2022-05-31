import sys
import pygame
import time
import copy

BLACK = 1
WHITE = 2
COORDI = [-1, -1, -1, 0, 0, 1, 1, 1]
COORDJ = [-1, 0, 1, -1, 1, -1, 0, 1]
COORDI2 = [-2, -2, -2, 0, 0, 2, 2, 2]
COORDJ2 = [-2, 0, 2, -2, 2, -2, 0, 2]

def converteste(tabla, tupluMutare, player, changed = None):
    newTable = copy.deepcopy(tabla)
    newTable[tupluMutare[0]][tupluMutare[1]] = player
    # conquered = set()
    conq = 0
    if changed != None:
        newTable[changed[0]][changed[1]] = 0
    else:
        # conquered = set([(tupluMutare[0], tupluMutare[1])])
        conq += 1
    
    for i in COORDI:
        for j in COORDJ:
            if 0 <= tupluMutare[0] + i < 7 and 0 <= tupluMutare[1] + j < 7 and newTable[tupluMutare[0] + i][tupluMutare[1] + j] not in (player, 0):
                newTable[tupluMutare[0] + i][tupluMutare[1] + j] = player
                # conquered.add((tupluMutare[0] + i, tupluMutare[1] + j))
                conq += 1

    return (newTable, conq)


def stare_finala(tabla, nrBlack, nrWhite):
    if nrBlack == 0:
        return WHITE
    if nrWhite == 0:
        return BLACK
    if nrWhite + nrBlack == len(tabla) * len(tabla[0]):     # tabla e plina
        if nrBlack > nrWhite:
            return BLACK
        return WHITE
    return None


# def scor(nrBlack, nrWhite):
#     return nrBlack - nrWhite      # black e max player, white e min player

# SCOR ALTERNATIV:
def scor(tabla, nrBlack, nrWhite):
    castigator = stare_finala(tabla, nrBlack, nrWhite)
    if castigator == BLACK:
        return 1
    elif castigator == WHITE:
        return -1
    return 0


def correct_move(move, board, player):
    # move format: (where, type)

    if not (0 <= move[0][0] < 7 and 0 <= move[0][1] < 7 and board[move[0][0]][move[0][1]] == 0):
        return False
        
    if move[1] == 1:        # piesa noua pe tabla
        for i in COORDI:
            for j in COORDJ:
                if 0 <= move[0][0] + i < 7 and 0 <= move[0][1] + j < 7 and board[move[0][0] + i][move[0][1] + j] == player:
                    return True
        return False

    elif type(move[1]) == tuple:       # move[1] e un tuplu care simbolizeaza punctul vechi, eliberat
        if 0 <= move[1][0] < 7 and 0 <= move[1][1] < 7 and board[move[1][0]][move[1][1]] == player\
            and ((abs(move[1][0] - move[0][0]) == 2 and abs(move[1][1] - move[0][1]) in (0,2)) or\
                (abs(move[1][0] - move[0][0]) in (0, 2) and abs(move[1][1] - move[0][1]) == 2)):
            return True
    return False


class Joc():

    def __init__(self) -> None:
        self.mat = [[1, 0, 0, 0, 0, 0, 2]]
        for _ in range(5):
            self.mat.append([0, 0, 0, 0, 0, 0, 0])
        self.mat.append([2, 0, 0, 0, 0, 0, 1])

        self.nrBlack = 2
        self.nrWhite = 2
        # self.blackPos = set([(0, 0), (6, 6)])
        # self.whitePos = set([(0, 6), (6, 0)])
        self.currentPlayer = BLACK

    
    def stare_tabla(self):
        return self.mat

    def player(self):
        return self.currentPlayer

    # def schimbare(self, unde, tabla = None, jucator = None):
    #     if tabla == None:
    #         tabla = self.mat
    #     if jucator == None:
    #         jucator = self.currentPlayer


    def best_move(self, algo = False):
        def recursivitate(table, player, nrBlack, nrWhite, depth, maxDepth, prevScore = None, algoritm = False):
            winner = stare_finala(table, nrBlack, nrWhite)
            if winner != None or depth == maxDepth:
                # print(scor(nrBlack, nrWhite))
                return scor(nrBlack, nrWhite)
            # miscare = None
            if player == BLACK:
                valoare = -98
            else:
                valoare = 99

            for i in range(7):
                for j in range(7):
                    if correct_move(((i, j), 1), table, player) == True:
                        newTable, conquered = converteste(table, (i, j), player)
                        if player == BLACK:
                            val = recursivitate(newTable, WHITE, nrBlack + conquered, nrWhite - conquered + 1, depth + 1, maxDepth, valoare, algoritm)
                            if algoritm == True:
                                if val > prevScore:     # jucatorul de minim va alege oricum optiunea care a dat prevScore, deci putem sari peste
                                    return prevScore
                            if val > valoare:
                                valoare = val
                        else:
                            val = recursivitate(newTable, BLACK, nrBlack - conquered + 1, nrWhite + conquered, depth + 1, maxDepth, valoare, algoritm)
                            if algoritm == True:
                                if val < prevScore:
                                    return prevScore
                            if val < valoare:
                                valoare = val
                    
                    for x in COORDI2:
                        for y in COORDJ2:
                            if correct_move(((i + x, j + y), (i, j)), table, player) == True:
                                newTable, conquered = converteste(table, (i + x, j + y), player, (i, j))
                                if player == BLACK:
                                    val = recursivitate(newTable, WHITE, nrBlack + conquered, nrWhite - conquered, depth + 1, maxDepth, valoare, algoritm)
                                    if algoritm == True:
                                        if val > prevScore:
                                            return prevScore
                                    if val > valoare:
                                        valoare = val
                                else:
                                    val = recursivitate(newTable, BLACK, nrBlack - conquered, nrWhite + conquered, depth + 1, maxDepth, valoare, algoritm)
                                    if algoritm == True:
                                        if val < prevScore:
                                            return prevScore
                                    if val < valoare:
                                        valoare = val
            
            return valoare

        miscare = None
        if self.currentPlayer == BLACK:
            valoare = -100
        else:
            valoare = 100
        
        print("\n_______________________________\n")
        for i in range(7):
            for j in range(7):
                print(self.mat[i][j], end=" ")
                if correct_move(((i, j), 1), self.mat, self.currentPlayer) == True:
                    newTable, conquered = converteste(self.mat, (i, j), self.currentPlayer)
                    if self.currentPlayer == BLACK:
                        val = recursivitate(newTable, WHITE, self.nrBlack + conquered, self.nrWhite - conquered + 1, 0, self.maxDepth, valoare, algo)
                        if val > valoare:
                            miscare = (i, j)
                            valoare = val
                    else:
                        val = recursivitate(newTable, BLACK, self.nrBlack - conquered + 1, self.nrWhite + conquered, 0, self.maxDepth, valoare, algo)
                        if val < valoare:
                            miscare = (i, j)
                            valoare = val
                            
                for x in COORDI2:
                    for y in COORDJ2:
                        if correct_move(((i + x, j + y), (i, j)), self.mat, self.currentPlayer) == True:
                            newTable, conquered = converteste(self.mat, (i + x, j + y), self.currentPlayer, (i, j))
                            if self.currentPlayer == BLACK:
                                val = recursivitate(newTable, WHITE, self.nrBlack + conquered, self.nrWhite - conquered, 0, self.maxDepth, valoare, algo)
                                if val > valoare:
                                    miscare = [(i, j), (i + x, j + y)]
                                    valoare = val
                            else:
                                val = recursivitate(newTable, BLACK, self.nrBlack - conquered, self.nrWhite + conquered, 0, self.maxDepth, valoare, algo)
                                if val < valoare:
                                    miscare = [(i, j), (i + x, j + y)]
                                    valoare = val
            print()
        return miscare

    def skip_turn(self):
        """Verifica daca jucatorul curent nu poate face
        nicio miscare pe tabla"""
        for x in range(7):
            for y in range(7):
                if self.mat[x][y] == self.currentPlayer:
                    for i in range(len(COORDI)):
                        for j in range(len(COORDJ)):
                            if 0 <= x + COORDI[i] < 7 and 0 <= y + COORDJ[j] < 7 and self.mat[x + COORDI[i]][y + COORDJ[j]] == 0:
                                return False
                            if 0 <= x + COORDI2[i] < 7 and 0 <= y + COORDJ2[j] < 7 and self.mat[x + COORDI2[i]][y + COORDJ2[j]] == 0:
                                return False
                            
        return True


def main():
    MiniMaxAlgo = False
    AlphaBetaAlgo = True

    pygame.init()
    dimensiune = latime, inaltime = 650, 650
    negru, alb, gri, rosu = (0, 0, 0), (255, 255, 255), (128, 128, 128), (255, 99, 71)
    platinum, verde, lavender = (229, 228, 226), (124, 252, 0), (65,105,225)
    ecran = pygame.display.set_mode(dimensiune)
    fontMic = pygame.font.SysFont("microsoftjhengheimicrosoftjhengheiui", 20)
    fontMediu = pygame.font.SysFont("microsoftjhengheimicrosoftjhengheiui", 25)
    fontMare = pygame.font.SysFont("microsoftjhengheimicrosoftjhengheiui", 60)
    # cls.zero_img = pygame.transform.scale(cls.zero_img, (dim_celula,math.floor(dim_celula*cls.zero_img.get_height()/cls.zero_img.get_width())))
    # blackImg = pygame.image.load('black.png')
    # blackImg.set_colorkey((255, 255, 255))  # make background transparent
    # blackImg = pygame.transform.scale(blackImg, (38, 38))
    # whiteImg = pygame.image.load('white.png')
    # whiteImg.set_colorkey((0, 0, 0))
    # whiteImg = pygame.transform.scale(whiteImg, (38, 38))

    utilizator = None
    algo = None
    dificultate = None
    start = False
    errorMessage = False
    joc = Joc()

    while True:
        for e in pygame.event.get():
            if e.type == pygame.QUIT:
                sys.exit()
        
        ecran.fill(alb)
        pygame.display.set_caption('Neagu Matei: Ataxx')

        if utilizator == None or algo == None or dificultate == None or start == False:
            title = fontMare.render("Ataxx", True, negru)
            divTitlu = title.get_rect()
            divTitlu.center = (latime / 2, 50)
            ecran.blit(title, divTitlu)

            miniMaxButton = pygame.Rect(latime / 8, inaltime / 4, latime / 4, 50)
            miniMaxText = fontMediu.render("Aleg Minimax", True, alb)
            divMiniMax = miniMaxText.get_rect()
            divMiniMax.center = miniMaxButton.center
            if algo == MiniMaxAlgo:
                pygame.draw.rect(ecran, gri, miniMaxButton)
            else:
                pygame.draw.rect(ecran, negru, miniMaxButton)
            ecran.blit(miniMaxText, divMiniMax)

            alphaBButton = pygame.Rect(5 *latime / 8, inaltime / 4, latime / 4, 50)
            alphaBText = fontMediu.render("Aleg Alpha-Beta", True, alb)
            divAlphaB = alphaBText.get_rect()
            divAlphaB.center = alphaBButton.center
            if algo == AlphaBetaAlgo:
                pygame.draw.rect(ecran, gri, alphaBButton)
            else:
                pygame.draw.rect(ecran, negru, alphaBButton)
            ecran.blit(alphaBText, divAlphaB)

            blackButton = pygame.Rect(latime / 8, inaltime / 2, latime / 4, 50)
            blackText = fontMediu.render("Aleg piese negre", True, alb)
            divBlack = blackText.get_rect()
            divBlack.center = blackButton.center
            if utilizator == 1:
                pygame.draw.rect(ecran, gri, blackButton)
            else:
                pygame.draw.rect(ecran, negru, blackButton)
            ecran.blit(blackText, divBlack)

            whiteButton = pygame.Rect(5 *latime / 8, inaltime / 2, latime / 4, 50)
            whiteText = fontMediu.render("Aleg piese albe", True, alb)
            divWhite = whiteText.get_rect()
            divWhite.center = whiteButton.center

            if utilizator == 2:
                pygame.draw.rect(ecran, gri, whiteButton)
            else:
                pygame.draw.rect(ecran, negru, whiteButton)
            ecran.blit(whiteText, divWhite)


            # DIFICULTATE
            dificultati = ["Usor", "Mediu", "Avansat"]
            dificultateButtons = []
            for i in range(1, 8, 3):
                easyButton = pygame.Rect(i * latime / 9, 3 * inaltime / 4, latime / 5, 45)
                easyText = fontMediu.render(dificultati[i // 3], True, alb)
                divEasy = easyText.get_rect()
                divEasy.center = easyButton.center
                if dificultate == i // 3:
                    pygame.draw.rect(ecran, gri, easyButton)
                else:
                    pygame.draw.rect(ecran, negru, easyButton)
                ecran.blit(easyText, easyButton)
                dificultateButtons.append(easyButton)


            startButton = pygame.Rect(3 *latime / 8, 3.7 * inaltime / 4, latime / 4, 50)
            startText = fontMediu.render("START", True, alb)
            divStart = startText.get_rect()
            divStart.center = startButton.center
            pygame.draw.rect(ecran, negru, startButton)
            ecran.blit(startText, divStart)
            
            if errorMessage == True:
                err = fontMic.render("Choose 1 box per line", True, rosu)
                divError = err.get_rect()
                divError.center = (3 * latime / 4, 30)
                ecran.blit(err, divError)
            
            mouseClick, _, _ = pygame.mouse.get_pressed()       # urmatoarele 2 sunt right click si scroll
            if mouseClick == True:
                mousePoz = pygame.mouse.get_pos()
                if miniMaxButton.collidepoint(mousePoz):
                    algo = MiniMaxAlgo
                elif alphaBButton.collidepoint(mousePoz):
                    algo = AlphaBetaAlgo
                elif whiteButton.collidepoint(mousePoz):
                    utilizator = WHITE
                elif blackButton.collidepoint(mousePoz):
                    utilizator = BLACK
                elif startButton.collidepoint(mousePoz):
                    if None in [utilizator, algo, dificultate]:
                        errorMessage = True
                    else:
                        start = True
                else:
                    for i in range(len(dificultateButtons)):
                        if dificultateButtons[i].collidepoint(mousePoz):
                            dificultate = i
                            joc.maxDepth = (i + 1) * 1
        else:
            tablaJoc = joc.stare_tabla()
            dimDreptunghi = 90
            coltStgSus = 60     # 25 in height si 25 in width
            for i in range(6):
                for j in range(6):
                    dreptunghi = pygame.Rect(coltStgSus + j * dimDreptunghi, coltStgSus + i * dimDreptunghi, dimDreptunghi, dimDreptunghi)
                    pygame.draw.rect(ecran, negru, dreptunghi, 3)

            
            dreptunghiuri = []
            for i in range(7):
                rand = []
                for j in range(7):
                    dreptunghi = pygame.Rect(coltStgSus + j * dimDreptunghi - 20, coltStgSus + i * dimDreptunghi - 20, 40, 40)
                    # pygame.draw.rect(ecran, rosu, dreptunghi, 1)
                    rand.append(dreptunghi)

                    if tablaJoc[i][j] == 1:
                        pygame.draw.circle(ecran, negru, (coltStgSus + j * dimDreptunghi, coltStgSus + i * dimDreptunghi), 20)
                    elif tablaJoc[i][j] == 2:
                        pygame.draw.circle(ecran, platinum, (coltStgSus + j * dimDreptunghi, coltStgSus + i * dimDreptunghi), 20)

                dreptunghiuri.append(rand)

            # print("YESS")
            stareFinala = stare_finala(tablaJoc, joc.nrBlack, joc.nrWhite)
            jucator = joc.player()
    
            if stareFinala != None:
                if stareFinala == BLACK:
                    titleText = f"CASTIGATOR: NEGRU"
                else:
                    titleText = f"CASTIGATOR: ALB"
                for i in range(7):
                    for j in range(7):
                        if tablaJoc[i][j] == stareFinala:
                            pygame.draw.circle(ecran, verde, (coltStgSus + j * dimDreptunghi, coltStgSus + i * dimDreptunghi), 20)

            elif jucator == utilizator:
                titleText = "RANDUL TAU"
            else:
                titleText = "RAND CALCULATOR"
            
            title = fontMare.render(titleText, True, negru)
            divTitlu = title.get_rect()
            divTitlu.center = (latime / 2, 20)
            ecran.blit(title, divTitlu)

            pygame.display.flip()
            skip = joc.skip_turn()
            if jucator != utilizator and stareFinala == None and not skip:
                time.sleep(0.3)
                miscare = joc.best_move(algo)
                if type(miscare) == list:
                    newTable, conquered = converteste(tablaJoc, miscare[1], jucator, miscare[0])
                else:
                    newTable, conquered = converteste(tablaJoc, miscare, jucator)
                joc.mat = tablaJoc = newTable
                if jucator == BLACK:
                    joc.nrBlack += conquered
                    if type(miscare) == list:
                        joc.nrWhite -= conquered
                    else:
                        joc.nrWhite -= conquered - 1   # 1 e scazut ptc in lista conquered e si pozitia goala acum ocupata
                    joc.currentPlayer = jucator = WHITE
                else:
                    if type(miscare) == list:
                        joc.nrBlack -= conquered
                    else:
                        joc.nrBlack -= conquered - 1
                    joc.nrWhite += conquered
                    joc.currentPlayer = jucator = BLACK
            elif skip and jucator != utilizator:
                jucator = joc.currentPlayer = utilizator
            

            stareFinala = stare_finala(tablaJoc, joc.nrBlack, joc.nrWhite)
            skip = joc.skip_turn()
            if jucator == utilizator and stareFinala == None and not skip:
                time.sleep(0.3)
                mouseClick, _, _ = pygame.mouse.get_pressed()
                if mouseClick == True:
                    mousePoz = pygame.mouse.get_pos()
                    print("\n_______________________________\n")
                    ok2 = 0
                    i = 0
                    while i < 7 and ok2 == 0:
                        j = 0
                        while j < 7 and ok2 == 0:
                            print(joc.mat[i][j], end=" ")
                            if dreptunghiuri[i][j].collidepoint(mousePoz) and tablaJoc[i][j] == 0 and correct_move(((i, j), 1), tablaJoc, jucator):
                                newTable, conquered = converteste(tablaJoc, (i, j), jucator)
                                joc.mat = tablaJoc = newTable
                                if jucator == BLACK:
                                    joc.nrBlack += conquered
                                    joc.nrWhite -= conquered - 1   # 1 e scazut ptc in lista conquered e si pozitia goala acum ocupata
                                    joc.currentPlayer = jucator = WHITE
                                else:
                                    joc.nrBlack -= conquered - 1
                                    joc.nrWhite += conquered
                                    joc.currentPlayer = jucator = BLACK
                                # print(i, j)
                                ok2 = 1
                            elif dreptunghiuri[i][j].collidepoint(mousePoz) and tablaJoc[i][j] == utilizator:
                                pygame.draw.circle(ecran, lavender, (coltStgSus + j * dimDreptunghi, coltStgSus + i * dimDreptunghi), 20)
                                pygame.display.flip()
                                while ok2 == 0:
                                    ev = pygame.event.get()
                                    for event in ev:
                                        if event.type == pygame.MOUSEBUTTONDOWN:
                                            mousePoz = pygame.mouse.get_pos()
                                            for u in range(7):
                                                if ok2 == 1:
                                                    break
                                                for v in range(7):
                                                    if dreptunghiuri[u][v].collidepoint(mousePoz) and correct_move(((u, v), (i, j)), tablaJoc, jucator):
                                                        # ok2 = 1
                                                        newTable, conquered = converteste(tablaJoc, (u, v), jucator, (i, j))
                                                        joc.mat = tablaJoc = newTable
                                                        if jucator == BLACK:
                                                            joc.nrBlack += conquered
                                                            joc.nrWhite -= conquered
                                                            joc.currentPlayer = jucator = WHITE
                                                        else:
                                                            joc.nrBlack -= conquered
                                                            joc.nrWhite += conquered
                                                            joc.currentPlayer = jucator = BLACK
                                                        time.sleep(0.5)     
                                                        break
                                            ok2 = 1
                            j += 1
                        i += 1
                        print()
            elif jucator == utilizator and skip:
                if jucator == BLACK:
                    jucator = joc.currentPlayer = WHITE
                else:
                    jucator = joc.currentPlayer = BLACK

        pygame.display.flip()

if __name__ == '__main__':
    main()