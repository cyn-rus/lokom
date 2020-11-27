/* Fakta untuk setiap enemy (slime, goblin, wolf) */
/* Rule untuk spawn enemy (jenis, lokasi) */

/* ID enemy and enemy name */
/* Format: ID, Name, HP, Attack, Defense, Level */
enemy(0, "Manna", 30, 20, 13, 11).
enemy(1, "Sempppato", 20, 13, 12, 6).
enemy(2, "Kebururu", 20, 13, 15, 6).
enemy(3, "Tellat-kun", 20, 15, 15, 5).
enemy(4, "DeangGatalGatal", 20, 41, 26, 5).
enemy(5, "Toffu (Tahu)", 40, 25, 13, 10).
enemy(6, "Kanikan", 15, 22, 12, 3).
enemy(7, "AcinAsiap", 25, 20, 10, 7).
enemy(8, "Anjayani", 26, 10, 12, 5).
enemy(9, "TarikSis", 25, 15, 10, 6).
enemy(10, "Semongko", 30, 22, 12, 4).
enemy(999, "IamBoss", 200, 30, 40, 10).
max_enemy(11).

enemy_def(0, 13).
enemy_def(1, 12).
enemy_def(2, 13).
enemy_def(3, 15).
enemy_def(4, 26).
enemy_def(5, 13).
enemy_def(6, 12).
/* Format Boss:  Name, HP, Attack, Defense, Level */

print_enemy(ID) :-
    enemy(ID, A, B, C, D, E),
    write(A), write(" Lv. "), write(E), nl,
    write("Health : "), write(B), nl,
    write("Attack : "), write(C), nl,
    write("Defense : "), write(D), nl.