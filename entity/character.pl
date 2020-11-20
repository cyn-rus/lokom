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

/* ID job and job name */
job(0, "Swordman").
job(1, "Archer").
job(2, "Sorcerer").
job(3, "Assassin").
job(4, "Cheater").

/* HP of every job */
job_hp(0, 30).
job_hp(1, 20).
job_hp(2, 15).
job_hp(3, 25).
job_hp(4, 99).

/* Attack of every job */
job_att(0, 4).
job_att(1, 6).
job_att(2, 7).
job_att(3, 5).
job_att(4, 99).

/* Defense of every job */
job_def(0, 5).
job_def(1, 4).
job_def(2, 4).
job_def(3, 3).
job_def(4, 99).

/* Starter weapon of every job */
job_weap(0, "sword").
job_weap(1, "bow").
job_weap(2, "staff").
job_weap(3, "dagger").
job_weap(4, "buffer overflow").