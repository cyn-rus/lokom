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
    battle_tick,  enemy_attack, !.

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

use_potion :- 
    in_battle(true),
    inventory(List, _),
    \+ is_member(-1, List),
    \+ is_member(-2, List),
    \+ is_member(-3, List),
    \+ is_member(-4, List),
    \+ is_member(-5, List),
    \+ is_member(-6, List),
    write("You don\'t have any potions in your inventory."), nl, !.
 
use_potion :-
    in_battle(true),
    write("Select your potions: \n"),
    inventory(X, _),
    print_potion(X),
    read(Name),
    potion(ID, Name, Atk, Def, Hp, _),
    is_member(ID, X), !,
    remove(Name),
    write('You used '), write(Name), nl,
    ((Atk > 0) ->
    write('You gained '), write(Atk), write(' Atk!'), nl, 
    char_attack(CurAtk), NewAtk is CurAtk + Atk, update_attack(NewAtk) ; true),
    ((Def > 0) ->
    write('You gained '), write(Def), write(' Def!'), nl,
    char_defense(CurDef), NewDef is CurDef + Def, update_defense(NewDef) ; true ),
    ((Hp > 0) ->
    write('You gained '), write(Hp), write(' HP!'), nl,
    char_hp(CurHp), char_maxhp(MaxHp), NewHp is CurHp + Hp,
    ((NewHp > MaxHp) -> update_hp(MaxHp) ; update_hp(NewHp)), ! ; true), !.
    
    
