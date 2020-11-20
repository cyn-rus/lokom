/* Gerak ke atas */
w :-
    game_start(true),
    (\+ isWall(0, -1)), isMoveable(0, -1),
    map_player(P), map_object(X,Y,P), map_nothing(N),
    Move is Y-1, 
    retract(map_object(X,Y,P)),
    assertz(map_object(X,Move,P)), 
    retract(map_object(X,Move,N)),
    assertz(map_object(X,Y,N)), !.
w :- 
    game_start(false), !,
        write('Game has not started, use \"start.\" to play the game"').
w :- 
    on_battle, !,
        write('You are in a battle. Use \'help.\' to display all commands available in a battle!').
s :-
    game_start(true),
    (\+ isWall(0, 1)), isMoveable(0, 1),
    map_player(P), map_object(X,Y,P), map_nothing(N),
    Move is Y+1, 
    retract(map_object(X,Y,P)),
    assertz(map_object(X,Move,P)), 
    retract(map_object(X,Move,N)),
    assertz(map_object(X,Y,N)), !.
s :- 
    game_start(false), !,
        write('Game has not started, use \"start.\" to play the game"').
s :- 
    on_battle, !,
        write('You are in a battle. Use \'help.\' to display all commands available in a battle!').
a :-
    game_start(true),
    (\+ isWall(-1, 0)), isMoveable(-1, 0),
    map_player(P), map_object(X,Y,P), map_nothing(N),
    Move is X-1, 
    retract(map_object(X,Y,P)),
    assertz(map_object(Move,Y,P)), 
    retract(map_object(Move,Y,N)),
    assertz(map_object(X,Y,N)), !.
a :- 
    game_start(false), !,
        write('Game has not started, use \"start.\" to play the game"').
a :- 
    on_battle, !,
        write('You are in a battle. Use \'help.\' to display all commands available in a battle!').
d :-
    game_start(true),
    (\+ isWall(1, 0)), isMoveable(1, 0),
    map_player(P), map_object(X,Y,P), map_nothing(N),
    Move is X+1, 
    retract(map_object(X,Y,P)),
    assertz(map_object(Move,Y,P)), 
    retract(map_object(Move,Y,N)),
    assertz(map_object(X,Y,N)), !.
d :- 
    game_start(false), !,
        write('Game has not started, use \"start.\" to play the game"').
d :- 
    on_battle, !,
        write('You are in a battle. Use \'help.\' to display all commands available in a battle!').