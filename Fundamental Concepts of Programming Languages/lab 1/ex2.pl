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

father_of(X, Y) :- parent(X, Y), male(X).
mother_of(X, Y) :- parent(X, Y), female(X).
grandfather_of(X, Y) :- father_of(X, Z), parent(Z, Y).
grandmother_of(X, Y) :- mother_of(X, Z), parent(Z, Y).
sister_of(X, Y) :- female(X), parent(Z, X), parent(Z, Y).
brother_of(X, Y) :- male(X), parent(Z, X), parent(Z, Y).
aunt_of(X, Y) :- sister_of(X, Z), parent(Z, Y).
uncle(X, Y) :- brother_of(X, Z), parent(Z, Y).

person(X) :- male(X).
person(X) :- female(X).
not_parent(X,Y) :- person(X), person(Y), \+ parent(X,Y).