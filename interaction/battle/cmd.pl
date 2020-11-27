battle_info :-
    in_battle(true),
    print_battle_info, print_battle.

battle_status :-
    in_battle(true),
    current_status, print_battle.

attack :-
    in_battle(true),
    char_attack(Atk), char_weapon(IDWeapon),
    equipment(IDWeapon, _, Weapon, _, _),
    enemy_status(ID, HP), enemy(ID, _, _, _, Def, _),
    calculate_damage(Atk, Def, Weapon, Total),
    NextHP is HP - Total,
    msg_attack(Total),
    update_enemy_hp(NextHP),
    battle_tick, enemy_attack, !.

attack :- 
    in_battle(false),
    msg_not_in_battle(MSG), write(MSG), nl, !.

run :-
    in_battle(true),
    random(0, 100, R),
    ((R =< 49 -> 
    (msg_run_success,
    retract(in_battle(true)),
    asserta(in_battle(false)))) ; (msg_run_failed,enemy_attack)), !.

run :-
    in_battle(false),
    msg_not_in_battle(MSG), write(MSG), nl.

special :-
    in_battle(true), special_attack_ready(true), update_state_sa(false),
    char_job(Job), special_attack(_, Job, _, Atk), char_weapon(IDWeapon),
    equipment(IDWeapon, _, Weapon, _, _),
    enemy_status(ID, HP), enemy(ID, _, _, _, Def, _),
    calculate_damage(Atk, Def, Weapon, Total),
    NextHP is HP - Total,
    msg_spattack(Total),
    update_enemy_hp(NextHP),
    battle_tick, enemy_attack, !.

special :-
    in_battle(true), special_attack_ready(false),
    msg_cannot_special, !.

special :-
    in_battle(false),
    msg_not_in_battle, !.

% use_potion :- 
    % in_battle(true),
    % inventory(_, NbElmt),
    % NbElmt =:= 0,
    % write('You don\'t have any potions in your inventory'), nl.
    
use_potion :-
    in_battle(true),
    write('Select your potions: '),
    inventory(X, _),
    print_potion(X).