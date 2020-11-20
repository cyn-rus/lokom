/* File : start.pl */
/* File for starting and initializing the game. */

:- dynamic(game_start/1).

game_start(false).

start:-
    ["entity/enemy.pl"],
    ["entity/character.pl"],
    ["./interaction/map.pl"],

    retract(game_start(false)), !,
    asserta(game_start(true)),
    generate_structure, map_player(P),
    asserta(map_object(15,1, P)).

start :-
    write('Use \'help.\' to look at available commands!').

help :-
    write('You have been helped.'). % TODO create help

quit :- 
    game_start(true),
    write('Progress will not be saved after you quit.'),nl,
    write('Are you sure? (y/n): '),
    read(Param),
    (Param = y -> halt;
    (Param = n -> fail)).

save :-
    write("Saving game data to data.dat...\n"),
    nl,
    open("data.dat",write,S),
    set_output(S),
    listing,
    close(S),
    write("Game Data have been successfully saved."),
    nl.

load :-
    write("Loading game data from data.data"),
    nl,
    ["data.dat"],
    write("Game Data have been successfully loaded."),
    nl.