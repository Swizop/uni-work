% ?- unify_with_occurs_check(A, f(A)).
% false.

%x, y, z, u, v simboluri pt variabile
%a, b, c constante
%h, g, (_)^(-1) fct de aritate 1
%f, +, * fct de aritate 2
% p functie de aritate 3


% 1. sa se gaseasca un unificator pt termenii p(a, x, h(g(y))) si
%		p(z, h(z), h(u)).

%Solutie:
% Lista solutiei			Lista de rez			Op aplicata
% mult vida			p(a, x, h(g(y))) = p(z, h(z), h(u))	=> DESCOMPUNERE
% mult vida			a = z, x = h(z), h(g(y)) = h(u)
%									=> DESCOMPUNE

% mult vida			a = z, x = h(z), g(y) = u		=> REZOLVA
% z = a				x = h(a), g(y) = u			=> REZOLVA
% z = a, x= h(a)		g(y) = u			REZOLVA
% z = a, x = h(a), u = g(y)		VIDA					FINAL
% unificatorul este { a/z, h(a)/x, g(y)/u }


% 2. f(h(a), g(x)) = f(y, y)
% (unificam f(h(a), g(x) cu .....)
%SOL					L DE REZ			OP
%vid				f(h(a), g(x)) = f(y, y)		    DESCOMPUNERE

%vid				h(a) = y, g(x) = y		REZOLVA
% y = h(a)			g(x) = h(a)			ESEC
% incerc sa unific 2 chestii care nu au aceeasi structura => nu e un unificator pt cei 2 termeni



%3. p(a, x, g(x)) = p(a, y, y)

%SOL 				L DE REZ				OP
%vid				p(a, x, g(x)) = p(a, y, y)		DESC
%vid				a = a, x = y, g(x) = y			SCOATE
%vid				x = y, g(x) = y				REZOLVA
%x = y				g(y) = y				ESEC
% nu exista un unificator pt cei 2 termeni


%unify_with_occurs_... (din laborator)



% 4. x + (y * y) = (y * y) + z

%SOL				LIS DE REZ			OPERATIE
%mult vida			x + (y * y) = (y * y) + z		DESC


%%%%%%%% PUTEM VEDEA TERMENII CA FIIND +(x, *(y, y)) = +(*(y,y), z)
%vid				x = (y *y), (y*y) = z		REZOLVA
%x = y * y			(y * y) = z			REZOLVA
%x=y*y, z=y*y				vid			Final

%exista un unificator, {y * y/x, y*y/z}

%TEMA: (x*y) * z = u * u^(-1)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

born(jan, date(20,3,1977)).
born(jeroen, date(2,2,1992)).
born(joris, date(17,3,1995)).
born(jelle, date(1,1,2004)).
born(joan, date(24,12,0)).
born(joop, date(30,4,1989)).
born(jannecke, date(17,3,1993)).
born(jaap, date(16,11,1995)).
% year / 2 - gaseste toate persoanele nascute intr-un anumit an

year(Year, Person) :- born(Person, date(_, _, Year)).

% before/2 care verifica daca o data este mai mica decat o alta data

before(date(D1, M1, Y1), date(D2, M2, Y2)) :- 
	Y1 < Y2;
	Y1 =:= Y2, M1 < M2 ;
	Y1 =:= Y2, M1 =:= M2, D1 < D2.

older(X, Y) :-
	born(X, Date1),
	born(Y, Date2),
	before(Date1, Date2).



% ex 3 - connected _ path

connected(1, 2).
connected(2, 1).
connected(1, 3).
connected(3, 4).

% path / 2
% path (X, Y) este true daca exista drum de la X la Y

path(X, Y) :- connected(X, Y).
path(X, Y) :-
	connected(X, Z), path(Z, Y).
%rezolvarea asta ignora ciclurile

%tema: sa se implementeze path cu lista de vizitat



% succesor/2
succesor(List, [x|List]).


% plus / 3
% plus(+L1, +L2, -LR).
% plus([x,x], [x,x,x], LR).
% LR = [x,x,x,x,x]

plus(L1, L2, LR) :-
	append(L1, L2, LR).

% times / 3
% inmultirea a 2 liste
%listele au doar x in ele

times([], _, []).
times([x | T], L2, LR) :-
	times(T, L2, LTail),
	plus(L2, LTail, LR).
%spun ca n * m e acelasi lucru ca (n-1) * m + n  (asta fac mai sus)


% element_at / 3
% element_at(+List, +Index, -ElemenDePePozIndex)

element_at([H | _], 0, H).
element_at([_ | T], Index, Result) :-
	NewIndex is Index - 1,
	element_at(T, NewIndex, Result).



%%%%%%%%%%%%%%%%%%%%%%%

/* Animal  database */

animal(alligator). 
animal(tortue).
animal(caribou).
animal (ours).
animal(cheval).
animal(vache).
animal(lapin).



mutant(X) :-
	animal(Y),
	animal(Z),
	Y \= Z,
	name(Y, Ly),		%luam lista lor de caractere
	name(Z, Lz),
	append(Y1, Y2, Ly),	%exista un y1 y2 a.i. y1 e prefixul lui Y si y2 e sufixul lui
	append(Y2, _, Lz),	% trebuie ca sufixul lui Y sa fie prefixul lui z
	Y2 \= [],
	append(Y1, Lz, Lx),	% luam prefixul ala al lui y (pentru ca y2 = prefixul lui z si nu vrem duplicat,
					% ignoram pe y2) si il concatenam cu intreg zul
	name(X, Lx).		%vedem pentru care string X avem lista Lx

% exista Y1, Y2 a.i Y1 %% Y2 ==  
