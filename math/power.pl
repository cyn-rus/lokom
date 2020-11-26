/* Didapat dari pembahasan praktikum logika komputasional */

power(_, -1, Current, Current) :- !.
power(_, 0, _, 1) :- !.
power(_, 1, Current, Current) :- !.

power(A, B, Current, X) :-
    B > 0,
    NewCurrent is Current * A,
    NewB is B-1,
    power(A, NewB, NewCurrent, X).

power(A, B, Current, X) :-
    B < 0,
    NewCurrent is Current / A,
    NewB is B+1,
    power(A, NewB, NewCurrent, X).

power(A, B, X) :-
    B > 0, power(A, B, A, X).
power(A, B, X) :-
    B < 0, NewA is 1/A,
    power(A, B, NewA, X).
power(A, B, X) :-
    A \= 0,
    B = 0, X is 1.