/*
    Факториал без меморизации
*/

factorial(0, 1).
% Recursion: factorial of N is N * factorial of (N-1)
factorial(N, Result) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, Result1),
    Result is N * Result1.

% ?- factorial(5, Result).




/*
    Факториал с меморизацией
*/

%Динамический предикат для хранения вычисленных факториалов 
%(можно добавлять, удалять или изменять факты, связанные с этим предикатом во время выполнения)
:- dynamic factorial_memo/2.

% База: factorial of 0 is 1
factorial_memo(0, 1).
% Проверяем, вычислен ли уже факториал.
factorial_memo(N, Result) :-
    N > 0,
    N1 is N - 1,
    factorial_memo(N1, Result1),
    Result is N * Result1,
    assertz(factorial_memo(N, Result)).  % Сохраните результат для будущего использования.
% Если результат уже вычислен, извлекаем
factorial(N, Result) :-
    factorial_memo(N, Result).
% assertz - добавить новый факт или правило в базу данных

% ?- factorial(5, Result).