/* File : start.pl */
/* File for starting and initializing the game. */

:- dynamic(game_start/1).

game_start(false).

start :-
    ["entity/message.pl"],
    ["entity/enemy.pl"],
    ["entity/character.pl"],
    ["entity/item.pl"],
    ["./interaction/battle/battle.pl"],
    ["./interaction/battle/cmd.pl"],
    ["./interaction/map.pl"],
    ["./interaction/move.pl"],
    ["./interaction/interaction.pl"],
   /* ["./interaction/store.pl"],*/
    /*mana_sempat(A,B,C,D),
    keburu_telat(E,F,G),
    writeln(A),writeln(B),writeln(C),writeln(D),writeln(),writeln(E),writeln(F),writeln(G),writeln(),*/

    retract(game_start(false)), !,
    asserta(game_start(true)),
    asserta(in_battle(false)),
    asserta(char_weapon(999)),
    asserta(char_armor(999)),
    generate_structure, map_player(P),
    asserta(map_object(15,1, P)).

start :-
    write('Use \'help.\' to look at available commands!').

help :-
    write('You have been helped.'), nl,
    show_help.
    /* Cek message.pl */

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