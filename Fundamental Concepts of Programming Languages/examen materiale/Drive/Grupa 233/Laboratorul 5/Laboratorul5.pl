% Ex 1 - num_aparitii/3
% num_aparitii(+List, +Elem, -NrApar).

num_aparitii([], _, 0).
num_aparitii([H | T], H, Res) :- 
	num_aparitii(T, H, ResTail),
	Res is ResTail + 1.
num_aparitii([_ | T], Elem, Res) :-
	num_aparitii(T, Elem, Res).

% Ex 2 - lista cifrelor unui numar

% listacifre/2
% listacifre(+Nr, -List).
% listacifre(2421, List).
% List = [2, 4, 2, 1].

% nu uitam de mod si div in Prolog

% X is 10 mod 3 REST
% X is 10 div 3 CAT

listacifre_aux(X, [X]) :- X < 10.
listacifre_aux(X, [C | T]) :-
	C is X mod 10,
	D is X div 10,
	listacifre_aux(D, T).

listacifre(Nr, List) :- 
	listacifre_aux(Nr, ListaRev),
	reverse(ListRev, List).

% lc(2048) -> cifra 8 [8, 4. 0, 2]
% lc(204) -> cifra 4 [4, 0, 2]
% lc(20) -> cifra 0 [0, 2]
% lc(2) -> [2]

% Ex 3 - lista permutarilor circulare
% listapermcirc([1,2,3], LP).
% LP = [[2,3,1], [3,1,2], [1,2,3]]

% permcirc / 2
permcirc([], []).
permcirc([H | T], L) :- append(T, [H], L).

% LInit     Perm   ListaPermutarilor
% [1,2,3] 	[2,3,1]  [[2,3,4] 
%	  	[3,1,2]  		, [3,1,2]
%         	[1,2,3]			, [1,2,3]]

% lpermcirc/3
% lpermcirc(+LInit, +PermCurenta, -LP).

lpermcirc(L, L, [L]).
lpermcirc(L, M, [M | LP]) :-
	permcirc(M, N),
	lpermcirc(L, N, LP).

listpermcirc(L, LP)  :-
	permcirc(L, M),
	lpermcirc(L, M, LP).

% listpermcirc([1,2,3], LP).

% Ex 4 - exercitiu cu multimi

% elimina / 3
% elimina(+List, +Elem, -ListFaraElem).
elimina([], _, []).
elimina([H | T], H, R) :-
	elimina(T, H, R).
elimina([H | T], Elem, [H | R]) :-
	elimina(T, Elem, R).

% pastrez H la rezultat daca H este diferit de elem 

% multimi / 1
% multimi (+List, -ListFaraDuplicate).
% [1,2,3,1,4,1,5]
% => ma uit daca la dreapta mai exista elementul
%     2,3,  4,1,5

%member/2

multime([],[]).
multime([H|T], R) :-
        member(H, T),
	multime(T, R).
multime([H|T], [H|R]) :-
	not(member(H, T)),
	multime(T, R).

% multime([1,2,3,1,4,1,5], R).

% emult / 1
% emult(+List). true daca lista este multime
 
emult(L) :-
	length(L, N1),
	multime(L, LM),
	length(LM, N2),
	N1 =:= N2.

emult1([]).
emult1([H | T]) :-
	emult1(T),
	not(member(H, T)).

% intersectie/3
% intersectie(+M1, +M2, -MR).
 
intersectie([], _, []).
intersectie([H|T], L, [H|R]) :-
	member(H, L),
	intersectie(T, L, R).
intersectie([H|T], L, R ) :-
	not(member(H, L)),
	intersectie(T, L, R).

% diff/3
% diff(+M1, +M2, -MR).
 
diff([], _, []).
diff([H|T], L, [H|R]) :-
	not(member(H, L)),
	diff(T, L, R).
diff([H|T], L, R ) :-
	member(H, L),
	diff(T, L, R).

% diff([1,2,3,4], [2,3], LR).

% prod_cartezian
% prod_cartezian(+M1, +M2, -MR).
% prod_cartezian([1,2], [3,4,5], LR).
% LP = [(1,3), (1,4), (1,5), (2,3), (2,4), (2,5)]

% produsul cartezian dintre un singleton si o lista
% [5] x [1,2,3]
% (5,1), (5,2), (5,3)
% X  [H | T]  => la fiecare pas adaug la rezultat (X, H)

element_ori_multime(_, [], []).
element_ori_multime(X, [H | T], [(X, H) | R]) :- 
	element_ori_multime(X, T, R).

produs_cartezian([], _, []).
produs_cartezian([H | T], L, R) :-
	element_ori_multime(H, L, R1),
	produs_cartezian(T, L, TailResult),
	append(R1, TailResult, R).

% produs_cartezian([1,2], [3,4,5], LR).

% In Prolog vom reprezenta arborii binari prin nil
% arb(+Radacina, +SubarboreStang, +SubarboreDrept).

% nil e arbore vid
% arb(ValFRunza, nil, nil) este o frunza
% arb(5, arb(4, nil, nil), arb(3, arb(2, nil, nil), arb(1, nil, arb(10, nil, nil)))).

% 			5
% 	4				3
%				2		1
%							10

% Parcurgerile
% SRD, RSD, SDR

% srd/2
srd(nil, []).
srd(arb(R, S, D), L) :-
	srd(S, Ls), 
	srd(D, Ld),
	append(Ls, [R], LTemp),  % append(Ls, [R | Ld], L).
	append(LTemp, Ld, L).

% rsd
rsd(nil, []).
rsd(arb(R, S, D), L) :-
	rsd(S, Ls),
	rsd(D, Ld),
	append([R | Ls], Ld, L).

% sdr
sdr(nil, []).
sdr(arb(R, S, D), L) :-
	sdr(S, Ls), 
	sdr(D, Ld),
	append(Ls, Ld, LTemp),
	append(LTemp, [R], L).


% frunze/2
% frunze(+Arb, -ListFrunze).
frunze(nil, []).
frunze(arb(X, nil, nil), [X]).
frunze(arb(_, S, D), L) :- 
	frunze(S, Ls),
	frunze(D, Ld),
	append(Ls, Ld, L).