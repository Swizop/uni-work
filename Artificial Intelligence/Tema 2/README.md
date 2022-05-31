(5%) 
(5%) 
(5%) 
(10%)  

(15%) Functia de generare a mutarilor (succesorilor) + eventuala functie de testare a validitatii unei mutari (care poate fi folosita si pentru a verifica mutarea utilizatorului)
(5%) Realizarea mutarii utilizatorului. Utilizatorul va realiza un eveniment în interfață pentru a muta (de exemplu, click). Va trebui verificata corectitudinea mutarilor utilizatorului: nu a facut o mutare invalida.
(10%) 

(20%=10+10) 
(15% impărtit după cum urmează) Afisari (în consolă).
(5%) Afisarea timpului de gandire, dupa fiecare mutare, atat pentru calculator (deja implementat în exemplu) cat si pentru utilizator. Pentru timpul de găndire al calculatorului: afișarea la final a timpului minim, maxim, mediu și a medianei.
(2%) Afișarea scorurilor (dacă jocul e cu scor), atat pentru jucator cat si pentru calculator și a estimărilor date de minimax și alpha-beta (estimarea pentru rădacina arborelui; deci cât de favorabilă e configurația pentru calculator, în urma mutării sale - nu se va afișa estimarea și când mută utilizatorul).
(5%) Afișarea numărului de noduri generate (în arborele minimax, respectiv alpha-beta) la fiecare mutare. La final se va afișa numărul minim, maxim, mediu și mediana pentru numarul de noduri generat pentru fiecare mutare.
(3%) Afisarea timpului final de joc (cat a rulat programul) si a numarului total de mutari atat pentru jucator cat si pentru calculator (la unele jocuri se mai poate sari peste un rand și atunci să difere numărul de mutări).
(5%) La fiecare mutare utilizatorul sa poata si sa opreasca jocul daca vrea, caz in care se vor afisa toate informațiile cerute pentru finalul jocului ( scorul lui si al calculatorului,numărul minim, maxim, mediu și mediana pentru numarul de noduri generat pentru fiecare mutare, timpul final de joc și a numarului total de mutari atat pentru jucator cat si pentru calculator) Punctajul pentru calcularea efectivă a acestor date e cel de mai sus; aici se punctează strict afișarea lor în cazul cerut.
(5%) Comentarii. Explicarea algoritmului de generare a mutarilor, explicarea estimarii scorului si dovedirea faptului ca ordoneaza starile cu adevarat in functie de cat de prielnice ii sunt lui MAX (nu trebuie demonstratie matematica, doar explicat clar). Explicarea pe scurt a fiecarei functii si a parametrilor.
Bonus (5%) Dacă faceți mai multe estimări ale scorului dar diferite ca idee (cu alt mod de abordare a jocului).
Bonus (5%). Ordonarea succesorilor înainte de expandare (bazat pe estimare) astfel încât alpha-beta să taie cât mai mult din arbore.
Bonus (10%). Opțiuni în meniu (cu butoane adăugate) cu:
Jucator vs jucător
Jucător vs calculator (selectată default)
Calculator (cu prima funcție de estimare) vs calculator (cu a doua funcție de estimare)
Bonus (5%) - propus de Andrei Cerbulescu. Cand vine randul jucatorului sa mute, sa se marcheze pe interfata grafica pozitiile valide in care poate plasa un simbol.
Bonus (15%) Pentru adancimi mai mari de 3 sa se salveze arborele alphabeta si sa se plece de la ce este calculat deja pentru aflarea urmatoarei mutari a calculatorului (ca sa nu fie recalculate mutarile la urmatoarea iteratie). Practic memoram subarborele mutarii alese din arborele alpha-beta generat anterior. Apoi jucatorul face mutarea M. Cautam in subarborele salvat mutarea jucatorului si pornim de la subarborele generat deja pentru ea si il continuam pentru a afla noua mutare a calculatorului.
Bonus (5%). Implementati optiunea de undo. La apasarea tastei u, se da undo ultimei mutari facute a utilizatorului. De la al doilea "undo" incolo se anuleaza mutarea calculatorului + mutarea jucatorului (practic se anuleaza mutarea jucatorului si raspunsul calculatorului).
Bonus (5%). Implementati optiunea de restartare joc. La apasarea tastei r, se genereaza din nou tabla initiala, se reseteaza scorurile si alte valori ce tineau de jocul anterior.
Bonus (5%) La apasarea tastei n la inceputul turn-ului jucatorului (cand jucatorul inca nu a facut vreo mutare) calculatorul isi va schimba (inlocui) mutarea cu urmatoarea cea mai buna dintre mutarile posibile. Apasari succesive ale lui n, ar afisa pe tabla pe rand de la cea mai buna mutare la cea mai slaba. Daca se apasa n si dupa cea mai slaba se reafiseaza cea mai buna (lista e luata de la inceput).
Bonus (10%) Optiunile de inrerupere, salvare si continuare joc. La apasarea tastei s, starea jocului se va salva intr-un fisier text (numele fisierului va fi cerut utilizatorului - acesta poate introduce numele fie in interfata grafica fie in consola). Fisierul va fi salvat intr-un folder numit "salvari" al jocului. La intrarea in joc, utulizatorul va primi ca prima intrebare din partea programului daca vrea sa incarce un joc si i se va afisa continutul fiserului de salvari, fiecare fisier avand un numar de ordine. Utilizatorul va raspunde cu numarul de ordine si va putea continua jocul din stadiul in care l-a lasat (tabla si alti parametri se vor incarca din fisier).
Bonus (1-10%) Diverse implementari deosebite, optimizari speciale.