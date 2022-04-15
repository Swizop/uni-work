smallstepA(I1 + I2, S, I, S) :-
  integer(I1), integer(I2),
  I is I1 + I2.

smallstepA(AE1 + I, S, AE2 + I, S) :-
  integer(I),
  smallstepA(AE1, S, AE2, S).

smallstepA(I + AE1,S,I + AE2,S) :-
  integer(I),
  smallstepA(AE1, S, AE2, S).



% DIF

smallStepA(I1 - I2, S, I, S) :-
    integer(I1), integer(I2), 
    I is I1 - I2.

smallStepA(I - A1, S, I - A2, S) :-
    integer(I),
    smallStepA(A1, S, A2, S).

smallStepA(A1 - I, S, A2 - I, S) :-
    integer(I),
    smallStepA(A1, S, A2, S).


% MUL
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