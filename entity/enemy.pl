/* Fakta untuk setiap enemy (slime, goblin, wolf) */
/* Rule untuk spawn enemy (jenis, lokasi) */

/* ID enemy and enemy name */
/* Format: ID, Name, HP, Attack, Defense, Level */
enemy(0, "Manna", 30, 20, 13, 11).
enemy(1, "Sempppato", 20, 13, 12, 2).
enemy(2, "Kebururu", 20, 13, 13, 3).
enemy(3, "Tellat-kun", 70, 15, 15, 6).
enemy(4, "Saia", 100, 41, 26, 15).
enemy(5, "Toffu (Tahu)", 40, 25, 13, 6).
enemy(6, "Kanikan", 55, 32, 12, 7).
max_enemy(7).

enemy_def(0, 13).
enemy_def(1, 12).
enemy_def(2, 13).
enemy_def(3, 15).
enemy_def(4, 26).
enemy_def(5, 13).
enemy_def(6, 12).
/* Format Boss:  Name, HP, Attack, Defense, Level */
boss("IamBoss", 1000, 1000, 1000, 70).

print_enemy(ID) :-
    enemy(ID, A, B, C, D, E),
    write(A), write(" Lv. "), write(E), nl,
    write("Health : "), write(B), nl,
    write("Attack : "), write(C), nl,
    write("Defense : "), write(D), nl.