% 232 Neagu Matei - varianta 2


% REZ:

% calculam suma unei liste
medieaux([H], H).
medieaux([H | T], R) :-
    medieaux(T, R1),
    R is H + R1.

% facem media aritmetica
medie(L, R) :-
    medieaux(L, Rez),
    length(L, Lg),
    R is Rez / Lg.


studenti_pentru_bursa([], _, []).
studenti_pentru_bursa([(student(Nume, Ls)) | T], X, [Nume | R]) :-
    medie(Ls, Nota),
    Nota >= X,
    studenti_pentru_bursa(T, X, R).

studenti_pentru_bursa([(student(Nume, Ls)) | T], X, R) :-
    medie(Ls, Nota),
    Nota < X,
    studenti_pentru_bursa(T, X, R).


% TEST:

% studenti_pentru_bursa([student('Neagu', [10, 10, 10, 8]), student('Popescu', [10, 8]), student('Raul', [7, 9]), student('Florea', [2,2,3]), student('Popovici', [10, 10])], 9, L).

% REZULTAT: L = ['Neagu', 'Popescu', 'Popovici'] ;