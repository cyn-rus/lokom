/* Fakta untuk item dengan mengunakkan sistem gacha (random) */

/* Check whether gold is enough or not */

is_in_store :- game_start(true), isNear("S").

open_store :-
    game_start(true), is_in_store, msg_store_welcome(MSG, MSG2, MSG3, MSG4),
    write(MSG), nl, write(MSG2), nl, write(MSG3), nl, write(MSG4), nl, 
    read(Param),
    ((Param = gacha -> gacha);
    (Param = buy -> buy)).

/* Gacha yoohoo */

/* Case: inventory not full, gold enough */
gacha :-
    is_in_store,
    inventory(List, Max),
    /* Check Inventory */
    count_elmt(List, Num),
    Num < Max,
    /* Cont'd */
    gold_enough(100), !,
    removeGold(100),
    random(0, 8, ID),
    equipment(ID, Name, Att, Def, HP), msg_gacha_get(MSG),
    write(MSG), item_print(Name, Att, Def, HP).
    /* Input to Inventory */
    add_elmt(ID, List, Result),
    retract(inventory(List, Max)),
    asserta(inventory(Result, Max)).


/* Case: inventory full */
gacha :-
    is_in_store,
    inventory(List, Max),
    /* Check Inventory */
    count_elmt(List, Num),
    Num == Max,
    /* Cont'd */
    msg_store_inventory_full(MSG), write(MSG), !.

/* Case: gold not enough */
gacha :-
    is_in_store,
    (\+ gold_enough(100)),
    msg_store_gold_not_enough(MSG), write(MSG), !.

gacha :-
    game_start(true), (\+ isNear("S")),
    msg_store_not_near(MSG), write(MSG), !.

gacha :-
    game_start(false),
    msg_game_not_started(MSG), write(MSG), !.

pay_potion(Y, ID_Chosen) :-
    inventory(List, Max),
    removeGold(Y), potion(ID_Chosen, X, A, B, C, D),
    /* Input to Inventory */
    add_elmt(ID_Chosen, List, Result),
    retract(inventory(List, Max)),
    asserta(inventory(Result, Max)).
    msg_store_after_buy(MSG), write(MSG).

/* Buy pots */

/* Case: inventory not full */
/* Sorry I had to, it was getting confusing... */
buy :-
    game_start(true),
    in_battle(false), !,
    /* Check Inventory */
    inventory(List, Max),
    count_elmt(List, Num),
    Num < Max,
    /* Cont'd */
    forall(potion(ID, Name, Att, Def, HP, Price),
    potion_print(Name, Att, Def, HP, Price)),
    msg_store_potions(MSG), write(MSG),
    read(Param),
    (Param = back -> open_store ;
    potion(ID_Chosen, Param, A, B, C, Y),
    (gold_enough(Y) -> pay_potion(Y, ID_Chosen) ; msg_store_gold_not_enough)).

/* Case: inventory full */
buy :-
    game_start(true),
    in_battle(false), !,
    /* Check Inventory */
    inventory(List, Max),
    count_elmt(List, Num),
    Num =:= Max,
    /* Cont'd */
    msg_store_inventory_full(MSG), write(MSG), !.

buy :-
    game_start(true),
    in_battle(true), !,
    msg_in_battle(MSG), write(MSG).

buy :-
    game_start(false),
    msg_game_not_started(MSG), write(MSG).