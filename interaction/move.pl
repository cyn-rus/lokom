
/* Gerak ke atas */
w :-
    game_start(true),
    (\+ isWall(0, -1)), isMoveable(0, -1),
    map_player(P), map_object(X,Y,P), map_nothing(N),
    Move is Y-1,
    msg_move("W", MSG), write(MSG),
    retract(map_object(X,Y,P)),
    assertz(map_object(X,Move,P)), 
    retract(map_object(X,Move,N)),
    assertz(map_object(X,Y,N)), !.

w :- 
    game_start(false), !,
        write('Game has not started, use \"start.\" to play the game"').
w :- 
    in_battle, !,
        write('You are in a battle. Use \'help.\' to display all commands available in a battle!').
s :-
    game_start(true),
    (\+ isWall(0, 1)), isMoveable(0, 1),
    map_player(P), map_object(X,Y,P), map_nothing(N),
    Move is Y+1, 
    msg_move("S", MSG), write(MSG),
    retract(map_object(X,Y,P)),
    assertz(map_object(X,Move,P)), 
    retract(map_object(X,Move,N)),
    assertz(map_object(X,Y,N)), !.
    
s :- 
    game_start(false), !,
        write('Game has not started, use \"start.\" to play the game"').
s :- 
    in_battle, !,
        write('You are in a battle. Use \'help.\' to display all commands available in a battle!').
a :-
    game_start(true),
    (\+ isWall(-1, 0)), isMoveable(-1, 0),
    map_player(P), map_object(X,Y,P), map_nothing(N),
    Move is X-1, 
    msg_move("A", MSG), write(MSG),
    retract(map_object(X,Y,P)),
    assertz(map_object(Move,Y,P)), 
    retract(map_object(Move,Y,N)),
    assertz(map_object(X,Y,N)), !.
    
a :- 
    game_start(false), !,
        write('Game has not started, use \"start.\" to play the game"').
a :- 
    in_battle, !,
        write('You are in a battle. Use \'help.\' to display all commands available in a battle!').
d :-
    game_start(true),
    (\+ isWall(1, 0)), isMoveable(1, 0),
    map_player(P), map_object(X,Y,P), map_nothing(N),
    Move is X+1, 
    msg_move("D", MSG), write(MSG),
    retract(map_object(X,Y,P)),
    assertz(map_object(Move,Y,P)), 
    retract(map_object(Move,Y,N)),
    assertz(map_object(X,Y,N)), !.
    
d :- 
    game_start(false), !,
        write('Game has not started, use \"start.\" to play the game"').
d :- 
    in_battle, !,
        write('You are in a battle. Use \'help.\' to display all commands available in a battle!').