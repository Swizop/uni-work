% tema: DIF

smallStepA(I1 - I2, S, I, S) :-
    integer(I1), integer(I2), 
    I is I1 - I2.

smallStepA(I - A1, S, I - A2, S) :-
    integer(I),
    smallStepA(A1, S, A2, S).

smallStepA(A1 - I, S, A2 - I, S) :-
    integer(I),
    smallStepA(A1, S, A2, S).


% tema: MUL
% MUL1: <i1 * i2, S> -> <i, S> ; daca i = i1 * i2

smallStepA(I1 * I2, S, I, S) :-
    integer(I1), integer(I2), 
    I is I1 * I2.

% MUL2: <a1, S> -> <a2, S> => <i * a1, S>, <i * a2, S>
smallStepA(I * A1, S, I * A2, S) :-
    integer(I),
    smallStepA(A1, S, A2, S).

% MUL3: <a1, S> -> <a2, S>	=> <a1 * i, S>, <a2 * i, S>
smallStepA(A1 * I, S, A2 * I, S) :-
    integer(I),
    smallStepA(A1, S, A2, S).



% tema: GEQ
% (GEQ-FALSE) <i1 >= i2, S> -> <false, S> daca i1 < i2
smallstepB(I1 >= I2, S, false, S) :-
    integer(I1),
    integer(I2),
    I1 < I2.

% (GEQ-TRUE) <i1 >= i2, S> -> <true, S> daca i1 >= i2
smallstepB(I1 >= I2, S, true, S) :-
    integer(I1), integer(I2), 
    I1 >= I2.

% (GEQ1) <a1, S> -> <a2, S> => <a1 >= a3, S> -> <a2 >= a3, S>
smallstepB(AE1 >= I, S, AE2 >= I, S) :-
    integer(I),
    smallstepA(AE1, S, AE2, S).

% (GEQ2) <a1, S> -> <a2, S> => <a3 >= a1, S> -> <a3 >= a2, S>
smallstepB(I >= AE1, S, I >= AE2, S) :-
    integer(I),
    smallstepA(AE1, S, AE2, S).



% tema: EQ
% (EQ-FALSE) <i1 == i2, S> -> <false, S> daca i1 != i2
smallstepB(I1 =:= I2, S, false, S) :-
    integer(I1),
    integer(I2),
    I1 =\= I2.

% (EQ-TRUE) <i1 == i2, S> -> <true, S> daca i1 == i2
smallstepB(I1 =:= I2, S, true, S) :-
    integer(I1), integer(I2), 
    I1 =:= I2.

% (EQ1) <a1, S> -> <a2, S> => <a1 == a3, S> -> <a2 == a3, S>
smallstepB(AE1 =:= I, S, AE2 =:= I, S) :-
    integer(I),
    smallstepA(AE1, S, AE2, S).

% (EQ2) <a1, S> -> <a2, S> => <a3 == a1, S> -> <a3 == a2, S>
smallstepB(I =:= AE1, S, I =:= AE2, S) :-
    integer(I),
    smallstepA(AE1, S, AE2, S).


% tema: disjunctie
% (OR1) <or(true, _), S> -> <true, S>
smallstepB(or(true, _), S, true, S).

% (OR2) <or(false, BE2), S> -> <BE2, S>
smallstepB(or(false, BE2), S, BE2, S).

% (OR3) <BE1, S> -> <BE2, S> => <or(BE1, BE), S> -> <or(BE2, BE), S>
smallstepB(or(BE1, BE), S, or(BE2, BE), S) :-
    smallstepB(BE1, S, BE2, S).