%fib/2
%fib(+N, -Res).
fib(0, 1).
fib(1, 1).
fib(N, Res) :-
	N1 is N - 1,
	N2 is N - 2,
	fib(N1, Res1),
	fib(N2, Res2),
	Res is Res1 + Res2.

% square / 2 
% square(+N, +Ch) si afiseaza o matr NxN formata doar din Ch 

% squareAux(+Dim, +IndexLinie, +IndexColoana, +Ch).

squareAux(N, N, N, Ch) :-
	write(Ch).

squareAux(N, I, N, Ch) :-
	write(Ch),
	nl,
	I1 is I + 1,
	squareAux(N, I1, 1, Ch).

squareAux(N, I, J, Ch) :-
	write(Ch),
	J1 is J + 1,
	squareAux(N, I, J1, Ch).

square(N, Ch) :- 
	squareAux(N, 1, 1, Ch).

cls :- write('\33\[2J').

% Listele in Prolog 

% element_of / 2 
% element_of(+Elem, +List).

element_of(Elem, [Elem | _]). 
element_of(Elem, [_ | Tail]) :-
	element_of(Elem, Tail).

% concat_lists / 3
% concat_lists(+L1, +L2, -LR).

concat_lists([], L, L).
concat_lists([H1 | T1], L2, [H1 | T3]) :-
	concat_lists(T1, L2, T3).

% all_a / 1 
% all_a(+List) si returneaza True daca toate elementele listei sunt a 

all_a([a]).
all_a([a | T]) :- all_a(T).

% trans_a_b/2 
% trans_a_b(+La, -Lb). transforma o lista de a-uri intr-o lista de b-uri

trans_a_b([a], [b]).
trans_a_b([a | T1], [b | T2]) :-
	trans_a_b(T1, T2).


% scalarMult / 3 
% scalarMult(+Scalar, +List, -List).
% scalarMult(3, [1,2,3], List).
% List = [3,6,9].

scalarMult(_, [], []).
scalarMult(Scalar, [H1 | T1], [H2 | T2]) :-
	H2 is Scalar * H1,
	scalarMult(Scalar, T1, T2).

% dot / 3 
% dot(+L1, +L2, -Res).
% produsul scalar este suma produsului pe componente 

dot([], [], 0).
dot([H1 | T1], [H2 | T2], Res) :-
	dot(T1, T2, TailRes),
	Res is TailRes + H1 * H2.

% max / 2 
% max(+List, -Max).

max([X], X).
max([H | T], Max) :-
	max(T, TailMax),
	H > TailMax,
	Max = H.
max([H | T], Max) :-
	max(T, TailMax),
	H =< TailMax,
	Max = TailMax.

% palindrome / 1 
% returneaza true daca lista este un palindrom, false altfel 

palindrome(X) :- reverse(X, X).

% definim propriul nostru reverse 
% palindrome_of / 1, reverse_of / 2 

% reverse_of(+ListInput, +LAux, -LResult).

reverse_of([], L, L).
reverse_of([H1 | T1], LAux, LR) :-
	reverse_of(T1, [H1 | LAux], LR).

reverse_of(L, LR) :- 
	reverse_of(L, [], LR).

palindrome_of(X) :- reverse_of(X, X).

% remove_duplicates / 2 
% remove_duplicates(+LInput, -LR).

remove_duplicates([], []).

remove_duplicates([H | T], LR) :-
	member(H, T),
	remove_duplicates(T, LR).

remove_duplicates([H | T], [H | TR]) :-
	not(member(H, T)),
	remove_duplicates(T, TR).

% Tema
% Fibonacci cu memoizare 
% Ex 8 din laborator
% bogdan.macovei.fmi@gmail.com