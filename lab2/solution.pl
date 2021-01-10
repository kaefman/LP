% В одном городе живут 7 любителей птиц. И фамилии у них птичьи.
% Каждый из них тезка птицы, которой владеет один из его товарищей.
% У троих из них живут птицы, которые темнее, чем пернатые тезки их хозяев.
% Тезка птицы, которая живет у Воронова, женат.
% Голубев и Канарейкин единственные холостяки из всей компании.
% Хозяин грача женат на сестре жены Чайкина.
% Невеста хозяина ворона очень не любит птицу, с которой возится ее жених.
% Тезка птицы, которая живет у Грачева, хозяин канарейки.
% Птица, которая является тезкой владельца попугая, принадлежит тезке той птицы, которой владеет Воронов.
% У голубя и попугая оперение светлое.
% Кому принадлежит скворец?

:- encoding(utf8).

% Список птиц
birds(X) :- X = [ворон, голубь, канарейка, чайка, грач, попугай, скворец].

% Тезка
namesake(ворон,воронов).
namesake(голубь,голубев).
namesake(канарейка,канарейкин).
namesake(чайка,чайкин).
namesake(грач,грачев).
namesake(попугай,попугаев).
namesake(скворец,скворцов).

solve(ResList) :-
    birds(Birds), permutation(Birds, [A, B, C, D, E, F, G]),
    ResList = [owner(воронов,A), owner(голубев,B), owner(канарейкин,C), owner(чайкин,D), owner(грачев,E), owner(попугаев,F), owner(скворцов,G)],

    % Каждый из них тезка птицы, которой владеет один из его товарищей.
    A\=ворон, B\=голубь, C\=канарейка, D\=чайка, E\=грач, F\=попугай, G\=скворец,

    % Голубев и Канарейкин единственные холостяки из всей компании.
    Bachelors = [голубев,канарейкин],

    % У троих из них живут птицы, которые темнее, чем пернатые тезки их хозяев.
    DarkBirds = [ворон,грач,скворец],
    member(owner(Xowner,Xbird),ResList), namesake(TX,Xowner), not(member(TX,DarkBirds)), member(Xbird,DarkBirds),
    member(owner(Yowner,Ybird),ResList), namesake(TY,Yowner), not(member(TY,DarkBirds)), member(Ybird,DarkBirds),
    member(owner(Zowner,Zbird),ResList), namesake(TZ,Zowner), not(member(TZ,DarkBirds)), member(Zbird,DarkBirds),
    Xbird\=Ybird, Ybird\=Zbird, Zbird\=Xbird,

    % Невеста хозяина ворона очень не любит птицу, с которой возится ее жених.
    member(owner(H,ворон),ResList), member(H,Bachelors),

    % Тезка птицы, которая живет у Воронова, женат.
    member(owner(воронов,P),ResList), namesake(P,P1), not(member(P1,Bachelors)),

    % Хозяин грача женат на сестре жены Чайкина.
    member(owner(I,грач),ResList), not(member(I,Bachelors)), I\=чайкин,

    % Тезка птицы, которая живет у Грачева, хозяин канарейки.
    member(owner(грачев,S),ResList), namesake(S,K), member(owner(K,канарейка),ResList), 

    % Птица, которая является тезкой владельца попугая, принадлежит тезке той птицы, которой владеет Воронов.
    member(owner(M,попугай),ResList), namesake(N,M),
    member(owner(воронов,R),ResList), namesake(R,O),
    member(owner(O,N),ResList),!.

task(Res) :-
    solve(List), member(owner(Res,скворец),List).
