/* Fakta untuk item dengan mengunakkan sistem gacha (random) */

/* Check whether gold is enough or not */
gold_enough(X) :-
    gold(Y),
    Y >= X.

open_store :-
  game_start(true), !,
    write("Welcome to SimpaeTu\'s Store, you need it, we got it."),
    write("Use \'gacha\' to get weapons. Gold needed is 100."),
    write("Use \'buy\' to buy potions."),
    write("Use \'quit\' to go back to your adventure!"),
    read(Param),
    ((Param = gacha -> gacha);
    (Param = buy -> buy);
    (Param = quit -> exit_store)).

/* Gacha yoohoo */
gacha :-
    game_start(true),
    gold_enough(100), !,
    New_X is X - 100,
    retract(gold(X)),
    asserta(gold(New_X)),
    /*aaaaaaaaaaaaaaaaaaaaaaaaa*/
    random(0,6,Equip).
    /* Masukin ke inventory-nya gmna ya... */
    /* assert ke inventory */

gacha :-
    game_start(true),
    (\+ gold_enough(100)), !,
    gold(X) < 100, !,
    write('Gold not enough. Go kill some enemies or clear some quests.').

gacha :-
    game_start(true), !,
    write("You\'re not in a store. Use \'map.\' to check where the store is").

gacha :-
    game_start(false), !,
    write("The game hasn\'t even started yet. Use \'start.\' to start the game").

pay_potion(Y, ID_Chosen) :-
    Z1 is Z-Y, retract(gold(Z)), asserta(gold(Z1)), potion(ID_Chosen, X, A, B, C, D), 
    asserta(inventory(X)), write("Thank you for purchasing!"). %harus bkin add item ke inventory

/* Buy pots */
buy :-
    game_start(true),
    forall(potion(ID, Name, Att, Def, HP, Price),
    (write(Name), nl, write("Attack: "), write(Att), nl, write("Defense: "), nl, write("Health Point: "),
    write(HP), nl, write("Price: "), write(Price))),
    writeln("Type the potion's name or use \'back\' to go back to main store."),
    read(Param),
    (Param = back -> open_store ;
    potion(ID_Chosen, Param, A, B, C, Y),
    (gold_enough(Y) -> pay_potion(Y, ID_Chosen) ; write("Gold not enough. Go kill some enemies or clear some quests."))).
buy :-
    game_start(true), !,
    print("You\'re not in a store. Use \'map.\' to check where the store is").

buy :-
    game_start(false),
    write("The game hasn\'t even started yet. Use \'start.\' to start the game").

exit_store :-
    game_start(true),
    write("Thank you for visiting SimpaeTu\'s Store. Please do come back again!"),
    retract(is_in_store(true)),
    asserta(is_in_store(false)),
    map.