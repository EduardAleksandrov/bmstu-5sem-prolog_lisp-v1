/*
    Написать программу, которая позволит формировать карту лабиринта и находить выход из лабиринта.
    Лабиринт должен содержать особые клетки:
    телепорт (может телепортировать в указанную в его памяти точку на карте);
    счётная ловушка (срабатывает каждые K шагов);
    стена (сквозь неё нельзя ходить);
    Примечание:
    лабиринт задаётся MxN ячейками;
    игрок может перемещаться на одну клетку за ход (движение по варианту);

    Вариант: влево, вправо, вниз и может осуществлять прыжок, оказываясь не на соседней клетке, а на клетке "через две"
*/

% Определяем структуру лабиринта
% labyrinth(M, N, Cells).
% M: количество строк, N: количество столбцов, Cells: список определений ячеек
labyrinth(5, 5, [
    cell(1, 1, empty),
    cell(1, 2, wall),
    cell(1, 3, empty),
    cell(1, 4, empty),
    cell(1, 5, empty),
    cell(2, 1, teleport(3, 3)),
    cell(2, 2, teleport(3, 3)),
    cell(2, 3, empty),
    cell(2, 4, wall),
    cell(2, 5, empty),
    cell(3, 1, teleport(3, 3)),
    cell(3, 2, empty),
    cell(3, 3, empty),
    cell(3, 4, counting_trap(3)),
    cell(3, 5, empty),
    cell(4, 1, wall),
    cell(4, 2, wall),
    cell(4, 3, empty),
    cell(4, 4, wall),
    cell(4, 5, empty),
    cell(5, 1, empty),
    cell(5, 2, empty),
    cell(5, 3, empty),
    cell(5, 4, empty),
    cell(5, 5, empty)
]).

% Определяем возможные ходы
move((X, Y), (X1, Y)) :- X1 is X + 1. % down
move((X, Y), (X1, Y)) :- X1 is X - 1. % up
move((X, Y), (X, Y1)) :- Y1 is Y + 1. % right
move((X, Y), (X, Y1)) :- Y1 is Y - 1. % left
move((X, Y), (X1, Y)) :- X1 is X + 2, Y = Y. % jump down
move((X, Y), (X1, Y)) :- X1 is X - 2, Y = Y. % jump up
move((X, Y), (X, Y1)) :- X = X, Y1 is Y + 2. % jump right
move((X, Y), (X, Y1)) :- X = X, Y1 is Y - 2. % jump left

% Проверьте, является ли ячейка допустимой (находится ли она в пределах границ и не является стеной)
valid_cell((X, Y)) :-
    labyrinth(M, N, _),
    X > 0, X =< M,
    Y > 0, Y =< N,
    \+ cell((X, Y), wall).

% Получаем тип ячейки
cell((X, Y), Type) :-
    labyrinth(_, _, Cells),
    member(cell(X, Y, Type), Cells).

% Находим путь от Start до End
find_path(Start, End, Path, K) :-
    find_path(Start, End, [Start], Path, K, 0).

find_path(End, End, Visited, Path, _, _) :-
    reverse(Visited, Path).

find_path(Current, End, Visited, Path, K, Steps) :-
    move(Current, Next),
    valid_cell(Next),
    \+ member(Next, Visited),
    (   cell(Current, counting_trap(K)),
        NewSteps is Steps + 1,
        (   NewSteps >= K -> 
            write('Trap triggered!'), nl,
            NewSteps1 is 0
        ;   NewSteps1 = NewSteps
        )
    ;   NewSteps1 = Steps
    ),
    (   cell(Current, teleport(X, Y)) -> 
        Next = (X, Y)
    ;   Next = Next
    ),
    find_path(Next, End, [Next | Visited], Path, K, NewSteps1).

% ?- find_path((1,1), (5,5), Path, 3).