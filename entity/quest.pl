/* Fakta mengenai setiap quest, berapa enemy yang harus dikalahkan dan apa bountynya */

/* Dynamic predicates */
:- dynamic(kill/2).
:- dynamic(start_quest/1).

start_quest(false).

/* Quest */
/* Format: Nomor, ID, kill, ID, kill, ... */
quest(1, 0, 5).
quest(2, 1, 4).
quest(3, 2, 4).
quest(4, 3, 5).
quest(5, 0, 3, 2, 5).
quest(6, 0, 1, 2, 4, 3, 3).

/* Bounty */
/* Format: Nomor, gold, exp */
bounty(1, 10, 10).
bounty(2, 12, 20).
bounty(3, 15, 30).
bounty(4, 15, 40).
bounty(5, 20, 20).
bounty(6, 30, 15).