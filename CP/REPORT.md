# Отчет по курсовому проекту
## по курсу "Логическое программирование"

### студент: Айрапетова Е.А.

## Результат проверки

| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |              |      3         |
| Левинская М.А.|              |               |

> *Задание 4 и 5 не выполнены*

## Введение

В процессе выполнения данной курсовой работы я разберу структуру файла GEDCOM, научусь преобразовывать этот формат в набор утверждений на языке Prolog, а также напишу предикаты для определения степени родства двух индивидуумов. Помимо работы с логическим языком програмирования Prolog, мне понадобится императивный язык программирования. Поэтому я изучила язык программирования Python на базовом уровне и в процессе выполнения усовершенствую знания и попрактикуюсь писать программы на данном языке.

## Задание

 1. Создать родословное дерево своего рода на несколько поколений (3-4) назад в стандартном формате GEDCOM с использованием сервиса MyHeritage.com 
 2. Преобразовать файл в формате GEDCOM в набор утверждений на языке Prolog, используя следующее представление: ...
 3. Реализовать предикат проверки/поиска .... 
 4. Реализовать программу на языке Prolog, которая позволит определять степень родства двух произвольных индивидуумов в дереве
 5. [На оценки хорошо и отлично] Реализовать естественно-языковый интерфейс к системе, позволяющий задавать вопросы относительно степеней родства, и получать осмысленные ответы. 

## Получение родословного дерева

С помощью geni.com я получила свое родословное дерево. Я записала большую часть своей семьи и в итоге у меня вышло 49 человек.

## Конвертация родословного дерева

Для того, чтобы конвертировать родословное дерево в набор утверждений на Prolog, я использовала Python. Я обратила внимание, что в моем GEDCOM-файле первая часть - это присваивание 
каждому члену семьи уникального ID, а вторая - описание степени родства. Чтобы не читать файл дважды, я создала переменную part типа int, которая равна 0, когда программа считывает 
первую часть файла, 1 - когда считывается вторая часть. 
Когда переменная part равна 0, программа ищет идентификатор члена семьи (признаки: нулевой символ равен 0, второй - @) и в массиве ID создает новый элемент, в который записывает ID:

if line[0] == '0' and line[2] == '@':
    ID.insert(number, '')
     for i in range(19):
        ID[number] = ID[number] + line[i + 4]

После ID обязательно должно идти имя человека, которое программа также находит по признаку (нулевой символ - 1, второй - N (начало слова NAME)) и записывает в массив name. 
Далее в дереве записан пол человека, но я закоментировала часть программы, которая с ним работает, так как в моем варианте это не нужно. Таким образом программа записывает все эти 
данные в массивы, причем нумерация элементов одного массива соответствует нумерации второго (например, 10-й идентификатор в массиве ID соответствует 10-му имени в массиве name).

Признаком окончания первой части является начало перечисления семей: сначала идет идентификатор семьи (нулевой символ - 0, второй - @, двадцать пятый - F), затем - описание семьи по 
ID, то есть указаны ID жены, мужа и детей. Программа по ID ищет имена родителей и одного ребенка и запоминает их в переменных wife, husband и child соответственно таким образом:

if line[2] == 'W':
            wife_ = ''
            for i in range(19):
                wife_ = wife_ + line[i + 9]
            t = 0
            while t >= 0:
                if ID[t] == wife_: 
                    wife = name[t] 
                    t = -2
                t = t + 1
 
затем записывает в файл family.pl предикат parent для этих трех индивидуумов:

f2.write('parent(\'')
f2.write(child)
f2.write('\',\'')
f2.write(husb)
f2.write('\',\'')
f2.write(wife)
f2.write('\').\n')

Если в этой семье еще есть дети, то переменная child переопределяется. Переменные wife, husband и child обнуляются, когда начинается описание новой семьи (переопределение не подходит, так как в моем дереве есть неполные семьи). Если у ребенка нет данных по родителям, супргуам или детям, то в файл на их место записывается "null", чтобы всегда можно было однозначно определить пол челоека (в зависимости от того, на каком месте стоит имя). 

В процессе выполнения следующего задания я обнаружила недочет в формате программы family.pl и дополнила программу, поэтому файл читается дважды. В случае, когда у человека нет детей 
и/или супрги(а), в family.pl записывается parent('null', 'null', 'human'). В дальнейшем, узнав, на каком месте написано имя человека, мы можем узнать его пол.

## Предикат поиска родственника

Деверь - брат мужа. То есть для поиска деверя нам нужно, чтобы мы искали родственника относительно женщины и муж этой женщины и его брат должны быть братьями. То есть, предикат выглядит следующим образом:

dever(X,Y) :- 
    parent(_,A,X), 
    brother(A,Y), 
    X\='null', Y\='null', A\='null'.  

Дополнительно к этому предикату, я написала предикат brother:

brother(X,Y) :- 
    parent(X,A,B), 
    parent(Y,A,B), 
    parent(_,Y,_),
    X\=Y, 
    X\='null', Y\='null'.


## Выводы

Данный курсовой проект является показательным примером того, как на практике может быть использован язык Prolog. При решении данного рода задач логический язык программирования является оптимальным.
Логическая парадигма показала мне, что программирование может выглядеть не только как описание последовательных действий. В ходе выполнения данного курсового проекта я не только научилась и попрактиковалась программировать на Prolog, но и впервые программировала на Python.