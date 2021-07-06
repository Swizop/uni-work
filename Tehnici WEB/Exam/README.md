
P1. Creati un div cu clasa "container" (scrieti o regula css pentru aceasta clasa, astfel incat
inaltimea sa fie un sfert din inaltimea ecranului si latimea de 150px) in care se vor gasi alte 4
divuri. Realizati (eventual folosind tehnica grid din CSS) urmatorul mod de afisare al divurilor.
Scrieti o regula css astfel incat divurile din interiorul elementului cu clasa "container" sa aiba
border negru, dublu, de 8px si dimensiunea fontului de 10px.
Scrieti un media query pentru latimea ferestrei sub 600px si inaltimea sub 500 px cu efectele: a)
divurile copil sa nu se mai afiseze in grid, ci in formatul default, unul sub altul, intinse pe toata
latimea containerului b) cand aducem cursorul pe oricare din ele sa creasca treptat
dimensiunea fontului (timp de 3 secunde) la 20px (tranzitie).
P2. Creati un document HTML fara continut (nu contine alte elemente in interiorul body-ului).
Scrieti cod JavaScript pentru a rezolva urmatoarele:
-la incarcarea paginii, primul click in fereastra are ca efect crearea unui numar random (intre 1 si
10) de butoane (element HTML button), de culoare rosie (background) pentru cele de pe pozitii
pare si albastra pentru cele de pe pozitii impare . Asociati tuturor butoanelor o clasa CSS
"buton" care face ca toate butoanele sa aiba border si sa fie pozitionate pe randuri diferite in
pagina.
-la oricare alt click: daca este pe suprafata unui buton nou creat, culoarea de background a
body-ului se va schimba, luand culoarea butonului; daca click-ul este in fereastra dar nu este pe
suprafata unui buton, va aparea un alert in care scrie "Apasati butoanele".
P3. Presupunem ca intr-un document HTML avem un element input de tip “button” cu id-ul
“cifre”. Scrieti cod JavaScript pentru a rezolva:
- la fiecare apasare a unei taste cifra (0-9), tasta apasata se va adauga pe suprafata butonului.
- la apasarea unei taste litera, la fiecare 3 secunde se va sterge primul caracter cifra din cele
adaugate in input pana la stergerea tuturor cifrelor.
- la reincarcarea paginii in inputul de tip button sa se gaseasca numarul de taste cifre apasate
inainte de reincarcarea paginii.
P4. Scrieti un document HTML care sa contina un formular cu un element input de tip text si un
buton-submit. Se considera pe server vectorul de obiecte,
dictionar = [{cuvant:"carte", traducere:"book"}, {cuvant:"floare", traducere:"flower"},
{cuvant:"tablou", traducere:"picture"}, {cuvant:"film", traducere:"movie"}].
Scrieti aplicatia server app.js astfel incat dupa introducerea in inputul de tip text a unui cuvant,
la click pe butonul de submit, cuvantul citit se va trimite catre server iar in pagina se va afisa (in
locul formularului sau sub el) traducerea cuvantului in engleza daca acesta se gaseste in
dictionarul de pe server sau mesajul "Nu exista cuvantul cautat" in cazul in care cuvantul nu
se gaseste in dictionar (de ex: daca in input introduceti cuvantul "tablou" se va afisa "picture").
