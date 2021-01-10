% Первая часть задания - предикаты работы со списками

mylen([],0).   % Длина списка
mylen([_|Y],N) :- mylen(Y,N1), N is N1+1.

member(A,[A|_]).    % Принадлеждность списку
member(A,[_|Z]) :- member(A,Z).

append([],X,X).     % Конкатинация списков
append([A|X],Y,[A|Z]):- append(X,Y,Z).

remove(X,[X|T],T).      % Удаление элемента из списка
remove(X,[Y|T],[Y|T1]) :- remove(X,T,T1).

permute([],[]).     % Перестановки списка
permute(L,[X|T]) :- remove(X,L,R), permute(R,T).

sublist(S,L):-append(_,L1,L),append(S,_,L1). % Реализация подсписка

% Удаление трех последних элементов (с использованием стандартиных предикатов)
delete_three_last(_,[],3).
delete_three_last(X1,X2) :- mylen(X1,L), delete_three_last(X1,X2,L), !.
delete_three_last([X|T1],[X|T2],L) :- L1 is L-1, delete_three_last(T1,T2,L1).

% Вычисление среднего арифметического элементов (с использованием стандартных предикатов)
sum([],0).
sum([X|T],S) :- sum(T,S1), S is S1+X.
arithmetic_mean(T,X) :- mylen(T,L), arithmetic_mean(T,X,L).
arithmetic_mean(T,X,L) :- sum(T,S), X is S/L. 

% Удаление трех последних элементов (без использования стандартиных предикатов)
delete_three_last_([_,_,_],[]).
delete_three_last_([X|T1],[X|T2]) :- delete_three_last_(T1,T2),!.

% Вычисление среднего арифметического элементов (без использования стандартных предикатов)
arithmetic_mean_([],0,0).
arithmetic_mean_(T,X) :- arithmetic_mean_(T,S,C), X is S/C,!.
arithmetic_mean_([X|T],S,C) :- arithmetic_mean_(T,S1,C1), S is S1+X, C is C1+1.

% Нахождение разности среднего арифметического всех элементов и среднего арифметического элементов без последних трех (погрешность при вычислениях без последних трех элементов)
error_rate(T,E) :- arithmetic_mean_(T,X), delete_three_last_(T,T1), arithmetic_mean_(T1,Y), E is abs(X-Y),!.
