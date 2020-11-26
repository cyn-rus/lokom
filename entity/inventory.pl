/* Dynamic inventory (dengan maksimum 100) dan gold */
/* Rule untuk membuang inventory atau simpan inventory */
/* Rule untuk mengecek apakah inventory penuh atau tidak */

/* Dynamic Predicates */
:- dynamic(inventory/2).
:- dynamic(gold/1).
:- dynamic(char_weapon/1).
:- dynamic(char_armor/1).

/* Print List */

print_inventory :-
    inventory([], _),
    msg_invent_empty, !.

print_inventory :-
    inventory(List, _),
    msg_invent_notempty, nl,
    print_list(List), nl,
    msg_invent_command, !.

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

add_inventory(Elmt) :-
    inventory(List, NbElmt),
    retractall(inventory(_,_)),
    add_elmt(List, Elmt, NewList),
    NbElmtNew is NbElmt+1,
    asserta(inventory(NewList,NbElmtNew)).

select_weapon :-
    inventory,
    msg_select_command, nl.
/* changed back open_inventory/0 into inventory/0 */

selects(X) :- 
    in_battle(false), !,
    inventory(List, _),
    is_member(X, List),
    retract(char_weapon(_)),
    asserta(char_weapon(X)).

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
    inventory(List, _),
    \+ is_member(Item, List),
    message_remove_fail, !.

/* Gold Operations */
gold_enough(X) :-
    gold(Y),
    Y >= X.

addGold(X) :- gold(G), NG is G+X, retract(gold(G)), assertz(gold(NG)).
removeGold(X) :- gold(G), NG is G-X, retract(gold(G)), assertz(gold(NG)).