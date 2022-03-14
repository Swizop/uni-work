% zebra puzzle

% 5 case cu 5 atribute
% numarul casei (1 - 5)
% nationalitatea proprietarului
% culoarea casei
% animal de companie
% bautura preferata
% tigari fumate

% trb determinat ce nationalitate e cel care detine o zebra
% member (.., Strada) <=> ce e in stanga se incadreaza intr o strada

casa(Numar, Nationalitate, Culoare, Animal, Bautura, Tigari).


la_dreapta(X, Y) :- X is Y + 1.
la_stanga(X, Y) :- la_dreapta(Y, X).
langa(X, Y) :- la_dreapta(X, Y) ; la_stanga(X, Y).


solutie(Strada, PosesorZebra) :-
	Strada = [
		casa(1, _, _, _, _, _),
		casa(2, _, _, _, _, _),
		casa(3, _, _, _, _, _),
		casa(4, _, _, _, _, _),
		casa(5, _, _, _, _, _)
	],
	member(casa(_, englez, rosie, _, _, _), Strada),
	member(casa(_, spaniol, _, caine, _, _), Strada),
	member(casa(A, _, verde, _, _, _), Strada),
	member(casa(B, _, bej, _, _, _), Strada),
	la_dreapta(A, B),
	member(casa(_, _, verde, _, cafea, _), Strada),
	member(casa(_, ucrainean, _, _, ceai, _), Strada),
	member(casa(_, _, _, melci, _, 'Old Gold'), Strada),
	member(casa(C, norvegian, _, _, _, _), Strada),
	member(casa(D, _, albastru, _, _, _), Strada),
	langa(C, D),
	member(casa(_, _, galben, _, _, 'Kools'), Strada),
	
	member(casa(1, norvegian, _, _, _, _), Strada),
	member(casa(3, _, _, _, lapte, _), Strada),
	member(casa(E, _, _, _, _, 'Chesterfields'), Strada),
	member(casa(F, _, _, vulpe, _, _), Strada),
	langa(E, F),
	member(casa(G, _, _, cal, _, _), Strada),
	member(casa(H, _, _, _, _, 'Kools'), Strada),
	langa(G, H),
	member(casa(I, _, _, _, suc, 'Lucky Strike'), Strada),
    	member(casa(_,PosesorZebra,_,zebra,_,_), Strada),
    	member(casa(_, japonez, _, _, _, 'Parilaments'), Strada).

% apel: solutie(Strada, PosesorZebra).
% ar trebui japonezul
%TEMA


% words.pl   -> se dau cuvinte din lb engleza
% -> sa se gaseasca cel mai lung cuv din engleza care poate fi format folosind toate sau o parte dintr-o lista de litere

%cum includem fisierul nostru 
:- include('words.pl').

% util:
% atom_chars/2
% atom_chars(Word, Letters) are ca efect obtinerea listei de litere in letters
% pentru cuvantul Word
% atom_chars(hello, X).
% X = [h, e ,l, l, o]

:- include('words.pl').
cover([], _).
cover([H | T], L) :-
	select(H, L, R),
	cover(T, R).

solution(ListLetters, Word, Score) :-
	word(Word),
	atom_chars(Word, Letters),
	length(Letters, Score),
	cover(letters, ListLetters).

search_solution(_, 'no solution, 0).
search_solution(ListLetters, Word, X) :-
	solution(ListLetters, Word, X).
search_solution(ListLetters, Word, X) :-
	Y is X - 1,
	search_solution(ListLetters, Word, Y).

topsolution(ListLetters, Word) :-
	length(ListLetters, Score),
	search_solution(ListLetters, Word, Score).

% ?- topsolution([y,c,a,l,b,e,o,s,x], X).