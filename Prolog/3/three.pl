/*
Создайте отчёт и программу на Prolog в созданной в прошлом проекте базе знаний написать правил, использующих findall, для поиска всех объектов, 
подходящих под ограничения (не меньше 3 правил, в каждом правиле от 1 до 3 ограничений), 
кроме того в работе необходимо реализовать:
-2 нахождение наибольшего из 2х чисел, из 3х чисел (без использования отсечений и с использованием отсечений);
-3 нахождение наибольшего элемента в списке из целых чисел (2 способа: самописное правило, стандартное правило из документации);
-4 нахождение наибольшего элемента в списке из термов (2 способа: самописное правило, стандартное правило из документации);
-5 нахождение наибольшего элемента в списке из списков чисел (2 способа: самописное правило, стандартное правило из документации);
-6 нахождение наибольшего элемента в списке из списков термов (2 способа: самописное правило, стандартное правило из документации);
-7 нахождение среднего арифметического в списке из целых чисел;
-8 нахождение общих элементов в двух списках (2 способа);
*/

% Калории, Белки, Жиры, Углеводы
food("chiken", 165,	31, 3.6, 0.0).
food("broccoli", 34, 3.0, 0.28, 0.0).
food("salmon", 206, 22.0, 13.0, 0.0).
food("Eggs", 155, 13.0, 11.0, 1.1).
food("tofu", 144, 15.0, 8.0, 3.9).
food("rice", 130, 2.7, 0.3, 28.0).

% жарка, варка, запекание, пар
cooking("fried", 1.2, 0.95, 1.5, 0.9).
cooking("boiled", 0.85, 0.98, 0.8, 0.95).
cooking("baking", 1.1, 0.98, 1.2, 0.95).
cooking("steam", 0.9, 0.99, 0.85, 0.98).

% списки
%1 Найти продукты по калориям
найти_продукты_по_калориям(КалорииМинимум, Продукты) :-
    findall(Продукт, (food(Продукт, Калории, _, _, _), Калории > КалорииМинимум), Продукты).
% ?-найти_продукты_по_калориям(140, X).

%1 Найти продукты по белкам
найти_продукты_по_белкам(БелкиМинимум, Продукты) :-
    findall(Продукт, (food(Продукт, _, Белки, _, _), Белки > БелкиМинимум), Продукты).
% ?-найти_продукты_по_белкам(13, X).

%1 Найти продукты по жиру и углеводам
найти_продукты_по_жиру_и_углеводам(ЖирыМакс, УглеводыМакс, Продукты) :-
    findall(Продукт, (food(Продукт, _, _, Жиры, Углеводы), Жиры < ЖирыМакс, Углеводы < УглеводыМакс), Продукты).
% ?-найти_продукты_по_жиру_и_углеводам(13,3.9,X).

%2
% Наибольшее из трех чисел с отсечением
max3(A,B,C,A):-A>=B,A>=C,!.
max3(_,B,C,B):-B>=C,!.
max3(_,_,C,C).
% ?- max3(2,1,3,R)

%2
% Наибольшее из двух чисел с отсечением
max2(A,B,A):-A>=B,!.
max2(_,B,B).
% ?- max2(3,2,X).

%2
% Наибольшее из трех чисел без отсечения
max3(A,B,C,R):-A>=B, A>=C, R=A.
max3(A,B,C,R):-B>=A, B>=C, R=B.
max3(A,B,C,R):-C>=A, C>=B, R=C.
% ?- max3(2,1,3,R)

%2
% Наибольшее из двух чисел без отсечения
max2(A,B,R):-A>=B, R=A.
max2(A,B,R):-B>=A, R=B.
% ?- max2(3,2,X).


%3 нахождение наибольшего элемента в списке из целых чисел
% Самописное
% Базовый случай: наибольший элемент в списке, состоящем из одного элемента, это сам элемент.
max_element([X], X).
% Рекурсивный случай: сравниваем голову списка с наибольшим элементом хвоста.
max_element([H|T], Max) :-
    max_element(T, MaxTail),  % Находим наибольший элемент в хвосте
    Max is max(H, MaxTail).    % Сравниваем его с головой и выбираем большее.
% ?- max_element([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5], Max).

%3 Встроенное
:- use_module(library(lists)).
% Пример использования max_list/2
find_max(List, Max) :-
    max_list(List, Max).
% ?- find_max([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5], Max).


%4 нахождение наибольшего элемента в списке из термов
% Самописное
% Базовый случай: наибольший элемент в списке, состоящем из одного терма, это сам терм.
max_term([X], X).
% Рекурсивный случай: сравниваем голову списка с наибольшим термом хвоста.
max_term([H|T], Max) :-
    max_term(T, MaxTail),  % Находим наибольший терм в хвосте
    (   H @> MaxTail        % Сравниваем термы
    ->  Max = H            % Если голова больше, то она - наибольшая
    ;   Max = MaxTail      % Иначе наибольший терм - это хвост
    ).
% ?- max_term([apple, banana, cherry, date], Max).
% ?- max_term([1, 2, 3, 4, 5], Max).

%4 Встроенное
:- use_module(library(lists)).
% Пример использования max_list/2 для нахождения наибольшего терма
find_max_term(List, Max) :-
    max_member(Max, List).
% ?- find_max_term([apple, banana, cherry, date], Max).


%5 Нахождение наибольшего элемента в списке из списков чисел
% Самописное
max_in_list([X], X).
max_in_list([Head|Tail], Max) :-
    max_in_list(Tail, MaxTail),
    Max is max(Head, MaxTail).

max_in_list_in_list([List], Max) :-
    max_in_list(List, Max). 

max_in_list_in_list([Head|Tail], Max) :-
    max_in_list(Head, MaxHead),
    max_in_list_in_list(Tail, MaxTail),
    Max is max(MaxHead, MaxTail).
% ?- max_in_list_in_list([[1, 2, 3], [4, 5, 6], [7, 8, 9]], Max).

%5 Встроенное
:- use_module(library(lists)).
max_in_lists(ListOfLists, Max) :-
    maplist(max_list, ListOfLists, MaxList),  % Find max in each sublist
    max_list(MaxList, Max).                    % Find max in the list of maxes
% ?- max_in_lists([[1, 2, 3], [4, 5, 6], [7, 8, 9]], Max).


%6 нахождение наибольшего элемента в списке из списков термов
% Самописное
max_term_in_list([X], X).
max_term_in_list([H|T], Max) :-
    max_term_in_list(T, MaxTail),
    (H @> MaxTail -> Max = H;
    Max = MaxTail). 

max_term_in_list_of_lists([List], Max) :-
    max_term_in_list(List, Max).

max_term_in_list_of_lists([Head|Tail], Max) :-
    max_term_in_list(Head, MaxHead),
    max_term_in_list_of_lists(Tail, MaxTail),
    (MaxHead @> MaxTail -> Max = MaxHead ; Max = MaxTail).
% ?- max_term_in_list_of_lists([[apple,banana],[veg,potato],[orange,soup]],Max).

%6 Встроенное
max_term_in_list_std(List, Max) :-
    member(Max, List),
    forall(member(X, List), Max @>= X).

max_term_in_list_of_lists_std(ListOfLists, Max) :-
    maplist(max_term_in_list_std, ListOfLists, MaxList),
    max_term_in_list_std(MaxList, Max).
% ?- max_term_in_list_of_lists_std([[apple,banana],[veg,potato],[orange,soup]],Max).


%7 нахождение среднего арифметического в списке из целых чисел
% Основной предикат для нахождения среднего арифметического
average(List, Average) :-
    sum_list(List, Sum),
    length(List, Length),
    Length > 0,  % Проверяем, что список не пустой
    Average is Sum / Length.
% Предикат для нахождения суммы элементов списка
sum_list([], 0).  % Базовый случай: сумма пустого списка равна 0
sum_list([H|T], Sum) :-
    sum_list(T, TailSum),  % Рекурсивно находим сумму хвоста списка
    Sum is H + TailSum.
% ?- average([1, 2, 3, 4, 5], Average).


%8 нахождение общих элементов в двух списках
% Самописное
% Основной предикат для нахождения общих элементов
common_elements([], _, []).  % Если первый список пуст, результат пустой
common_elements(_, [], []).  % Если второй список пуст, результат пустой
common_elements([H|T1], L2, [H|Common]) :- 
    member(H, L2),  % Проверяем, есть ли голова первого списка во втором списке
    common_elements(T1, L2, Common).  % Рекурсивно ищем в хвосте
common_elements([H|T1], L2, Common) :- 
    \+ member(H, L2),  % Если голова не во втором списке
    common_elements(T1, L2, Common).  % Рекурсивно ищем в хвосте
% ?- common_elements_std([apple,banana,potato],[apple,orange,grape,potato],X).

%8 Встроенное
common_elements_std(List1, List2, Common) :-
    intersection(List1, List2, Common).
% ?- common_elements_std([apple,banana,potato],[apple,orange,grape,potato],X).



