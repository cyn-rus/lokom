/* Dynamic untuk penggunaan special special attack, dan run */

/* Dynamic Predicates */
:- dynamic(char_turn/1).
:- dynamic(enemy_turn/1).
:- dynamic(enemy_id/1).
:- dynamic(enemy_health/1).
:- dynamic(in_battle/1).
:- dynamic(can_special/1).

/* Special attack */
/* Format: ID, job ID, special attack name, damage */
special_attack(0, 0, "Slash of Heaven", 10).
special_attack(1, 1, "Raining Sun", 15).
special_attack(2, 2, "Kagebunshin", 8).
special_attack(3, 3, "Silent kill", 20).
special_attack(4, 4, "Shutdown", 12).

print_battle_info :-
    in_battle(true),
    enemy(enemy_id, enemy_name, _, _, _, _),
    write("Enemy : "), write(enemy_name), nl,
    enemy_health(HP),
    write("HP : "), write(HP), nl.

print_battle :-
    write("What are you going to do?"), nl,
    write("Type 'attack' or 'special' or 'do_nothing_if_you_mager_and_mau_bobo_aja' or 'run'?"), nl.

start_battle :-
    retract(in_battle(false)),
    assertz(in_battle(true)),
    # enemy(enemy_id, enemy_name, enemy_hp, enemy_atk, enemy_defense, enemy_level),
    # write("Enemy "), write(enemy_nama), write(" has appeared!"), nl,
    assertz(enemy_health(enemy_hp)),
    print_battle.

reduce_enemy_health(Damage) :-
    enemy_health(HP),
    NewEnemyHP is HP - Damage,
    retract(enemy_health(_)),
    assertz(enemy_health(NewEnemyHP)).

next_turn :-
    char_turn(X),
    X is X + 1,
    retract(char_turn(_)),
    assertz(char_turn(X)),
    check_turn,
    retract(enemy_turn(false)),
    assertz(enemy_turn(true)),
    is_enemy_death,
    enemy_attack.

attack :-
    in_battle(true),!,
    char_attack(Atk),
    char_weapon(weapon),
    calculate_damage(Atk, def, weapon, total)
    reduce_enemy_health(total),
    next_turn.

attack :- 
    in_battle(false), !,
    write('Not in battle').

special :-
    in_battle(true), !,
    can_special(true),
    char_job(Job),
    special_attack(_, Job, Name, Atk),
    enemy(enemy_id, _, _, _, enemy_defense, _),
    AtkNew is Atk - enemy_defense,
    reduce_enemy_health(AtkNew),
    write('You used special attack \''),
    write(Name),
    write('\''),
    retract(can_special(true)),
    assertz(can_special(false)),
    next_turn.

special :-
    in_battle(true),
    can_special(false), !,
    write('You can\'t use special right now. Choose another move!').

special :- 
    in_battle(false), !,
    write('Not in battle').

run_chance(R) :-
    in_battle(true),
    R >= 5,
    write('Kaboerrrrrr'),
    retract(in_battle(true)),
    assertz(in_battle(false)).

run_chance(R) :-
    in_battle(true),
    R < 5,
    write("Gagal kaboerrr").

run :-
    in_battle(true),
    random(1, 10, R),
    run_chance(R).

run :-
    in_battle(false), !,
    write('Not in battle').

found :- 
    found_enemy(Anon) , !,
    retract(enemy_type(_)),
    assertz(enemy_type(Anon)),
    enemy_hp(Anon, HP),
    retract(enemy_health(_)),
    assertz(enemy_health(HP)),
    start_battle.

is_death :-
    char_hp(HP),
    HP =< 0,
    write("Yha keburu mati y. Game over"),
    retract(in_battle(true)),
    assertz(in_battle(false)).

is_enemy_death :-
    enemy_hp(HP),
    HP =< 0,
    write("ezpz ggwp"),
    retract(in_battle(true)),
    assertz(in_battle(false)).

check_turn :-
    can_special(false),
    char_turn(X),
    X >= 3,
    retract(can_special(false)),
    assertz(can_special(true)),
    X is 0,
    retract(char_turn(_)),
    assertz(char_turn(X)).

enemy_attack :-
    enemy_turn(true),
    char_hp(HP),
    char_defense(Defense),
    enemy(enemy_id, _, _, Atk, _, _),
    AtkNew is Atk - Defense,
    HP is HP - AtkNew,
    retract(char_hp(_)),
    assertz(char_hp(HP)),
    retract(enemy_turn(true)),
    assertz(enemy_turn(false)),
    is_death.

calculate_damage(base, def, weapon, total) :-
    Atk is base - def,
    total is Atk + weapon,
    total > 0, !, total is 1.
current_status :-  
    write("Level : "),
    write(char_level),nl,
    write("Health : "),
    write(char_hp),nl,
    write("Attack : "),
    Attnew is char_attack + weapon,
    write(Attnew),nl,
    write("Defense : "),
    write(char_defense),nl.



    
