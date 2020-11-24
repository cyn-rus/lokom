/* Dynamic inventory (dengan maksimum 100) dan gold */
/* Rule untuk membuang inventory atau simpan inventory */
/* Rule untuk mengecek apakah inventory penuh atau tidak */

/* Dynamic Predicates */
:- dynamic(inventory/2).
:- dynamic(gold/1).
:- dynamic(char_weapon/1).

/* Inventory Operations */

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

del_elmt(Elmt, [Elmt|Tail], Tail).

del_elmt(Elmt, [Head|Tail], [Head|Result]) :-
    del_elmt(Elmt, Tail, Result).

/* Print List */

print_inventory :-
    inventory([], _),
    write('Nothing to see here. Move along.').

print_inventory :-
    inventory(List, _),
    write('Your current items:'), nl,
    print_list(List), nl,
    write('Type \'remove(Item)\' to remove an item.'), !.

print_list([]).

print_list([H|T]) :-
    potion(H, Name, _, _, _, _),
    write('  - '),
    write(Name), nl,
    print_list(T).

print_list([H|T]) :-
    equipment(H, Name, _, _, _),
    write('  - '),
    write(Name), nl,
    print_list(T).

/* Inventory Interactions */

inventory :-
    print_inventory.
selected(item) :- 
    inventory().
remove(Item) :-
    inventory(List, Max),
    potion(ID, Item, _, _, _),
    is_member(ID, List),
    /* delete potion */
    del_elmt(ID, List, Result),
    retract(inventory(List, Max)),
	asserta(inventory(Result, Max)),
    message_remove_success(Item), !.

remove(Item) :-
    inventory(List, Max),
    potion(ID, Item, _, _, _),
    is_member(ID, List),
    /* delete equipment */
    del_elmt(ID, List, Result),
    retract(inventory(List, Max)),
	asserta(inventory(Result, Max)),
    message_remove_success(Item), !.

remove(Item) :-
    inventory(List, Max),
    \+ is_member(Item, List),
    message_remove_fail(Msg), write(Msg), !.

/* Gold Operations */
gold_enough(X) :-
    gold(Y),
    Y >= X.

addGold(X) :- gold(G), NG is G+X, retract(gold(G)), assertz(gold(NG)).
removeGold(X) :- gold(G), NG is G-X, retract(gold(G)), assertz(gold(NG)).