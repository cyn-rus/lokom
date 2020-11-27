/* Fakta untuk setiap enemy (slime, goblin, wolf) */
/* Rule untuk spawn enemy (jenis, lokasi) */

/* ID enemy and enemy name */
/* Format: ID, Name, HP, Attack, Defense, Level */
enemy(0, "Manna", 30, 20, 8, 7).
enemy(1, "Sempppato", 20, 16, 2, 6).
enemy(2, "Kebururu", 20, 14, 6, 6).
enemy(3, "Tellat-kun", 20, 15, 7, 5).
enemy(4, "DeangGatalGatal", 20, 16, 10, 5).
enemy(5, "Toffu (Tahu)", 40, 15, 9, 10).
enemy(6, "Kanikan", 25, 22, 6, 7).
enemy(7, "AcinAsiap", 25, 20, 10, 8).
enemy(8, "Anjayani", 26, 10, 11, 5).
enemy(9, "TarikSis", 35, 15, 9, 8).
enemy(10, "Semongko", 30, 12, 12, 4).
enemy(999, "Bapak_Syello", 300, 70, 40, 20).
max_enemy(11).

/* Format Boss:  Name, HP, Attack, Defense, Level */

print_enemy(ID) :-
    enemy(ID, A, B, C, D, E),
    write(A), write(" Lv. "), write(E), nl,
    write("Health : "), write(B), nl,
    write("Attack : "), write(C), nl,
    write("Defense : "), write(D), nl.