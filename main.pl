/* File : start.pl */
/* File for starting and initializing the game. */

:- dynamic(game_start/1).

game_start(false).

start :-
    ["./utils/list.pl"],
    ["./math/power.pl"],
    ["./math/calculation.pl"],
    ["./entity/message.pl"],
    ["./entity/enemy.pl"],
    ["./entity/character.pl"],
    ["./entity/item.pl"],
    ["./entity/inventory.pl"],
    ["./entity/art.pl"],
    ["./entity/story.pl"],
    ["./interaction/battle/battle.pl"],
    ["./interaction/battle/cmd.pl"],
    ["./interaction/map.pl"],
    ["./interaction/move.pl"],
    ["./interaction/interaction.pl"],
    ["./interaction/store.pl"],
    ["./interaction/quest.pl"],
    /*mana_sempat(A,B,C,D),
    keburu_telat(E,F,G),
    writeln(A),writeln(B),writeln(C),writeln(D),writeln(),writeln(E),writeln(F),writeln(G),writeln(),*/

    retract(game_start(false)), !,
    asserta(game_start(true)),
    asserta(in_battle(false)),
    story_intro,
    pick_job, asserta(inventory([], 0)), asserta(gold(0)), asserta(is_in_quest(false)),
    generate_structure, map_player(P),
    asserta(map_object(20,1, P)).

start :-
    write('Use \'help.\' to look at available commands!').

help :-
    write('You have been helped.'), nl,
    show_help.
    /* Cek message.pl */

game_over :-
    write('Game over!'), nl,
    retract(game_start(true)),
    asserta(game_start(false)),
    retractall(map_object(_,_,_)),
    retractall(inventory(_,_)),
    retractall(gold(_)),
    ask_play_again.

ask_play_again :-
    write('Do you want to play again ?'), nl,
    write('1. Yes'), nl,
    write('2. No'), nl,
    read(X), ((X =:= 2) -> write('See ya later!'),nl ; ((X=:=1) -> start ; write('Invalid input!') , nl, ask_play_again)), !.

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