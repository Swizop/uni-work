Identificator: python_clasa_introductiv
Se considera clasa Elev. Un obiect de tip Elev are urmatoarele proprietati:
nume, sanatate, inteligenta, oboseala, buna_dispozitie.

Clasa Elev va avea un constructor care primeste ca parametru un sir de caractere, reprezentand numele elevului. In cadrul constructorului se dau si valorile initiale ale statusurilor: sanatate=90, inteligenta=20, oboseala=0, buna_dispozitie=100. Daca este apelat constructorul fara parametri, atunci se va aloca un nume default noului elev; numele va avea forma Necunoscut_1, Necunoscut_2,...Necunoscut_n... Daca ultimul apel de constructor fara parametri a generat numele Necunoscut_i, atunci urmatorul nume va fi Necunsocut_(i+1).

De asemenea, se considera clasa Activitate cu proprietatile:
nume, factor_sanatate, factor_inteligenta, factor_oboseala, factor_dispozitie, durata. Clasa Activitate are un constructor cu 6 parametri si nu admite sa fie apelat cu mai putini (deci fara valori implicite). Activitatile vor fi citite dintr-un fisier txt precum cel de mai jos, si vor fi memorate intr-o lista de obiecte de tip Activitate.

Fisierul txt de activitati:

nume  factor_sanatate, factor_inteligenta, factor_oboseala, factor_dispozitie durata
invatat              0  7   7 -5  4
baut_cafea          -5 -2   1  3  1
iesit_cu_prietenii   2  1   4 10  3 
alergat              5  0  10  5  2
dormit               3  0 -10  5  4
rebus                0  2   1  2  1
discoteca          -10  0  10 10  3
citit                0  5   3  1  2
relaxare             1  0  -5  3  2
televizor           -4 -2   4  1  1
exercitii_scoala     0 10  10 -7  3 
Clasa Elev va avea:

o metoda numita desfasoara_activitate, care va aplica o activitate unui elev (se poate considera un camp numit activitate curenta si un alt camp numit timp_executat_activ, care arata cat a executat elevul din activiatea data; initial dupa aplicarea unei noi activitati, timpul va fi 0).
o metoda numita trece_ora(ora) care va executa inca o ora din activitatea curenta. Daca elevul a petrecut deja timpul alocat activitatii, atunci metoda va returna False, altfel True.
o metoda numita testeaza_final, care verifica daca elevul a ajuns intr-o stare finala sau nu (returneaza True sau False dupa caz).
o metoda numita afiseaza_raport care afiseaza pe ecran cate ore a executat elevul respectiv din fiecare activitate – se va folosi un dictionar pentru a memora acest raport.
se va redefini metoda __repr__ pentru a afisa elevii intr-o maniera mai user friendly.
Considerente privind activitatile:

Pentru un elev niciunul din statusuri nu poate sa creasca mai mult de 100 sau sa ajunga negativ.
Toate activitatile care se desfasoara noaptea (orele 22 – 6 dimineata), in afara de dormit, vor scadea sanatatea cu 1, in fiecare ora.
Daca sanatatea sau buna dispozitie ajung la 0 inseamna ca elevul e bolnav si procesul se opreste pentru elevul respectiv.
Daca inteligenta ajunge la 100, atunci elevul termina scoala, se afiseaza pe ecran un mesaj de felicitare si nu se mai continua procesul pentru el.
Daca oboseala a ajuns la 100, orice aport pozitiv de inteligenta, sanatate sau buna dispozitie va fi la jumatate.
Va exista o functie numita porneste simulare care va porni de la ora 9 dimineata si va afisa pentru fiecare elev ce face. Dupa afisarea activitatilor pentru acea ora va afisa textul:
comanda=
si va astepta un input. Inputul poate fi un numar (cate ore sa mai afiseze), cuvantul “gata” care opreste executia acolo si nu mai aduce elevii la o stare finala, si cuvantul continua, care va afisa pe ecran doar starile finale ale elevilor (daca au absolvit sau au ajuns la spital – cam sadic, stiu :D) si raportul: cate ore au dormit, cate ore au stat la televizor etc.

Cand se afiseaza mai multe ore, intre afisarile a doua ore trebuie sa existe un delay de 1 secunda.

Daca activitatea dureaza d ore si valoarea unui factor e f, atunci statusul elevului creste in fiecare ora cu f/d.

Afisarea va fi de forma (pentru o ora):
Ora 10:00
Ionel dormit 2/4 (snt: 27, intel: 40, obos: 13, dispoz: 55)
Gigel televizor 1/1 (snt: 13, intel: 90, obos: 83, dispoz: 5)
Simona invatat 4/4 (snt: 95, intel: 70, obos: 40, dispoz: 75)
Orele vor creste pana la 24 si apoi se vor reseta la 1.

In cadrul simularii, cand un elev a terminat o activitate, se va alege aleator pentru el o noua activitate.