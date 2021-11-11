Muzica
Vasile a aflat ca DJ Random va mixa playlist-ul pentru Balul Bobocilor al Facultăţii de Matematică şi Informatică din Universitatea din Bucureşti. Pentru simplitate vom considera ca fiecare melodie se poate codifica (folosind algoritmi mult prea inteligenţi pentru Vasile) în numere întregi pe 32 biţi. Vasile are şi el un playlist preferat al sau, şi este curios cate din melodiile din playlist-ul sau se afla şi în playlist-ul lui DJ Random.

DJ Random este destul de leneş, iar din acest motiv el îşi va genera melodiile în felul următor: îşi alege primele doua melodii R[ 1 ] = A si R[ 2 ] = B, iar pentru restul va folosi formula R[ i ] = (C * R[i - 1] + D * R[i - 2]) % E.

Date de intrare
Fişierul de intrare muzica.in va conţine pe prima linie N, numărul de melodii din playlist-ul lui Vasile, si M, numărul de melodii din playlist-ul lui DJ Random. Pe a doua linie se afla A, B, C, D si E, constantele cu care DJ Random îşi construieşte playlist-ul, iar pe a treia linie se afla N numere reprezentând melodiile din playlist-ul lui Vasile.

Date de ieşire
În fişierul de ieşire muzica.out se va afla pe prima linie numărul de piese din playlist-ul lui Vasile se afla şi în playlist-ul lui D Random.

Restricţii
3 ≤ N ≤ 10.000
3 ≤ M ≤ 10.000.000
1 ≤ A, B, C, D, E ≤ 1.000.000.000
Orice melodie are asociat un întreg pe 32 biţi.
Se garantează ca Vasile e un tip original şi nu are doua piese identice în playlist.
Exemplu
muzica.in
3 4
1 1 1 1 1000000000
1 2 7


muzica.out
2
Explicaţie
Melodiile din playlist-ul lui Vasile sunt: 1, 2, 7, iar cele din playlist-ul lui DJ Random sunt: 1, 1, 2, 3, deci sunt doua melodii care se gasesc si in playlistul lui Vasile si in playlist-ul lui DJ Random, si anume: 1 si 2.

Vezi solutiile trimise de tine
