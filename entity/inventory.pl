/* Dynamic inventory (dengan maksimum 100) dan gold */
/* Rule untuk membuang inventory atau simpan inventory */
/* Rule untuk mengecek apakah inventory penuh atau tidak */

/* Dynamic Predicates */
:- dynamic(inventory/2).
:- dynamic(gold/1).

/* Print List */

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

print_list([]).

print_potion([H|T]) :-
    potion(H, Name, _, _, _, _),
    write('  - '),
    write(Name), nl,
    print_potion(T).

print_potion([H|T]) :-
    equipment(H, _, _, _, _),
    print_potion(T).

print_potion([]).

/* Inventory Interactions */

open_inventory :-
    inventory(List, NbElmt),
    ((NbElmt =:= 0) -> msg_invent_empty, nl, ! ; (msg_invent_notempty, nl, print_list(List), nl, msg_invent_command), !).

/*
open_potion_inventory :-
    inventory(List, NbElmt),
    \+ is_member(-1, List),
    \+ is_member(-2, List),
    \+ is_member(-3, List),
    \+ is_member(-4, List),
    \+ is_member(-5, List),
    \+ is_member(-6, List),
    write("You don't have any potions."), !.

open_potion_inventory :-
    inventory(List, NbElmt),
    write("Your potions:"), nl,
    print_potion(List), nl, !.
*/

add_inventory(Elmt) :-
    inventory(List, NbElmt),
    add_elmt(Elmt, List, NewList),
    NewNbElmt is NbElmt + 1,
    retractall(inventory(_,_)),
    asserta(inventory(NewList, NewNbElmt)).

select_weapon :-
    open_inventory,
    msg_select_command, nl,
    inventory(_, NbElmt), 
    NbElmt =:= 0, !, 
    inventory(_, Y),
    ((Y > 0) ->
    write("Masukkan nama Barang menggunakan \" untuk mengequip item: "),
    read(X), 
    selects(X) ; true).

selects(X) :- 
    in_battle(false), !,
    inventory(List, _),
    (equipment(Y, X, _, _, _) -> 
    (is_member(Y, List) -> 
    retractall(char_weapon(_)),
    asserta(char_weapon(Y)) ; msg_remove_fail);
    msg_remove_fail).

select_armor :-
    select_weapon.

remove(Item) :-
    inventory(List, NbElmt),
    potion(ID, Item, _, _, _, _),
    is_member(ID, List),
    /* delete potion */
    del_elmt(ID, List, NewList),
    retractall(inventory(_,_)),
    NewNbElmt is NbElmt - 1,
	asserta(inventory(NewList, NewNbElmt)),
    msg_remove_success(Item), !.

remove(Item) :-
    inventory(List, NbElmt),
    equipment(ID, Item, _, _, _),
    is_member(ID, List),
    /* delete equipment */
    del_elmt(ID, List, NewList),
    retractall(inventory(_,_)),
    NewNbElmt is NbElmt - 1,
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

addGold(X) :- gold(G), NG is G+X, msg_get_gold(G, NG), retract(gold(G)), assertz(gold(NG)).
removeGold(X) :- gold(G), NG is G-X, retract(gold(G)), assertz(gold(NG)).