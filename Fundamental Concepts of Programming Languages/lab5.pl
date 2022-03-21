% ex 1
% numar_aparitii / 3
% nr_ap(+List, +Elem, - NrApar).

nr_ap([], _, 0).
nr_ap([H | T], H, R) :- 
	nr_ap(T, H, R1),
	R is R1 + 1.
nr_ap([H | T], X, R) :-
	nr_ap(T, X, R).


% ex 2
%  lista_cifre / 2 => determina lista de cifre pt un numar dat
% lista_cifre(+NrNatural, -ListaDeCifre).
% lista_cifre(2048, L).
% L = [2,0,4,8]

lista_cifre_aux(X, [X]) :- X < 10.
lista_cifre_aux(X, [X1 | Rez]) :-
	X1 is X mod 10,
	X2 is X // 10,
	lista_cifre(X2, Rez).
% ATENTIE: pana aici, returnul e lista pe care o vrem reversed

lista_cifre(Nr, Result) :-
	lista_cifre_aux(X, R1),
	reverse(R1, Result).




% ex 3: lista permutarilor circulare ale unei liste
% [1, 2, 3]
% [[1,2,3], [2,3,1], [3,1,2]]

% permutarea circulara facuta doar o data

permcirc([], []).
permcirc([H | T], L) :-
	append(T, [H], L).

permaux(L, L, [L]).
permaux(L, M, [M | LP]) :-
	permcirc(M, N),
	permaux(L, N, LP).

listpermcirc(L, LP) :-
	permcirc(L, M),
	permaux(L, M, LP).


% ex. 4
% predicatul elimina/3
% elimina(+List, +Elem, -ListFaraElem).

elimina([], _, []).
elimina([H | T], H, TR) :-
	elimina(T, H, TR).
elimina([H | T], Elem, [H | TR]) :-
	elimina(T, Elem, TR).



% multime / 2
% multime(+List, -ListFaraDuplicate).

multime([], []).
multime([H | T], L) :-
	member(H, T),
	multime(T, L).
multime([H | T], [H | L]) :-
	not(member(H, T)),
	multime(T, L).

% emult(ime) / 1
% emult true daca lista data e multime
emult([]).
emult(L) :-
	multime(L, L1),
	length(L, N1),
	length(L1, N2),
	N1 =:= N2.

emult1([]).
emult1([H | T]) :-
	emult1(T),
	not(member(H, T)).

intersectia([], _, []).
intersectia([H | T], L, R) :-
	not(member(H, L)),
	intersectia(T, L, R).

intersectia([H | T], L, [H | R]) :-
	member(H, L),
	intersectia(T, L, R).


% diff/3 pe multimi

diff([], _, []).
diff([H | T], Y, [H | R]) :-
	not(member(H, Y)),
	diff(T, Y, R).


diff([H | T], Y, R) :-
	member(H, Y),
	diff(T, Y, R).


% prod cartezian
% prod_cartezian(M1, M2, -Mprod).
% [1,2,3] [4,5,6,7]
% [(1, 4), (1, 5), (1, 6), (1, 7), (2, 4), (2, 5)...]




elem_prod_multime(_, [], []).
elem_prod_multime(X, [H | T], [(X, H) | R]) :-
	elem_prod_multime(X, T, R).

prod_cartezian([], _, []).
prod_cartezian([H | T], L, R) :-
	elem_prod_multime(H, L, R1),
	prod_cartezian(T, L, RTail),
	append(R1, RTail, R).

cls :- write('\33\[2J').




% 1. suma elementelor dintr-o lista

suma([X], X).
suma([X | T], S) :-
	suma(T, S1),
	S is T + S1.


%2. PREDICAT care elimina prima aparatie a unui el. intr-o lista

elimina([], _, []).
elimina([H | T], H, T).
elimina([H | T], J, [H | R]) :-
	elimina(T, J, R).


% reprezentarea arborilor binari in prolog
% nil - arborele vid
% arb / 3
% arb(+Radacina, +Stanga, +Dreapta).
% arb(2, arb(4, arb(2, nil, nil), 5), nil).

% Parcurgerile arborelui

% inordine, preordine, postordine
% SRD		RSD	SDR

srd(nil, []).
srd(arb(R, S, D), L) :-
	srd(S, Ls),
	srd(D, Ld),
	append(Ls, [R | Ld], L).


% rsd / 2
rsd(nil, []).
rsd(arb(R, S, D), L) :-
	rsd(S, Ls),
	rsd(D, Ld),
	append([R | Ls], Ld, L).


% sdr / 2
sdr(nil, []).
sdr(arb(R, S, D), L) :-
	sdr(S, Ls),
	sdr(D, Ld),
	append(Ls, Ld, LTemp),
	append(LTemp, [R], L).


%sa se det. mult frunzelor dintr-un arbore
% frunze/2
% frunze(+Arb, -LFrunzelor).

frunze(nil, []).
frunze(arb(F, nil, nil), [F]).
frunze(arb(R, S, D), L) :-
	frunze(S, Ls),
	frunze(D, Ld),
	append(Ls, Ld, L).