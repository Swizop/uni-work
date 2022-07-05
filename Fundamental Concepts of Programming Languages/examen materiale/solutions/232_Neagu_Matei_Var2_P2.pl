% 232 Neagu Matei - varianta 2

e(Mem) :- integer(Mem).
e(Expr + Expr) :- e(Expr), e(Expr).

p([Mem], Mem, []) :-
    e(Mem).
p([N | Prog], N, [H | T]) :-
    e(N),
    e(H),
    p(Prog, H, T).

