Pariuri
Deoarece ora inceperii meciului se apropie vertiginos, PalanRit s-a apucat de jucat la pariuri pentru ca pana la fluierul de start al partidei dintre Grecia si Romania el vrea sa fie un parior experimentat. Pentru a prinde experienta rapid el s-a inhamat intr-o gasca periculoasa cu N oameni. Fiecare din cei N oameni au cate o lista care contine perechi de forma (timp, bani) care semnifica ca la unitatea de timp timp el sau ea a pariat, si a castigat, sau a pierdut, o suma de bani echivalenta cu bani. PalanRit vrea sa faca o statistica, si anume vrea sa creeze o lista de perechi de forma (timp, suma_bani) in care sa contorizeze cat a castigat, sau a pierdut gasca la fiecare moment de timp in care s-a pariat.

Date de intrare
Fişierul de intrare pariuri.in contine pe prima linie un numar natural N, reprezentand numarul de persoane din gasca. Pe urmatoarele N linii se vor descrie cele N liste, dupa cum urmeaza. Fiecare linie contine un numar M, reprezentand numarul de elemente din lista respectiva, urmat de M perechi de cate doua numere, timp si bani, cu semnificatia din cerinta. Toate numerele de pe o linie sunt separate printr-un spatiu.

Date de ieşire
În fişierul de ieşire pariuri.out veti afisa pe prima linie un numar P reprezentand numarul de elemente din lista lui PalanRit, iar pe cea de-a doua linie veti afisa P perechi de cate doua numere timp, suma_bani, cu semnificatia ca la unitatea de timp timp, intreaga gasca a castigat, sau a pierdut, o suma de bani echivalenta cu suma_bani.

Restricţii
1 ≤ N ≤ 100
1 ≤ M ≤ 20 000
1 ≤ timp ≤ 109
Pentru 80% din teste 1 ≤ timp ≤ 106
-106 ≤ bani ≤ 106
Daca bani ≥ 0 atunci se considera a fi castig, iar in caz contrar se considera a fi pierdere.
ATENTIE! Ordinea perechilor din fisierul de iesire nu conteaza.


Exemplu
pariuri.in	
3
2 1 10 3 -60
1 3 50
3 1 -5 3 15 2 -5

pariuri.out
3
1 5 2 -5 3 5
