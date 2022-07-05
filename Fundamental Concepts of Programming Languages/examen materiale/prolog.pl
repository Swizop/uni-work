fib(0, 1).
fib(1, 1).
fib_aux(_, R, I, I, R).
fib_aux(Nr1, Nr2, Index, X, R) :-
	Nr3 is Nr1 + Nr2,
	I1 is Index + 1,
	fib_aux(Nr2, Nr3, I1, X, R).
fib(X, R) :-
	fib_aux(1, 1, 1, X, R).

square_line(N, N, N, _) :- nl.
square_line(I, N, N, C) :-
	nl,
	I1 is I + 1,
	square_line(I1, 0, N, C).
square_line(I, J, N, C) :-
	write(C),
	J1 is J + 1,
	square_line(I, J1, N, C).

square(N, C) :-
	square_line(0, 0, N, C).

all_a([a]).
all_a([a | T]) :- all_a(T).

trans_a_b([a], [b]).
trans_a_b([a | T], [b | R]) :-
	trans_a_b(T, R).

scalarMult(_, [], []).
scalarMult(X, [H | T], [Y | R]) :-
	Y is X * H,
	scalarMult(X, T, R).

max([H], H).
max([H | T], H) :-
	max(T, R),
	H >= R.
max([H | T], R) :-
	max(T, R),
	H < R.

my_rev([], []).
my_rev([H], [H]).
my_rev([H | T], R) :-
	my_rev(T, R1),
	append(R1, [H], R).

palindrome(X) :-
	my_rev(X, X).

remove(_, [], []).
remove(X, [X | T], R) :-
	remove(X, T, R).
remove(X, [Y | T], [Y | R]) :-
	remove(X, T, R).

remove_duplicates([], []).
remove_duplicates([H | T], [H | R]) :-
	remove(H, T, R1),
	remove_duplicates(R1, R).


replace([], _, _, []).
replace([X | T], X, Y, [Y | R]) :-
	replace(T, X, Y, R).
replace([X | T], Z, Y, [X | R]) :-
	replace(T, Z, Y, R).



crossword(V1, V2, V3, H1, H2, H3) :-
	word(V1, _, A, _, B, _, C, _),
	word(V2, _, D, _, E, _, F, _),
	word(V3, _, G, _, H, _, I, _),
	word(H1, _, A, _, D, _, G, _),
	word(H2, _, B, _, E, _, H, _),
	word(H3, _, C, _, F, _, I, _).

born(jan, date(20,3,1977)).
born(jeroen, date(2,2,1992)).
born(joris, date(17,3,1995)).
born(jelle, date(1,1,2004)).
born(joan, date(24,12,0)).
born(joop, date(30,4,1989)).
born(jannecke, date(17,3,1993)).
born(jaap, date(16,11,1995)).


year(X, P) :-
	born(P, date(_, _, X)).

before(date(X, Y, Z), date(T, Y, Z)) :-
	X < T.
before(date(X, A, Z), date(T, Y, Z)) :-
	A < Y.

before(date(A, B, C), date(T, Y, Z)) :-
	C < Z.


older(X, Y) :-
	born(X, D1),
	born(Y, D2),
	before(D1, D2).


pathaux(X, Y, _) :-
	connected(X, Y).
pathaux(X, Y, Viz) :-
	connected(X, Z),
	not(member(Z, Viz)),
	append(Viz, [Z], Viz1).
	pathaux(Z, Y, Viz1).
	

path(X, Y) :-
	pathaux(X, Y, []).



successor(L, [x | L]).

plus([], R, R).
plus([x | T], L, [x | R]) :-
	plus(T, L, R).

times([], _, []).
times([x | T], L, R) :-
	times(T, L, R1),
	plus(L, R1, R).

element_at([H | T], 1, H).
element_at([H | T], N, R) :-
	N1 is N - 1,
	element_at(T, N1, R).

mutant(X) :-
	animal(A),
	animal(B),
	name(A, L1),
	name(B, L2),
	append(L11, L12, L1),
	not(length(L12, 0)),
	append(L12, L22, L2),
	not(length(L22, 0)),
	append(L11, L2, R),
	name(X, R).
	

la_dreapta(X, Y) :-
	X =:= Y + 1.
la_stanga(X, Y) :-
	Y =:= X + 1.
langa(X, Y) :-
	la_dreapta(X, Y);
	la_stanga(X, Y).

% casa(Numar,Nationalitate,Culoare,AnimalCompanie,Bautura,Tigari)


solutie(Strada,PosesorZebra) :-
Strada = [
casa(1,_,_,_,_,_),
casa(2,_,_,_,_,_),
casa(3,_,_,_,_,_),
casa(4,_,_,_,_,_),
casa(5,_,_,_,_,_)],

member(casa(_,englez,rosie,_,_,_), Strada),
member(casa(_,spaniol,_,caine,_,_), Strada),
member(casa(X,_,verde,_,cafea,_), Strada),
member(casa(_,ucrainean,_,_,ceai,_), Strada),
member(casa(Y,_,bej,_,_,_), Strada),
la_dreapta(X, Y),
member(casa(_,_,_,melci,_,'Old Gold'), Strada),
member(casa(D,_,galben,_,_,'Kools'), Strada),
member(casa(3,_,_,_,lapte,_), Strada),
member(casa(1,norvegian,_,_,_,_), Strada),
member(casa(A,_,_,_,_,'Chesterfields'), Strada),
member(casa(B,_,_,vulpe,_,_), Strada),
langa(A, B),
member(casa(C,_,_,cal,_,_), Strada),
langa(C, D),
member(casa(_,_,_,_,suc,'Lucky Strike'), Strada),
member(casa(_,japonez,_,_,_,'Parliaments'), Strada),
member(casa(2,_,albastru,_,_,_), Strada),
member(casa(_,PosesorZebra,_,zebra,_,_), Strada).


removee(_, [], []).
removee(X, [X | T], T).
removee(X, [Y | T], [Y | R]) :-
	removee(X, T, R).

coverr([], _).
coverr([H | T], L) :-
	member(H, L),
	removee(H, L, R),
	coverr(T, R).
cover([], _).
cover([H | T], L) :-
	select(H, L, R),
	cover(T, R).

solution(L, Word, Lg) :-
	word(Word),
	atom_chars(Word, Chs),
	cover(Chs, L),
	length(Chs, Lg).
	
topsolutionaux(L, Word, Lg) :-
	solution(L, Word, Lg).

topsolutionaux(L, Word, Lg) :-
	Lg1 is Lg - 1,
	topsolutionaux(L, Word, Lg1).

topsolution(L, Word) :-
	length(L, Lg),
	topsolutionaux(L, Word, Lg).








