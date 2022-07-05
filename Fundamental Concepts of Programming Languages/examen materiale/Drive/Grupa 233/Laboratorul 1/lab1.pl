% bigger/2
bigger(elephant, horse).
bigger(horse, donkey).
bigger(donkey, dog).
bigger(donkey, monkey).

% is_bigger/2
is_bigger(X, Y) :-
	bigger(X, Y).

is_bigger(X, Y) :-
	bigger(X, Z),
	is_bigger(Z, Y).

% ---------------------

female(mary).
female(sandra).
female(juliet).
female(lisa).
male(peter).
male(paul).
male(dony).
male(bob).
male(harry).
parent(bob, lisa).
parent(bob, paul).
parent(bob, mary).
parent(juliet, lisa).
parent(juliet, paul).
parent(juliet, mary).
parent(peter, harry).
parent(lisa, harry).
parent(mary, dony).
parent(mary, sandra).

father_of(F, C) :-
	male(F),
	parent(F, C).

grandfather_of(G, C) :-
	father_of(G, P),
	parent(P, C).

sister_of(S, P) :-
	female(S),
	parent(X, S),
	parent(X, P),
	S \= P.

aunt_of(A, P) :-
	sister_of(A, X),
	parent(X, P).

% ---------------------

% distance/3
% distance(+P1, +P2, -D)
% ?- distance((0, 0), (3, 4), D).
% D = 5.0

distance((X1, Y1), (X2, Y2), D) :-
	D is sqrt((X2 - X1)**2 + (Y2 - Y1)**2).