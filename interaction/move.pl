on_move :- draw_map.
/* Gerak ke atas */
w :-
    game_start(true),
    (\+ isWall(0, -1)), isMoveable(0, -1),
    map_player(P), map_object(X,Y,P),
    Move is Y-1,
    msg_move("W", MSG),
    retract(map_object(X,Y,P)),
    assertz(map_object(X,Move,P)), on_move, write(MSG), !.

w :- game_start(false), msg_game_not_started(MSG), write(MSG), !.
w :- in_battle(true), msg_in_battle(MSG), write(MSG), !.

s :-
    game_start(true),
    (\+ isWall(0, 1)), isMoveable(0, 1),
    map_player(P), map_object(X,Y,P),
    Move is Y+1, 
    msg_move("S", MSG),
    retract(map_object(X,Y,P)),
    assertz(map_object(X,Move,P)), on_move, write(MSG), !.
 
s :- game_start(false), msg_game_not_started(MSG), write(MSG), !.
s :- in_battle(true), msg_in_battle(MSG), write(MSG), !.

a :-
    game_start(true),
    (\+ isWall(-1, 0)), isMoveable(-1, 0),
    map_player(P), map_object(X,Y,P),
    Move is X-1, 
    msg_move("A", MSG),
    retract(map_object(X,Y,P)),
    assertz(map_object(Move,Y,P)), on_move, write(MSG), !.
    
a :- game_start(false), msg_game_not_started(MSG), write(MSG), !.
a :- in_battle(true), msg_in_battle(MSG), write(MSG), !.

d :-
    game_start(true),
    (\+ isWall(1, 0)), isMoveable(1, 0),
    map_player(P), map_object(X,Y,P),                      
    Move is X+1,
    msg_move("D", MSG), 
    retract(map_object(X,Y,P)),
    assertz(map_object(Move,Y,P)), on_move, write(MSG), !.
    
d :- game_start(false), msg_game_not_started(MSG), write(MSG), !.
d :- in_battle(true), msg_in_battle(MSG), write(MSG), !.