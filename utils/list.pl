/* List Operations */
count_elmt([], 0).

count_elmt([_|T], X) :-
    count_elmt(T, N),
    X is N+1.

is_member(A, [B|_]) :-
    A =:= B.

is_member(A, [B|C]) :-
    A \== B,
    is_member(A, C).

/* Reverse List */
reverse(List, Rev) :-
        reverse(List, Rev, []).

reverse([], L, L).
reverse([H|T], L, SoFar) :-
        reverse(T, L, [H|SoFar]).

add_elmt(X, L, [X|L]).
add_after_elmt(L, X, C) :-
    reverse(L, A),
    add_elmt(X, A, B),
    reverse(B, C).

/* Extra functions */

after([_|B], B).

/* Delete Specific Element --> del_elmt(ToDelete, List, Result) */
del_elmt(_, [], []).

del_elmt(Elmt, [Elmt|Tail], Tail) :- !.

del_elmt(Elmt, [Head|Tail], [Head|Result]) :-
    del_elmt(Elmt, Tail, Result), !.

del_first_elmt([_|Tail], Tail).