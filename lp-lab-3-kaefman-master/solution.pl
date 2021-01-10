% Железнодорожный сортировочный узел устроен так, как показано на рисунке. 
% На левой стороне собрано некоторое число вагонов двух типов(черные и белые), 
% обоих типов по n штук, в произвольном порядке. Тупик вмещает все 2n вагонов. 
% Пользуясь тремя сортировочными операциями (слева в тупик, из тупика направо, 
% слева направо, минуя тупик), собрать вагоны на правой стороне, так, чтобы типы 
% чередовались. Для решения задачи достаточно 3n-1 сортировочных операций.

prolong([X|T], [Y,X|T]) :- move(X,Y),\+(member(Y,[X|T])).

% Поиск в глубину
dfs_path([X | T], X, [X | T]).
dfs_path(P, B, R):- prolong(P, P1), dfs_path(P1, B, R).
dfs(A, B, R):- dfs_path([A], B, R).

% Поиск в ширину
bfs_path([[X|T]|_],X,[X|T]). 
bfs_path([P|Q],B,R) :- findall(X,prolong(P,X),L),append(Q,L,QL),!,bfs_path(QL,B,R).
bfs_path([_|Q],B,R) :- bfs_path(Q,B,R).
bfs(A,B,R) :- bfs_path([[A]],B,R).   % R - обратный путь

% Поиск с итерационным заглублением
id_path([X | T], X, [X | T], _).
id_path(P, B, R, N):- N > 0, prolong(P, P1), N1 is N - 1, id_path(P1, B, R, N1).
id(s(X, Y, Z), B, R):- length(X, L), N is 3 * L / 2, id_path([s(X, Y, Z)], B, R, N).

% может начинаться с черного или белого вагона
bw(X) :- b(X); w(X). % или - ;

b([]).
b([X|T]) :- X==black,w(T).    % если X черный, то следующий должен быть белым

w([]).
w([X|T]) :- X==white,b(T).    % если X белый, то следующий должен быть черным

first([],[]).
first([X|_],X).

reverse_lists([],[]).
reverse_lists([s(X, Y, Z)|T], [s(P,Q,R)|RT]) :- 
    reverse(X,P), 
    reverse(Y,Q), 
    reverse(Z,R), 
    reverse_lists(T,RT).

% первый аргумент - вагоны слева, второй - в тупике, третий - справа
move(s([A|AT],B,C), s(AT,B,[A|C])) :- first(C,X), X\=A.
move(s(A,[B|BT],C), s(A,BT,[B|C])) :- first(C,X), X\=B.
move(s([A|AT],B,C), s(AT,[A|B],C)) :- first(C,X), X==A.

solve(X,R):- 
    reverse(X,X1), 
    permutation(X1,Y), 
    bw(Y), 
    id(s(X1,[],[]),     % здесь bfs, dfs или id - в зависимости от вида поиска
    s([],[],Y),W), 
    reverse_lists(W,W1), 
    reverse(W1,R), !.
