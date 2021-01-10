% Реализовать разбор предложений английского языка. В
% предложениях у объекта (подлежащего) могут быть заданы 
% цвет, размер, положение. В результате разбора должны 
% получиться структуры представленные в примере. 

% Артикли
article(a).
article(an).
article(the).

% Цвета
color(red).
color(orange).
color(yellow).
color(green).
color(blue).
color(purple).

% Размер 
size(big).
size(little).
size(small).
size(medium).

% Подлежащее
subject(book).
subject(pen).
subject(cup).
subject(toy).
subject(bag).
subject(table).

location(in, X, in(X)).
location(on, X, on(X)).
location(under, X, under(X)).
location(behind, X, behind(X)).
location(before, X, before(X)).
location(after, X, after(X)).

sentence([L],s(L)).
sentence([L1,L2],s(L1,L2)).

sentence([A,Size,Subj|T],Res) :-
    article(A),
    size(Size),
    subject(Subj),
    sentence([object(Subj,size(Size))|T],Res).

sentence([A,Color,Subj|T],Res) :-
    article(A),
    color(Color),
    subject(Subj),
    sentence([object(Subj,color(Color))|T],Res).

sentence([object(Subject,size(Size)),is,X,Y,Z|T],Res) :-
    article(Y),
    subject(Z),
    location(X,Z,Loc),
    sentence([location(object(Subject,size(Size)),Loc)|T],Res).

sentence([object(Subject,color(Color)),is,X,Y,Z|T],Res) :-
    article(Y),
    subject(Z),
    location(X,Z,Loc),
    sentence([location(object(Subject,color(Color)),Loc)|T],Res).

sentence([object(Subject,size(Size)),is,X|T],Res) :-
    color(X),
    sentence([object(Subject,size(Size)),color(X)|T],Res).

sentence([object(Subject,color(Color)),is,X|T],Res) :-
    size(X),
    sentence([object(Subject,color(Color)),size(X)|T],Res).
