Heapuri
Fie o multime de numere naturale initial vida. Se cere sa se efectueze N operatii asupra acestei multimi, unde operatiile sunt de tipul celor de mai jos:

operatia de tipul 1: se insereaza elementul x in multime
operatia de tipul 2: se sterge elementul intrat al x-lea in multime, in ordine cronologica
operatia de tipul 3: se afiseaza elementul minim din multime
Date de intrare
Fisierul de intrare heapuri.in va contine pe prima linie numarul N. Pe urmatoarele N linii se va afla descrierea operatiilor care trebuie efectuate. Primul numar de pe fiecare linie, cod, reprezinta tipul operatiei. Daca cod este 1 sau 2, atunci linia corespunzatoare va mai contine si numarul x, avand semnificatia din enunt.

Date de ieşire
Fisierul de iesire heapuri.out va contine, pe cate o linie, raspunsul pentru fiecare operatie de tipul 3 din fisierul de intrare, in ordinea data.

Restricţii
1 ≤ N ≤ 200 000
Elementele multimii nu vor depasi 1 000 000 000
Se garanteaza ca nu se va cere niciodata sa se afle minimul daca multimea este vida
Se garanteaza ca nu vor exista 2 operatii de tipul 2 care sa stearga acelasi element din multime
Pentru o operatie de tipul 2 se va sterge un element care e deja intrat in multime
Exemplu
heapuri.in	
9
1 4
1 7
1 9
3
1 2
2 1
3
2 4
3
