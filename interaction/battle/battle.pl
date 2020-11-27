:- dynamic(in_battle/1).
% enemy_status(Enemy_ID, Enemy_HP).
:- dynamic(enemy_status/2).
% turn(Integer).
:- dynamic(turn/1).
% Special_Attack_Ready(Boolean)
:- dynamic(special_attack_ready/1).

randomize_enemy(ID) :-
    max_enemy(X), random(0,X,ID).

found_enemy(EnemyId) :-
    random(0,100,RandomRate),
    randomize_enemy(REnemyId),
    ((RandomRate =< 40) ->
        msg_enemy_found,
        print_enemy(REnemyId),EnemyId is REnemyId ; EnemyId is -1).

battle_init :-
    found_enemy(X),
    ((X =:= -1) ->
        true;
        update_battle(true), update_enemy(X),
        update_state_sa(false), update_turn(0), print_battle).

battle_init_boss :-
    update_battle(true), update_enemy(999),
    update_state_sa(false), update_turn(0), print_battle.

update_battle(State) :-
    retractall(in_battle(_)),
    assertz(in_battle(State)).

update_enemy(ID) :-
    enemy(ID, _, HP, _, _, _),
    retractall(enemy_status(_, _)),
    assertz(enemy_status(ID, HP)).

update_enemy_hp(After) :-
    enemy_status(ID, _),
    retractall(enemy_status(_, _)),
    assertz(enemy_status(ID, After)).

update_state_sa(State) :-
    retractall(special_attack_ready(_)),
    assertz(special_attack_ready(State)).

update_turn(After) :-
    retractall(turn(_)),
    assertz(turn(After)).

calculate_damage(Base, Def, Weapon, Total) :-
    Atk is Base - Def,
    X is Atk + Weapon,
    ((X > 0) -> Total is X; Total is 1).

battle_tick :-
    turn(Turn),
    NextTurn is Turn+1,
    update_turn(NextTurn),
    X is Turn mod 6,
    ((X =:= 0) ->
    update_state_sa(true) ; true),
    char_hp(HP),
    enemy_status(_, EHP),
    ((HP =< 0) ->
    msg_player_death,
    game_over,
    update_battle(false), ! ; true),
    ((EHP =< 0) ->
    msg_enemy_death,
    enemy(_, _, _, _, _, Lvl),
    random(4, Lvl, Exp),
    addExp(Exp),
    update_battle(false), ! ; true), !.

enemy_attack :-
    enemy_status(ID, EHP),
    ((EHP >= 0) ->
    char_hp(HP), char_defense(Defense),
    enemy(ID, Name, _, Atk, _, _),
    calculate_damage(Atk, Defense, 0, Total),
    write(Name),
    write(" deal "),
    write(Total),
    write(" damage"),
    NextHP is HP - Total,
    update_hp(NextHP),
    battle_tick;!).

print_battle_info :-
    in_battle(true),enemy_status(ID, HP),
    msg_player_hp,
    msg_enemy_hp(ID, HP).

print_battle :-
    msg_ask_what_to_do,
    msg_battle_commands.

current_status :-  
    char_weapon(IDWeapon), char_attack(Att),
    equipment(IDWeapon, _, Weapon, _, _),
    Attnew is Att + Weapon, char_hp(Hp), char_level(Level), char_defense(Def),
    write("Level : "), write(Level), nl,
    write("Health : "), write(Hp), nl,
    write("Attack : "), write(Attnew), nl,
    write("Defense : "), write(Def), nl.