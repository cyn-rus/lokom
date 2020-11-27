store :-
    game_start(true),
    in_battle(false),
    isNear("S"),
    open_store, !.

store :-
    game_start(true),
    in_battle(true), msg_in_battle(MSG), write(MSG), !.

store :-
    game_start(true),
    (\+ isNear("S")), msg_store_not_near(MSG), write(MSG),!.

store :-
    game_start(false), msg_game_not_started(MSG), write(MSG), !.

dungeon :-
    game_start(true),
    in_battle(false),
    isNear("D"), battle_init_boss, !.

dungeon :-
    game_start(true),
    in_battle(true),
    msg_in_battle(MSG), write(MSG), !.

dungeon :-
    game_start(true),
    (\+ isNear("D")),
    msg_dungeon_not_near(MSG), write(MSG), !.

dungeon :-
    game_start(false),
    msg_game_not_started(MSG),
    write(MSG), !.

quest :-
    game_start(true),
    in_battle(false),
    isNear("Q"),
    acc_quest, !.

quest :-
    game_start(true),
    in_battle(true),
    msg_in_battle(MSG), write(MSG), !.

quest :-
    game_start(true),
    (\+ isNear("Q")),
    msg_quest_not_near(MSG), write(MSG), !.

quest :-
    game_start(false),
    msg_game_not_started(MSG),
    write(MSG), !.