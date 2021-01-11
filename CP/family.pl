parent('Evgenia Ayrapetova','Ashot Ayrapetov','Olga Ayrapetova').
parent('Olga Ayrapetova','Alexandr Yamnov','Nadezhda Yamnova').
parent('Artem Yamnov','Alexandr Yamnov','Nadezhda Yamnova').
parent('Ashot Ayrapetov','Felix Ayrapetov','Angela Ayrapetova').
parent('Marina Abramyan','Felix Ayrapetov','Angela Ayrapetova').
parent('Nadezhda Yamnova','Sergej Galkin','Nina Galkina').
parent('Evgenij Galkin','Sergej Galkin','Nina Galkina').
parent('Mikhail Galkin','Sergej Galkin','Nina Galkina').
parent('Alexandr Galkin','Sergej Galkin','Nina Galkina').
parent('Vladimir Galkin','Sergej Galkin','Nina Galkina').
parent('Karen Abramyan','Shiraz Abramyan','Marina Abramyan').
parent('Anush Abramyan','Shiraz Abramyan','Marina Abramyan').
parent('Marina Birukova','Evgenij Galkin','Svetlana Galkina').
parent('Elena Savosina','Evgenij Galkin','Svetlana Galkina').
parent('Elena Kharitonova','Mikhail Galkin','Alexandra Galkina').
parent('Sergej Galkin','Mikhail Galkin','Alexandra Galkina').
parent('Sergej Galkin','Alexandr Galkin','Vera Galkina').
parent('Lubov Mironova','Alexandr Galkin','Vera Galkina').
parent('Fedor Galkin','Vladimir Galkin','Tatyana Galkina').
parent('Anna Galkina','Vladimir Galkin','Tatyana Galkina').
parent('Alexandr Birukov','Vasilij Birukov','Marina Birukova').
parent('Maxim Birukov','Vasilij Birukov','Marina Birukova').
parent('Dmitrij Savosin','Igor Savosin','Elena Savosina').
parent('Alena','Igor Savosin','Elena Savosina').
parent('Alexandr Kharitonov','Valerij Kharitonov','Elena Kharitonova').
parent('Maxim Kharitonov','Valerij Kharitonov','Elena Kharitonova').
parent('Danila Galkin','Sergej Galkin','Natalia Galkina').
parent('Nikita Galkin','Sergej Galkin','Elena Galkina').
parent('Sophia Galkina','Fedor Galkin','null0').
parent('Andrey Galkin','Fedor Galkin','null0').
parent('Xenia','null1','Anna Galkina').
parent('Dmitrij Birukov','Maxim Birukov','Julia Birukova').
parent('null2','null3','Evgenia Ayrapetova').
parent('null4','Artem Yamnov','null5').
parent('null6','Karen Abramyan','null7').
parent('null8','null9','Anush Abramyan').
parent('null10','Alexandr Birukov','null11').
parent('null12','Dmitrij Savosin','null13').
parent('null14','null15','Alena').
parent('null16','Alexandr Kharitonov','null17').
parent('null18','Maxim Kharitonov','null19').
parent('null20','Danila Galkin','null21').
parent('null22','Nikita Galkin','null23').
parent('null24','null25','Sophia Galkina').
parent('null26','Andrey Galkin','null27').
parent('null28','null29','Xenia').
parent('null30','Dmitrij Birukov','null31').

sibling(X,Y) :- parent(X,A,B), parent(Y,A,B), X\=Y.
dever(X,Y) :- parent(A,B,X), parent(C,Y,D), sibling(B,Y).  
