Cerințe comune tuturor temelor: 

utilizarea sabloanelor (functii, clase) 

utilizarea STL 

utilizarea variabilelor, funcțiilor statice
,constantelor și a unei functii const 

utilizarea conceptelor de RTTI raportat la templat-uri (ex: upcast & dynamic_cast) 

citirea informațiilor complete a n obiecte, memorarea și afișarea acestora 


cerințe generale aplicate fiecărei teme din acest fișier: 

- să se identifice și să se implementeze ierarhia de clase; 

- clasele să conțină constructori, destructori, =, supraincarcare pe >> si << pentru citire si afisare; 

- clasa de baza sa conțină funcție virtuala de afisare si citire, rescrisa în clasele derivate, iar operatorul de citire si afisare să fie implementat ca funcție prieten (în clasele derivate să se facă referire la implementarea acestuia în clasa de baza). 


_____________________________________________________________________________________________

La ora de Biologie, copiii din ciclul gimnazial învață că regnul animal se împarte în 2 grupuri: nevertebrate și vertebrate. La rândul lor, vertebratele se împart în pești, păsări, mamifere și reptile. 

 

Cerința suplimentară:  

- Să se adauge toate campurile relevante pentru modelarea acestei probleme. 

- Să se construiască clasa template AtlasZoologic care sa conțină un număr de animale (incrementat automat la adaugarea unei noi file) și structura de obiecte de tipul regnurilor implementate, alocata dinamic. Sa se supraincarce operatorul += pentru inserarea unei fișe de observație a unui animal în structura. 

- Să se construiască o specializare pentru tipul Pești care sa adapteze operatorii menționați și care sa afiseze, în plus, cati pesti rapitori de lungime mai mare de 1m s-au citit. 

 

Structura de date: list<animal de un anumit tip *> 