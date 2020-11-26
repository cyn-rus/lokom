/* Dynamic inventory (dengan maksimum 100) dan gold */
/* Rule untuk membuang inventory atau simpan inventory */
/* Rule untuk mengecek apakah inventory penuh atau tidak */

/* Dynamic Predicates */
:- dynamic(inventory/2).
:- dynamic(gold/1).

/* Print List */

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

open_inventory :-
    inventory(List, NbElmt),
    ((NbElmt == 0) -> msg_invent_empty, ! ; (msg_invent_notempty, nl, print_list(List), nl, msg_invent_command), !).

add_inventory(Elmt) :-
    inventory(List, NbElmt),
    add_elmt(List, Elmt, NewList),
    NewNbElmt is NbElmt + 1,
    retractall(inventory(_,_)),
    asserta(inventory(NewList, NewNbElmt)).

select_weapon :-
    inventory,
    msg_select_command, nl.

selects(X) :- 
    in_battle(false), !,
    inventory(List, _),
    is_member(X, List),
    retract(char_weapon(_)),
    asserta(char_weapon(X)).

remove(Item) :-
    inventory(List, NbElmt),
    potion(ID, Item, _, _, _, _),
    is_member(ID, List),
    /* delete potion */
    del_elmt(ID, List, NewList),
    retractall(inventory(_,_)),
    NewNbElmt is NbElmt + 1,
	asserta(inventory(NewList, NewNbElmt)),
    msg_remove_success(Item), !.

remove(Item) :-
    inventory(List, NbElmt),
    equipment(ID, Item, _, _, _),
    is_member(ID, List),
    /* delete equipment */
    del_elmt(ID, List, NewList),
    retractall(inventory(_,_)),
    NewNbElmt is NbElmt + 1,
	asserta(inventory(NewList, NewNbElmt)),
    msg_remove_success(Item), !.

/* INVALID ITEMS */
remove(Item) :-
    \+ potion(_, Item, _, _, _, _),
    \+ equipment(_, Item, _, _, _),
    msg_remove_fail, !.

remove(Item) :-
    inventory(List, _),
    potion(ID, Item, _, _, _, _),
    \+ is_member(ID, List),
    msg_remove_fail, !.

remove(Item) :-
    inventory(List, _),
    equipment(ID, Item, _, _, _),
    \+ is_member(ID, List),
    msg_remove_fail, !.

/* Gold Operations */
gold_enough(X) :-
    gold(Y),
    Y >= X.

addGold(X) :- gold(G), NG is G+X, retract(gold(G)), assertz(gold(NG)).
removeGold(X) :- gold(G), NG is G-X, retract(gold(G)), assertz(gold(NG)).