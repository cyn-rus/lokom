on_move :- draw_map, battle_init.
/* Gerak ke atas */
w :-
    game_start(true), in_battle(false),
    (\+ isWall(0, -1)), isMoveable(0, -1),
    map_player(P), map_object(X,Y,P),
    Move is Y-1,
    msg_move("W", MSG),
    retract(map_object(X,Y,P)),
    assertz(map_object(X,Move,P)),on_move, write(MSG), !.

w :- game_start(false), msg_game_not_started(MSG), write(MSG), !.
w :- in_battle(true), msg_in_battle(MSG), write(MSG), !.

s :-
    game_start(true), in_battle(false),
    (\+ isWall(0, 1)), isMoveable(0, 1),
    map_player(P), map_object(X,Y,P),
    Move is Y+1, 
    msg_move("S", MSG),
    retract(map_object(X,Y,P)),
    assertz(map_object(X,Move,P)),on_move, write(MSG), !.
 
s :- game_start(false), msg_game_not_started(MSG), write(MSG), !.
s :- in_battle(true), msg_in_battle(MSG),write(MSG), !.

a :-
    game_start(true), in_battle(false),
    (\+ isWall(-1, 0)), isMoveable(-1, 0),
    map_player(P), map_object(X,Y,P),
    Move is X-1, 
    msg_move("A", MSG),
    retract(map_object(X,Y,P)),
    assertz(map_object(Move,Y,P)), on_move, write(MSG), !.
    
a :- game_start(false), msg_game_not_started(MSG), write(MSG), !.
a :- in_battle(true), msg_in_battle(MSG), write(MSG), !.

d :-
    game_start(true), in_battle(false),
    (\+ isWall(1, 0)), isMoveable(1, 0),
    map_player(P), map_object(X,Y,P),                      
    Move is X+1,
    msg_move("D", MSG), 
    retract(map_object(X,Y,P)),
    assertz(map_object(Move,Y,P)), on_move, write(MSG), !.
    
d :- game_start(false), msg_game_not_started(MSG), write(MSG), !.
d :- in_battle(true), msg_in_battle(MSG), write(MSG), !.

teleport :-
    game_start(true), in_battle(false),
    write("Teleporting will cost you 50 gold. Proceed?"), nl, read(Ans),
    ((Ans = y) -> 
    ((gold_enough(50)) -> 
    write("Masukkan koordinat X: "), nl,
    read(X),
    write("Masukkan koordinat Y: "), nl,
    read(Y),
    map_player(P), map_object(A, B, P),
    DX is X-A, DY is Y+B,
    (\+ isWall(DX, DY)), isMoveable(DX, DY),
    msg_teleport(X, Y),removeGold(50),
    retract(map_object(_,_,P)),
    assertz(map_object(X,Y,P)), draw_map ; msg_store_gold_not_enough(MSG), write(MSG), !) ; write("Canceled")).

teleport :- game_start(false), msg_game_not_started(MSG), write(MSG), !.
teleport :- in_battle(true), msg_in_battle(MSG), write(MSG), !.