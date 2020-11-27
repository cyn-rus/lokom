/* Fakta untuk item dengan mengunakkan sistem gacha (random) */

/* Dynamic Predicates */
:- dynamic(store_status/1).

store_status(0).
open_store :-
    store_status(0),
    game_start(true),
    msg_store_welcome(MSG, MSG2, MSG3, MSG4),
    write(MSG), nl, write(MSG2), nl, write(MSG3), nl, write(MSG4), nl,
    gold(X),
    msg_store_show_gold(X),
    read(Param),
    (\+ ((Param = gacha -> gacha);
    (Param = buy -> (retractall(store_status(_)), asserta(store_status(1)), buy));
    (Param = w -> w);
    (Param = a -> a);
    (Param = s -> s);
    (Param = d -> d))), !,
    msg_store_wrong_param(MSG5), write(MSG5), nl, nl, open_store.

/* Gacha yoohoo */
/* Case: inventory not full, gold enough */
gacha :-
    inventory(_, NbElmt),
    NbElmt < 100,
    gold_enough(100), !,
    removeGold(100),
    random(0, 8, ID),
    equipment(ID, Name, Att, Def, HP), msg_gacha_get(MSG),
    write(MSG), item_print(Name, Att, Def, HP),
    /* Input to Inventory */
    add_inventory(ID).

/* Case: inventory full */
gacha :-
    inventory(_, NbElmt),
    NbElmt >= 100,
    msg_store_inventory_full(MSG), write(MSG), !.

/* Case: gold not enough */
gacha :-
    (\+ gold_enough(100)),
    msg_store_gold_not_enough(MSG), write(MSG), !.

gacha :-
    game_start(true), (\+ isNear("S")),
    msg_store_not_near(MSG), write(MSG), !.

gacha :-
    game_start(false),
    msg_game_not_started(MSG), write(MSG), !.

pay_potion(Y, ID_Chosen) :-
    removeGold(Y),
    /* Input to Inventory */
    add_inventory(ID_Chosen),
    msg_store_after_buy(MSG), write(MSG), nl, nl.

/* Buy pots */
/* Case: inventory not full */
subbuy(A) :- 
    store_status(2),
    retractall(store_status(_)),
    asserta(store_status(0)),
    B is A * -1, (potion(B, _, _, _, _, Y)),
    (gold_enough(Y) -> pay_potion(Y, B) ; (msg_store_gold_not_enough(MSG), write(MSG), nl, nl)),
    open_store.

buy :-
    store_status(1), !,
    game_start(true),
    in_battle(false),
    /* Check Inventory */
    inventory(_, NbElmt),
    NbElmt < 100,
    /* Cont'd */
    potion(ID, Name, Att, Def, HP, Price),
    potion_print(ID, Name, Att, Def, HP, Price),
    msg_store_potions(MSG), write(MSG), nl, !,
    read(Param),
    retractall(store_status(_)),
    (Param = back -> (asserta(store_status(0)), nl, open_store) ; (asserta(store_status(2)), subbuy(Param))), !.

/* Case: inventory full */
buy :-
    store_status(1), !,
    retractall(store_status(_)), 
    asserta(store_status(0)),
    game_start(true),
    in_battle(false), !,
    /* Check Inventory */
    inventory(_, NbElmt),
    NbElmt >= 100,
    /* Cont'd */
    msg_store_inventory_full(MSG), write(MSG), 
    nl, nl, open_store, !.

buy :-
    game_start(true),
    in_battle(true),
    msg_in_battle(MSG), write(MSG),
    nl, nl, open_store, !.

buy :-
    game_start(false),
    msg_game_not_started(MSG), write(MSG).