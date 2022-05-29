% 2. projekt IZU. 
% Autor: Marina Kravchuk (xkravc02)

max_list([], _Max):-!, fail.
max_list([Head|Tail], Tailmax):- max_list(Tail, Tailmax), Tailmax > Head, !.
max_list([Head|_Tail], Head).

min_list([], _Min):-!, fail.
min_list([Head|Tail], Tailmin):- min_list(Tail, Tailmin), Tailmin < Head, !.
min_list([Head|_Tail], Head).

u4(List, VOUT) :- max_list(List, MAX), min_list(List, MIN), VOUT is MAX - MIN.
%%------------- FAKTA, PRAVIDLA, REKURZE
rodic(karel, jirka).
rodic(jirka, zuzana).
rodic(jirka, pavel).
rodic(zuzana, lenka).
rodic(pavel, honza).

zena(zuzana).
muz(pavel).

predek(X,Y) :- rodic(X,Y).
predek(X,Y) :- rodic(X,Z), predek(Z, Y).

%% bagof(Y, predek(jirka, Y), S).
%%--------------

%%------------- REZY
%%- bez rezu
max1(X,Y,Y) :- X =< Y.
max1(X,Y,X) :- X > Y.

%%- zeleny rez
max2(X,Y,Y) :- X =< Y, !.
max2(X,Y,X) :- X > Y.

%%- cerveny rez
max3(X,Y,Y) :- X =< Y, !.
max3(X,_,X).

aaa(adam).
aaa(petr).

doit(X) :- aaa(X), !.
%%--------------

%%------------- SEZNAMY
%%- hlavicka|telo
lst([]) :- write('empty').
lst([H|T]) :- write(H), write('|'), write(T).

%%- pruchod seznamem
lst2([]) :- write('[]').
lst2([H|T]) :- write(H), write(', '), lst2(T).

%%- nalezeni prvku v seznamu na N. pozici (indexovano od 0)
%%- find(2, [1,2,3,4,5,6,7,8], Z). -> Z=3
find(0, [H|_], H) :- !.
find(N, [_|T], R) :- N > 0, NN is N-1, find(NN, T, R).

%%- totez s pouzitim ztotozneni (=)
find2(N, [H|_], R) :- N = 0, !, H = R.
find2(N, [_|T], R) :- N > 0, NN is N-1, find2(NN, T, R).
%%--

%%- zjisteni pritomnosti prvku X v seznamu
member(X, [X|_]) :- !.
member(X, [_|S]) :- member(X, S).

aa(X, S) :- member(X, S).
aa(X, S, Y) :- \+member(X, S), Y = X.

%%- prunik dvou seznamu (mnozin) A a B, vysledny seznam S
%%- prunik(A, B, S)
%% prunik s prazdnou mnozinou je prazdna mnozina
prunik([], _, []).
%% prvek X je v S2 -> X bude ve vystupnim seznamu, prohledavame dale bez X
prunik([X|S1], S2, [X|S]) :- member(X,S2), !, prunik(S1, S2, S).
%% (v1) prvek X neni v S2 -> prohledavame dale bez X
% prunik([X|S1], S2, S) :- \+member(X,S2), prunik(S1, S2, S).
%% (v2) prvni prvek (_) neni v S2 (nutno pouzit s rezem v predchozim pravidlu) -> prohledavame dale bez X
prunik([_|S1], S2, S) :- prunik(S1, S2, S).

%%- totez s vypisem, ktere pravidlo se pouzilo
prunik2([], _, []) :- write('1').
prunik2([X|S1], S2, [X|S]) :- write('2'), member(X,S2), !, prunik2(S1, S2, S).
% prunik2([X|S1], S2, S) :- write('3'), \+member(X,S2), prunik2(S1, S2, S).
prunik2([_|S1], S2, S) :- write('3'), prunik2(S1, S2, S).
%--------------