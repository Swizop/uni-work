% importante:
% select(?Elem, ?List1, ?List2)
% Is true when List1, with Elem removed, results in List2.

% ?- atom_chars(hello, X).
% X = [h, e, l, l, o]

% name(alligator,L).
% ?- name(A, [97, 108, 108, 105, 103, 97, 116, 111, 114]).



% ?- length(List,4).

% is_list(L).
% not(..(L)).

% ?- append([a,b], [c], X).
% X = [a,b,c].

X =< Y
X =:= Y
X =\= Y

Q is div(X, Y),
M is mod(X, Y),

member(3, [1,2,3]).

[(X, H) | R]


write(’Hello World!’), nl. -> nl e new line




% 1. ultimul element al unei liste

my_last([], []).
my_last(X, [X]).
my_last(R, [H | T]) :-
	my_last(R, T).

% 2. penultimul element al unei liste
my_last2([X, _], X).
my_last2([_ | T], R) :-
	my_last2(T, R).

% 3. al k-lea element al listei
element_at([X | T], 1, X).
element_at([X | T], K, R) :-
	K1 is K - 1,
	element_at(T, K1, R).

% 4. lungimea listei
my_len([], 0).
my_len([X | T], R) :-
	my_len(T, R1),
	R is R1 + 1.

% 5. reverse list
my_rev([], []).
my_rev([X | T], [R | X]) :-
	my_rev(T, R).

% 6. palindrom
pali(X) :-
	my_rev(X, X1),
	X1 is X.


% 7. flatten list

flatten([], []).
flatten([H | T], L2) :-
    is_list(H),
    flatten(H, H1),
    flatten(T, T1),
    append(H1, T1, L2).

flatten([H | T], [H | T1]) :-
    not(is_list(H)),
    flatten(T, T1).

% 8. eliminarea elementelor consecutive

forbidden([], _, []).
forbidden([H | T], H, R) :-
	forbidden(T, H, R).
forbidden([H | T], X, [H | T]).

compress([], []).
compress([X], [X]).
compress([X, X | T], [X | R]) :-
	forbidden(T, X, R1),
	compress(R1, R).
compress([X | T], [X | R]) :-
    compress(T, R).

% 9. Pack consecutive duplicates of list elements into sublists.

nomore([], _, [], []).
nomore([X | T], X, R1, [X | R2]) :-
	nomore(T, X, R1, R2).
nomore([Y | T], X, [Y | T], []).


pack([], []).
pack([X], [[X]]).
pack([X | T], [R2 | R]) :-
	nomore([X | T], X, R1, R2),
	pack(R1, R).

% 10. Run-length encoding of a list.
% EX:
% ?- encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
% X = [[4,a],[1,b],[2,c],[2,a],[1,d][4,e]]


counting([], _, [], 0).
counting([X | T], X, R1, R3) :-
	counting(T, X, R1, R2),
	R3 is R2 + 1.

counting([Y | T], X, [Y | T], 0).


encode([], []).
encode([X], [1, [X]]).
encode([X | T], [[R2, X] | R]) :-
	counting([X | T], X, R1, R2),
	encode(R1, R).


% 11. Example:
% ?- encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
% X = [[4,a],b,[2,c],[2,a],d,[4,e]]

package([], _, [], 0).
package([X | T], X, Ramas, Nr) :-
	package(T, X, Ramas, NrNou),
	Nr is NrNou + 1.
package([Y | T], X, [Y | T], 0).

encode_modified([], []).
encode_modified([X, X | T], [[Nr, X] | Rez]) :-
	package([X, X | T], X, L2, Nr),
	encode_modified(L2, Rez).
encode_modified([Y | T], [Y | Rez]) :-
	encode_modified(T, Rez).


% 12. Decode pentru forma de la 11.

unpacking([0, _], []).
unpacking([X, Y], [Y | Rez]) :-
	X1 is X - 1,
	unpacking(X1, Rez).

decode([], []).
decode([X | T], R2) :-
	is_list(X),
	unpacking(X, Rez),
	decode(T, R),
	append(Rez, R, R2).
decode([X | T], [X | R]) :-
	not(is_list(X)),
	decode(T, R).

% 14. Duplicate the elements of a list.

dupli([], []).
dupli([X | T], R) :-
	dupli(T, R2),
	append([X, X], R2, R).


% 15. Duplicare cu nr specificat de ori
% ?- dupli([a,b,c],3,X).
% X = [a,a,a,b,b,b,c,c,c]

auxdupli(_, 0, []).
auxdupli(X, Y, [X | R1]) :-
	Y1 is Y - 1,
	auxdupli(X, Y1, R1).


dupli2([], _, []).
dupli2([X | T], Y, R) :-
	auxdupli(X, Y, Rez),
	dupli2(T, Y, R2),
	append(Rez, R2, R).

% 16. Drop every N'th element from a list.

dropaux([], _, _, []).
dropaux([H | T], N, N, R) :-
	dropaux(T, 1, N, R).
dropaux([H | T], M, N, [H | R]) :-
	M1 is M + 1,
	dropaux(T, M1, N, R).


drop(L, N, R) :-
	dropaux(L, 1, N, R).

% 17. Split a list into two parts; the length of the first part is given.
% split([a,b,c,d,e,f,g,h,i,k],3,L1,L2).
% L1 = [a,b,c]
% L2 = [d,e,f,g,h,i,k]



split(L, 0, [], L).
split([H | T], N, [H | R1], R2) :-
	N1 is N - 1,
	split(T, N1, R1, R2).


% 18. extract slice from list, parametri sunt inclusi
% ?- slice([a,b,c,d,e,f,g,h,i,k],3,7,L).
% X = [c,d,e,f,g]

sliceaux([H | T], Nr, Nr, [H]).
sliceaux([H | T], X, Nr, [H | R]) :-
	X1 is X + 1,
	sliceaux(T, X1, Nr, R).

slicepass([H | T], Nr, Nr, Last, R) :-
	sliceaux([H | T], Nr, Last, R).
slicepass([H | T], X, Nr, Last, R) :-
	X1 is X + 1,
	slicepass(T, X1, Nr, Last, R).

slice(L, First, Last, R) :-
	slicepass(L, 1, First, Last, R).


% 19.  Rotate a list N places to the left.
% ?- rotate([a,b,c,d,e,f,g,h],3,X).
% X = [d,e,f,g,h,a,b,c]


% ?- rotate([a,b,c,d,e,f,g,h],-2,X).
% X = [g,h,a,b,c,d,e,f]

% FOLOSIM PROBLEMA 17
rotatepositive(L, N, R) :-
	split(L, N, L1, L2),
	append(L2, L1, R).

rotatenegative(L, N, R) :-
	length(L, X),
	X1 is N + X,
	split(L, X1, L1, L2),
	append(L2, L1, R).	

rotate(L, N, R) :-
	N >= 0,
	rotatepositive(L, N, R).

rotate(L, N, R) :-
	N < 0,
	rotatenegative(L, N, R).


% 20. ?- remove_at(X,[a,b,c,d],2,R).
% X = b
% R = [a,c,d]

remove_at_aux(_, [], _, _, []).
remove_at_aux(X, [X | T], Pos, Pos, R) :-
	X1 is Pos + 1,
	remove_at_aux(X, T, X1, Pos, R).
remove_at_aux(X, [Y | T], I, Pos, [Y | R]) :-
	I1 is I + 1,
	remove_at_aux(X, T, I1, Pos, R).

remove_at(X, L, Nr, R) :-
	remove_at_aux(X, L, 1, Nr, R).




% 21. insert element at given pos
% ?- insert_at(alfa,[a,b,c,d],2,L).
% L = [a,alfa,b,c,d]



insert_at_aux(X, L, Pos, Pos, [X | L]).
insert_at_aux(X, [H | T], Pos, Target, [H | R]) :-
	Pos1 is Pos1 + 1,
	insert_at_aux(X, T, Pos1, Target, R).

insert_at(X, L, Pos, R) :-
	insert_at_aux(X, L, 1, Pos, R).



% 22. Create a list containing all integers within a given range.


range(X, X, [X]).
range(X, Y, [X | R]) :-
	X1 is X + 1,
	range(X1, Y, R).


% 23. Extract a given number of randomly selected elements from a list.




% LAB 5
% 1. ?-num aparitii([2,5,2,6,3,4,2,1],2,Result).
% ar trebui s ̆a obt ̧inet ̧i Result = 3.


num_ap([], _, 0).
num_ap([H | T], H, R) :-
	num_ap(T, H, R1),
	R is R1 + 1.
num_ap([H | T], K, R) :-
	num_ap(T, K, R).


% 2. lista cifre ?-lista cifre(23423, [2,3,4,2,3]). => True

lista_cifreaux(0, []).
lista_cifreaux(X, R) :-
	X1 is div(X, 10),
	lista_cifreux(X1, R1),
	X2 is mod(X, 10),
	append(R1, X2, R).

lista_cifre(0, [0]).
lista_cifre(X, R) :-
	lista_cifreaux(X, R).



% 3. listpermcirc([1,2,3],L).
% L = [[2, 3, 1], [3, 1, 2], [1, 2, 3]] .

% fct care returneaza toata lista pana la ultimul el.
% PENTRU PERM LA DREAPTA:
%listpermaux([H | T], [H], T) :-
%	length(T, 1).
%listpermaux([H | T], [H | R], R2) :-
%	not(length(T, 1)),
%	listpermaux(T, R, R2).

%PERM LA STG:
listpermaux([H | T], [H], T).

listpermsecond(Fin, Fin, [Fin]).
listpermsecond(Curr, Fin, [Curr | R]) :-
	listpermsecond(Curr, L1, L2),
	append(L2, L1, L3),
	listpermsecond(L3, Fin, R).

listpermcirc([], []).
listpermcirc([X], [[X]]).
listpermcirc(L, R) :-
	listpermaux(L, L1, L2),
	append(L2, L1, L3),
	listpermsecond(L3, L, R).




% 4. a. ̧sterge toate aparit ̧iile unui element dintr-o list ̆a dat ̆a ca parametru
% ?- elimina([1,2,4,2,3], 2,L).
% L = [1, 4, 3] .

elimina([], _, []).
elimina([H | T], H, R) :-
	elimina(T, H, R).
elimina([H | T], K, [H | R]) :-
	elimina(T, K, R).



% 4. b. multime([1,2,4,2,3,2,1,2,5,3], L). => L = [1, 2, 4, 3, 5] . transforma list in set

multime([], []).
multime([H | T], [H | R]) :-
	elimina(T, H, T1),
	multime(T1, R).


% 4. c. emult -> true daca L e multime

emult([]).
emult([H | T]) :-
    not(member(H, T)),
    emult(T).




% 5. 1. intersectie 2 multimi

inters([], _, []).
inters([H | T], L2, [H | R]) :-
	member(H, L2),
	inters(T, L2, R).
inters([H | T], L2, R) :-
	not(member(H, L2)),
	inters(T, L2, R).


% 5. 2. diferenta intre 2 multimi

dif([], _, []).
dif([H | T], L2, R) :-
	member(H, L2),
	dif(T, L2, R).
dif([H | T], L2, [H | R]) :-
	not(member(H, L2)),
	dif(T, L2, R).

% 5. 3. prod cartezian prod cartezian([1,2,3],[4,5,6],L).
% L = [(1, 4), (1, 5), (1, 6), (2, 4), (2, 5), (2, 6), (3, 4), (3, 5), (3, 6)]

prodcartaux(X, [], []).
prodcartaux(X, [H | T], [[X, H] | R]) :-
	prodcartaux(X, T, R).

prod_cart([], _, []).
prod_cart([H | T], L2, R) :-
	prod_cart(T, L2, R1),
	prodcartaux(H, L2, R2),
	append(R2, R1, R).



% 6. postordine, inordine, preordine
% nil va fi arborele vid;
%  arb(Radacina,SubarboreStang,SubarboreDrept) va fi un arbore nevid.
% srd(arb(1,arb(2,nil,arb(3,nil,nil)),arb(4,arb(5,nil,nil),arb(6,nil,nil))),L).
% L = [2, 3, 1, 5, 4, 6].

srd(nil, []).
srd(arb(X, SS, SD), R) :-
	srd(SS, R1),
	srd(SD, R2),
	append(R1, [X | R2], R).

rsd(nil, []).
rsd(arb(X, SS, SD), R) :-
	srd(SS, R1),
	srd(SD, R2),
	append([X | R1], R2, R).




sdr(nil, []).
sdr(arb(X, SS, SD), R) :-
	sdr(SS, R1),
	sdr(SD, R2),
	append(R1, R2, R3),
	append(R3, [X], R).


% 6. b. lista frunzelor (ex: [3,5,6])

listafrunze(nil, []).
listafrunze(arb(X, nil, nil), [X]).
listafrunze(arb(X, SS, SD), R) :-
	listafrunze(SS, R1),
	listafrunze(SD, R2),
	append(R1, R2, R).










