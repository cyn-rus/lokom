/* Fakta status (attack, defense, max HP) untuk setiap job (Swordsman, Archer, Sorcerer) */
/* Dynamic untuk EXP, level, attack, defense, dan max HP */
/* Rule EXP sudah melewati batas */

/* Dynamic predica */
:- dynamic(char_job/1).
:- dynamic(char_maxhp/1).
:- dynamic(char_hp/1).
:- dynamic(char_exp/1).
:- dynamic(char_maxexp/1).
:- dynamic(char_attack/1).
:- dynamic(char_defense/1).
:- dynamic(char_level/1).
:- dynamic(char_weapon/1).
:- dynamic(char_armor/1).
:- dynamic(char_accessories/1).

pick_job :-
    msg_pick_job,
    write("1. Swordman"), nl,
    write("2. Archer"), nl,
    write("3. Sorcerer"), nl,
    write("4. Assassin"), nl,
    write("5. Cheater"), nl,
    read(X), ((X =< 5) -> nl,
    ((X >= 1) ->
    ID is X-1, init_character(ID), true; 
    write("That job is not exist."), nl, nl, pick_job) ;
    write("That job is not exist."), nl, pick_job), !.

init_character(ID) :-
    job(ID, Name, HP, Atk, Def, _), calc_max_exp(1, MaxExp),
    assertz(char_level(1)), assertz(char_exp(0)), assertz(char_job(ID)),
    assertz(char_maxhp(HP)), assertz(char_hp(HP)), assertz(char_maxexp(MaxExp)),
    assertz(char_attack(Atk)), assertz(char_defense(Def)),
    assertz(char_weapon(999)), assertz(char_armor(999)), assertz(char_accessories(999)),
    write("You choose "), write(Name), write(", let\'s explore the world"), nl.

/* Job */
/* Format: ID, Name, HP, Att, Def, Starter weapon */
job(0, "Swordman", 60, 15, 8, "sword").
job(1, "Archer", 45, 23, 9, "bow").
job(2, "Sorcerer", 52, 17, 10, "staff").
job(3 , "Assassin", 55, 19, 8, "dagger").
job(4, "Cheater", 99, 99, 99, "buffer overflow").

/* Special attack */
/* Format: ID, job ID, special attack name, damage */
special_attack(0, 0, "Slash of Heaven", 30).
special_attack(1, 1, "Raining Sun", 45).
special_attack(2, 2, "Kagebunshin", 38).
special_attack(3, 3, "Silent kill", 40).
special_attack(4, 4, "Shutdown", 32).

update_exp(After) :-
    retractall(char_exp(_)),
    assertz(char_exp(After)).

update_max_exp(After) :-
    retractall(char_maxexp(_)),
    assertz(char_maxexp(After)).

update_max_hp(After) :-
    retractall(char_maxhp(_)),
    assertz(char_maxhp(After)).

update_hp(After) :-
    retractall(char_hp(_)),
    assertz(char_hp(After)).

update_attack(After) :-
    retractall(char_attack(_)),
    assertz(char_attack(After)).

update_defense(After) :-
    retractall(char_defense(_)),
    assertz(char_defense(After)).

level_up :-
    char_level(LEVEL_BEFORE),
    LEVEL_NOW is LEVEL_BEFORE + 1,
    msg_level_up(MSG),
    write(MSG),
    write(LEVEL_NOW),
    write("!\n"),
    retract(char_level(LEVEL_BEFORE)),
    assertz(char_level(LEVEL_NOW)),
    level_up_exp(LEVEL_NOW),
    level_up_hp(LEVEL_NOW),
    level_up_atk(LEVEL_NOW),
    level_up_def(LEVEL_NOW).

/* Leveling up stats */
level_up_exp(Level) :-
    char_exp(NowExp), char_maxexp(NowMaxExp), NextExp is NowExp-NowMaxExp,
    update_exp(NextExp),
    calc_max_exp(Level, NextMaxExp), update_max_exp(NextMaxExp),
    ((NextExp >= NextMaxExp) -> level_up, ! ; true).

level_up_hp(Level) :-
    char_maxhp(NowMaxHp), calc_max_hp(Level, NowMaxHp, NextMaxHp),
    update_max_hp(NextMaxHp), update_hp(NextMaxHp).

level_up_atk(Level) :-
    char_attack(NowStats), calc_stats(Level, NowStats, NextStats),
    update_attack(NextStats).

level_up_def(Level) :-
    char_defense(NowStats), calc_stats(Level, NowStats, NextStats),
    update_defense(NextStats).

show_status :- 
    char_job(Job),
    job(Job, JobName, _, _, _, _),
    write("Job : "), write(JobName), nl,
    char_level(Lvl),
    write("Level : "), write(Lvl), nl,
    char_hp(Health),
    write("Health : "), write(Health), write("/"),
    char_maxhp(Maxhp),
    write(Maxhp), nl,
    write("Attack : "), char_attack(Atk), char_weapon(IDWeapon), 
    equipment(IDWeapon, WName, Weapon, _, _),
    AtkT is Atk + Weapon, write(AtkT), nl,
    char_armor(IDArmor), equipment(IDArmor, AName, _, Armor, _),
    char_defense(Def), DefT is Def + Armor,
    write("Defense : "), write(DefT), nl,
    char_exp(Exp),
    write("Exp : "), write(Exp), write("/") ,char_maxexp(Maxexp) ,write(Maxexp), nl,
    gold(Gold),
    write("Gold : "), write(Gold), nl,
    write("Weapon : "), write(WName),
    write("Armor : "), write(AName).

addExp(Add) :-
    msg_get_exp(Add),
    char_exp(Exp_before),
    Exp_new is Exp_before + Add,
    update_exp(Exp_new),
    char_maxexp(MaxExp),
    ((Exp_new >= MaxExp) -> level_up, ! ; true).