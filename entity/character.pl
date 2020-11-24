/* Fakta status (attack, defense, max HP) untuk setiap job (Swordsman, Archer, Sorcerer) */
/* Dynamic untuk EXP, level, attack, defense, dan max HP */
/* Rule EXP sudah melewati batas */

/* Dynamic predicates */
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

/* Calculate new max */
new_max_exp(LEVEL, NEW_MAX) :-
    power(LEVEL, 3, X1),
    X2 is X1 * 4,
    NEW_MAX is ceiling(X2 // 5).

new_max_hp(LEVEL, BEFORE, NEW_MAX) :-
    X1 is 2 * BEFORE,
    X2 is X1 * LEVEL,
    X3 is 100 + LEVEL + 10,
    NEW_MAX is ceiling(X2 // X3).   

new_max_stats(LEVEL, BEFORE, NEW_MAX) :-
    X1 is 2 * BEFORE,
    X2 is X1 * LEVEL,
    NEW_MAX is ceiling(X2 // 105).

/* Leveling up stats */
level_up_exp(LEVEL) :-
    char_exp(EXP_BEFORE),
    char_maxexp(MAX_EXP_BEFORE),
    EXP_NOW is MAX_EXP_BEFORE - EXP_BEFORE,
    retract(char_exp(EXP_BEFORE)),
    assertz(char_exp(MAX_EXP_BEFORE)),
    new_max_exp(LEVEL, NEW_MAX),
    retract(char_maxexp(MAX_EXP_BEFORE)),
    assertz(char_maxexp(NEW_MAX)).

level_up_hp(LEVEL) :-
    char_maxhp(MAX_HP_BEFORE),
    new_max_hp(LEVEL, MAX_HP_BEFORE, NEW_MAX_HP),
    retract(char_maxhp(MAX_HP_BEFORE)),
    assertz(char_maxhp(NEW_MAX_HP)),
    retractall(char_hp(HP_BEFORE)),
    assertz(char_hp(NEW_MAX_HP)).

level_up_att(LEVEL) :-
    char_attack(ATT_BEFORE),
    new_max_stats(LEVEL, ATT_BEFORE, NEW_ATT),
    retract(char_attack(ATT_BEFORE)),
    assertz(char_atack(NEW_ATT)).

level_up_def(LEVEL) :-
    char_defense(DEF_BEFORE),
    new_max_stats(LEVEL, DEF_BEFORE, NEW_DEF),
    retract(char_defense(DEF_BEFORE)),
    assertz(char_attack(NEW_DEF)).

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
show_status :- 
    write("Job : "),
    write(char_job),nl,
    write("Level : "),
    write(char_level),nl,
    write("Health : "),
    write(char_hp),
    write("/"),
    write(char_maxhp),nl,
    write("Attack : "),
    Attnew is char_attack + weapon,
    write(Attnew),nl,
    write("Defense : "),
    write(char_defense),nl,
    write("Exp : "),
    write(char_exp),
    write("/"),
    write(char_maxexp),nl,
    write("Gold : ").
    write(char_gold),nl.
/* ni belom ada? */
pay_potion(Y, ID_Chosen).