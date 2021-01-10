% Task 2: Relational Data

% The line below imports the data
:- encoding(utf8).
:- ['three.pl'].

% Сумма элементов в списке
sum([],0).
sum([grade(_,M)|T],S) :- sum(T,S1), S is S1+M.

% Длина списка
mylen([],0).
mylen([_|Y],N) :- mylen(Y,N1), N is N1+1.

% Максимальный элемент списка
max([],0).
max([X|T],M) :- max(T,N), X >= N, M is X.
max([X|T],M) :- max(T,N), X < N, M is N.

% Для каждого студента найти средний балл (студент, средняя оценка) (1)
average_mark(S,M) :- student(_,S,All), sum(All,Sum), length(All,L), M is Sum/L.

% Для каждого студента, определить, сдал ли он экзамены (1)
succsess(S) :- student(_,S,P), not(member(grade(_,2),P)).

% Для каждого предмета найти количество не сдавших студентов (2)
grades([grade(S,2)|_],S).
grades([_|T],S) :- grades(T,S).

amount_of_reexams(S1,C) :- 
    subject(S,S1),
    findall(M,(student(_,_,M),grades(M,S)),All),
    length(All,C).

% Для каждой группы, найти студента (студентов) с максимальным средним баллом (3)
best_in_group(G,Student):-
    findall(A,(student(G,S,_),average_mark(S,A)),All),
    max(All, M),
    findall(St,(student(G,St,_),average_mark(St,Tmp),Tmp == M),Student),!.
