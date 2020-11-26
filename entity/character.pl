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

/* Job */
/* Format: ID, Name, HP, Att, Def, Starter weapon */
job(0, "Swordman", 30, 4, 5, "sword").
job(1, "Archer", 20, 6, 4, "bow").
job(2, "Sorcerer", 15, 7, 4, "staff").
job(3 , "Assassin", 25, 5, 3, "dagger").
job(4, "Cheater", 99, 99, 99, "buffer overflow").

/* Special attack */
/* Format: ID, job ID, special attack name, damage */
special_attack(0, 0, "Slash of Heaven", 10).
special_attack(1, 1, "Raining Sun", 15).
special_attack(2, 2, "Kagebunshin", 8).
special_attack(3, 3, "Silent kill", 20).
special_attack(4, 4, "Shutdown", 12).

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

/* Precondition: exp >= max exp */
level_up :-
    char_level(LEVEL_BEFORE),
    LEVEL_NOW is LEVEL_BEFORE + 1,
    retract(char_level(LEVEL_BEFORE)),
    assertz(char_level(LEVEL_NOW)),
    level_up_exp(LEVEL_NOW),
    level_up_hp(LEVEL_NOW),
    level_up_att(LEVEL_NOW),
    level_up_def(LEVEL_NOW),
    msg_level_up(MSG),
    write(MSG).

/* Leveling up stats */
level_up_exp(Level) :-
    char_exp(NowExp), char_maxexp(NowMaxExp), NextExp is NowMaxExp - NowExp,
    update_exp(NextExp),
    calc_max_exp(Level, NextMaxExp), update_max_exp(NextMaxExp).

level_up_hp(Level) :-
    char_maxhp(NowMaxHp), calc_max_hp(Level, NowMaxHp, NextMaxHp),
    update_max_hp(NextMaxHp), update_hp(NextMaxHp).

level_up_atk(Level) :-
    char_attack(NowStats), calc_max_stats(Level, NowStats, NextStats),
    update_attack(NextStats).

level_up_def(Level) :-
    char_defense(NowStats), calc_max_stats(Level, NowStats, NextStats),
    update_defense(NextStats).

show_status :- 
    write("Job : "), write(char_job), nl,
    write("Level : "), write(char_level), nl,
    write("Health : "), write(char_hp), write("/"),
    write(char_maxhp), nl,
    write("Attack : "), Attnew is char_attack + weapon, write(Attnew), nl,
    write("Defense : "), write(char_defense), nl,
    write("Exp : "), write(char_exp), write("/"), write(char_maxexp), nl,
    write("Gold : "), write(char_gold), nl.