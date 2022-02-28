% ancestor_of / 2
ancestor_of(X, Y) :- parent(X, Y).
ancestor_of(X, Y) :- parent(X, Z), ancestor_of(Z, Y).

% N1 is N - 1,
% fib(N1)

%fib / 2
% fib( +I, -R).
fib(0, 1).
fib(1, 1).
fib(N, R) :-
N1 is N - 1,
N2 is N - 2,
fib(N1, R1),
fib(N2, R2),
R is R1 + R2.

% apel:  fib(2, X).

% cls :- write('\33\[2J')

% square / 2
% square(+Dim, +Ch).



% _______________________
%square(0, _) :- nl.
%square(N, Ch) :-
% squareLine(N, Ch),
% N1 is N - 1,
% square(N1, Ch).
% __________________


% VARIANTA 1

%squareLine(0, _) :- nl.
%squareLine(N, Ch) :-
% write(Ch),
% N1 is N - 1,
% squareLine(N1, Ch).
%
%
%squareAux(N, N, _) :- nl.
%squareAux(N, I, Ch) :-
% squareLine(N, Ch),
% I1 is I + 1,
% squareAux(N, I1, Ch).
%
%square(N, Ch) :- squareAux(N, 0, Ch).

% ca sa specific cazul cand 2 argumente sunt egale,
% fac o definitie noua unde au acelasi nume

%final de matrice:
squareAux(N, N, N, Ch) :-
write(Ch),
nl.


%final de linie

squareAux(N, I, N, Ch) :-
write(Ch),
nl,
I1 is I + 1,
squareAux(N, I1, 1, Ch).


squareAux(N, I, J, Ch) :-
write(Ch),
J1 is J + 1,
squareAux(N, I, J1, Ch).


%facem si un square cu un sg param care apeleaza aux(0,0)


%LISTE

% element_of / 2
% element_of(+list, +element)

element_of([H | _], H).
element_of([_ | T], Element) :-
element_of(T, Element).


%concat lists
% concat_lists(+L1,  +L2, -LAppend).

concat_lists([], L2, L2).
concat_lists([H1 | L1], L2, [H1 | L3]) :-
concat_lists(L1, L2, L3).


% sa se defineasca un predicat care sa calculeze lungimea unei

liste

length([], 0).
length([H | T], Res) :-
length(T, Res1),
Res is Res1 + 1.


% all_a / 1
% verificam daca in lista sunt doar elemente a

all_a([a]).
all_a([a | T]) :- all_a(T).


% ATENTIE: ?- all_a([a,A,a])  nu va da false. A e variabila, deci va

rezulta ca A = a

% trans_a_b/2
% se va transforma lista de a-uri intr-o lista de b-uri
% trans_a_b(+LInput, -LOutput).

trans_a_b([a], [b]).
trans_a_b([a | T1], [b | T2]) :- trans_a_b(T1, T2).


% scalarMult / 3
% scalarMult(+Scalar, +Lista, -ProdusulScalar).
% scalarMult(3, [1,2,3], X).
% X = [3,6,9]

scalarMult(_, [], []).
scalarMult(Scalar, [HInput | TInput], [ HOutput | TOutput]) :-
HOutput is Scalar * HInput,
scalarMult(Scalar, TInput, TOutput).



% dot / 3
% produsul scalar dintre 2 vectori
% se garanteaza ca lg listelor care descriu vectorii sunt egale
% dot([1,2,3], [4,5,6], X).
% X = 32

dot([], [], 0).
dot([H1 | T1], [H2 | T2], R) :-
dot(T1, T2, RT),
R is RT + H1 * H2.



% max / 2
% sa se calculeze maximul elementelor dintr-o lista

max([], 0).
max([H], H).

max([H | T], Max) :-
max(T, TailMax),
H > TailMax,
Max = H.

max([H | T], Max) :-
max(T, TailMax),
H =< TailMax,
Max = TailMax.

% palindrome / 1
% verificam daca o lista este palindrom
% reverse este deja scris

% rezultatul lui reverse trb sa fie tot la fel
palindrome(X) :- reverse(X, X).


%trb sa definim noi functia reverse:
% reverse_of(+List, -ListResult).

reverse_of(List, ListResult) :-
reverse_of(List, [], ListResult).

reverse_of([], List, List).
reverse_of([H |T], ListAux, ListResult) :-
reverse_of(T, [H | ListAux], ListResult).

% luam primul element al listei curente si il punem la finalul

celeilalte


% remove_duplicates / 2
% sterge duplicatele din prima lista si le returneaza in a 2a lista

%remove_duplicates([a,a,b,a,c], X).
% X = [a, b, c]

remove_duplicates([], []).
remove_duplicates([H | T], LR) :-
member(H, T), % H apare in tail
remove_duplicates(T, LR).

remove_duplicates([H | T], [H | TR]) :-
not(member(H, T)),
remove_duplicates(T, TR).



% replace([1,2,3,4,3,5,6,3], 3, x, List)
% => [1, 2, x, 4, x, 5, 6, x]

replace([], _, _, []).
replace([X | T], X, Y, [Y | LR]) :-
replace(T, X, Y, LR).

replace([Z | T], X, Y, [Z | LR]) :-
replace(T, X, Y, LR).