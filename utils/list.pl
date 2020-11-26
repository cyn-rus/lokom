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

add_elmt(X, L, [X|L]).

/* Extra functions */

/* Delete Specific Element --> del_elmt(ToDelete, List, Result) */
del_elmt(_, [], []).

del_elmt(Elmt, [Elmt|Tail], Tail) :- !.

del_elmt(Elmt, [Head|Tail], [Head|Result]) :-
    del_elmt(Elmt, Tail, Result), !.
