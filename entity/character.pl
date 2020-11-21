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

/* Job */
/* Format: ID, Name, HP, Att, Def, Starter weapon */
job(0, "Swordman", 30, 4, 5, "sword").
job(1, "Archer", 20, 6, 4, "bow").
job(2, "Sorcerer", 15, 7, 4, "staff").
job(3, "Assassin", 25, 5, 3, "dagger").
job(4, "Cheater", 99, 99, 99, "buffer overflow").