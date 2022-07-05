% Laboratorul 3 FLP 

% Lab1: sintaxa limbajului Prolog. 
% Lab2: recursivitate si liste in Prolog. 
% concat_lists/3; reverse/3 

% Laboratorul 3: cum raspunde Prolog intrebarilor? 

% Algoritmul de unificare 

% Substitutia este o functie partiala de la multimea variabilelor in multimea termenilor. 
% sigma : Var -> Trm(L) 

% spunem ca doi termeni t1 si t2 unifica daca exista o substitutie theta
% astfel incat theta(t1) = theta(t2)

% Algoritmul de unificare 

% x variabla si t termen 
% T[t/x] = t il substituie pe x in T 
% Operatie in algoritm 		Multimea solutiei			Lista de rezolvat
%				 	S				      R
% =========================================================================================================
% Initial			multimea vida 			t1=t1', t2=t2', ... tn=tn' 
% ---------------------------------------------------------------------------------------------------------
% SCOATE		 	     S 				R', t = t 
%                                    S  			R' 
% ---------------------------------------------------------------------------------------------------------
% DESCOMPUNE			     S				R', f(t1, t2, ..., tn) = f(t1', t2', ..., tn')
%				     S				R', t1=t1', t2=t2', ..., tn=tn' 
% ----------------------------------------------------------------------------------------------------------
% REZOLVA			     S				R', x=t sau t=x astfel incat x nu apare in t 
% 				x=t, S[t/x]			R'[t/x]
% ----------------------------------------------------------------------------------------------------------
% Final				     S 					multimea vida 
% S este unificatorul pentru termenii dati initial in multimea (lista) de rezolvat 

% Algoritmul nu gaseste un unificator, respectiv obtine ESEC in urmatoarele situatii:
% - daca incercam sa unificam simboluri de functii diferite, obtinem esec 
% 		f(t1, t2, ..., tn) = g(t1', t2', ... tk')
% constantele sunt simboluri de functii de aritate 0 
% a constanta, f simbol de functie de aritate 1, f(x) = a ESEC 
% - daca avem o egalitate in lista de rezolvat de forma x = t sau t = x, dar x este variabila in t. 

% Exercitii
% simboluri de variabile: x, y, z, u, v 
% constante: a, b, c 
% functii de aritate 1: h, g, (_)^(-1)
% functii de aritate 2: f, +, *
% functii de aritate 3: p 


% Exercitiul 1:
% Sa se gaseasca un unificator pentru termenii p(a, x, h(g(y))) si p(z, h(z), h(u)).
% Solutie: 
% Lista solutiei					Lista de rezolvat			Operatie
% multimea vida					p(a, x, h(g(y))) = p(z, h(z), h(u))		DESCOMPUNE
% multimea vida					a = z, x = h(z), h(g(y)) = h(u)			DESCOMPUNE
% multimea vida 				a = z, x = h(z), g(y) = u			REZOLVA
% z = a						x = h(a), g(y) = u				REZOLVA
% z = a, x = h(a)				g(y) = u					REZOLVA
% z = a, x = h(a), u = g(y)			multimea vida					Final

% Am gasit unificatorul { a/z, h(a)/x, g(y)/u }

% Exercitiul 2:
% Sa se gaseasca un unificator pentru termenii f(h(a), g(x)) = f(y, y).
% Solutie:
% Lista solutiei					Lista de rezolvat			Operatie
% multimea vida					f(h(a), g(x)) = f(y, y)				DESCOMPUNE
% multimea vida					h(a) = y, g(x) = y				REZOLVA
% y = h(a)					g(x) = h(a)					ESEC
% nu exista un unificator pentru cei doi termeni

% Exercitiul 3:
% Sa se gaseasca un unificator pentru termenii p(a, x, g(x)) = p(a, y, y).
% Solutie:
% Lista solutiei					Lista de rezolvat			Operatie
% multimea vida 				p(a, x, g(x)) = p(a, y, y)			DESCOMPUNE
% multimea vida					a = a, x = y, g(x) = y				SCOATE
% multimea vida					x = y, g(x) = y					REZOLVA
% x = y 					g(y) = y 					ESEC
% nu exista un unificator pentru cei doi termeni 

% Exercitiul 4:
% Sa se gaseasca un unificator pentru termenii x + (y * y) = (y * y) + z.
% Solutie:
% +(x, *(y, y)) = +(*(y, y), z)
% Lista solutiei					Lista de rezolvat			Operatie 
% multimea vida					x + (y * y) = (y * y) + z			DESCOMPUNE
% multimea vida					x = y * y, y * y = z 				REZOLVA
% x = y * y 					y * y = z 					REZOLVA
% x = y * y, z = y * y 				multimea vida					Final
% exista unificatorul { y*y/x, y*y/z }

% TEMA: (x*y)*z = u*(u)^(-1)

% Exercitiul 1 - rebusul 


word(abalone,a,b,a,l,o,n,e).
word(abandon,a,b,a,n,d,o,n).
word(anagram,a,n,a,g,r,a,m).
word(connect,c,o,n,n,e,c,t).
word(elegant,e,l,e,g,a,n,t).
word(enhance,e,n,h,a,n,c,e).

crossword(V1, V2, V3, H1, H2, H3) :-
	word(V1, _, A, _, B, _, C, _),
	word(V2, _, D, _, E, _, F, _),
	word(V3, _, G, _, H, _, I, _),
	word(H1, _, A, _, D, _, G, _),
	word(H2, _, B, _, E, _, H, _),
	word(H3, _, C, _, F, _, I, _).


% Exercitiul 2 - baza de date 

born(jan, date(20,3,1977)).
born(jeroen, date(2,2,1992)).
born(joris, date(17,3,1995)).
born(jelle, date(1,1,2004)).
born(joan, date(24,12,0)).
born(joop, date(30,4,1989)).
born(jannecke, date(17,3,1993)).
born(jaap, date(16,11,1995)).


% date(Day, Month, Year)

% year / 2 
% year(+Year, -Person). 

year(Year, Person) :-
	born(Person, date(_,_,Year)).

% before / 2 
before(date(D1, M1, Y1), date(D2, M2, Y2)) :-
	Y1 < Y2 ;
	Y1 =:= Y2, M1 < M2 ;
	Y1 =:= Y2, M1 =:= M2, D1 < D2. 



% older / 2 
older(X, Y) :-
	born(X, DateX),
	born(Y, DateY),
	before(DateX, DateY).
	

% Exercitiul 3 - labirintul 

% connected(1,2).
% connected(3,4).
% connected(5,6).
% connected(7,8).
% connected(9,10).
% connected(12,13).
% connected(13,14).
% connected(15,16).
% connected(17,18).
% connected(19,20).
% connected(4,1).
% connected(6,3).
% connected(4,7).
% connected(6,11).
% connected(14,9).
% connected(11,15).
% connected(16,12).
% connected(14,17).
% connected(16,19).

connected(1,2).
connected(2,1).
connected(1,3).
connected(3,4).

% path / 2 
% path(X, Y) - true daca exista un drum de la X la Y 

path(X, Y) :- connected(X, Y).
path(X, Y) :- 
	connected(X, Z),
	path(Z, Y).

% Tema: solutia pentru a elimina ciclurile este sa avem o lista de noduri vizitate 

% path(X, Y, ListaElemVizitate)
% path(X, Y, V) :- not(member(X, V)), connected(X, Z), path(Z, Y, [X | V]).


% Exercitiul 4 - reprezentarea numerelor naturale ca liste 
% 0 = [], 1 = [x], 2 = [x, x] 

succesor(L, [x | L]).

plus(L1, L2, LR) :-
	append(L1, L2, LR).


times([], _, []).
times([x | T], L2, LR) :-
	times(T, L2, ListTail),
	plus(L2, ListTail, LR).

% element_at / 3 
% element_at(+List, +Index, -ElemDePeIndex). 

element_at([H | _], 0, H).
element_at([_ | T], Index, Result) :-
	NewIndex is Index - 1,
	element_at(T, NewIndex, Result).


% mutantii 

animal(alligator). 
animal(tortue).
animal(caribou).
animal(ours).
animal(cheval).
animal(vache).
animal(lapin).

% mutant/1 


mutant(X) :-
	animal(Y),
	animal(Z),
	Y \= Z,
	name(Y, Ly),
	name(Z, Lz),
	append(Y1, Y2, Ly),
	append(Y2, _, Lz),
	Y2 \= [],
	append(Y1, Lz, Lx),
	name(X, Lx).

% exista o factorizare a listei Ly, Y1 ++ Y2 = Ly
% exista o factorizare a listei Lz, Y2 ++  _ = Lz	




