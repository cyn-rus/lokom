/* RandomRate sama RandomRate2 buat nambahin Rate-randomnnya*/
found_enemy(EnemyId) :-
    random(0,50,RandomRate),
    random(0,50,RandomRate2),
    random(0,7,EnemyId),
    RandomRate =< RandomRate2,
    write('You found a '),
    enemy(EnemyId,EnemyNama,EnemyHP,EnemyDefense,EnemyAttack,EnemyLevel),
    write(EnemyNama),nl,
    write("Level : "),
    write(EnemyLevel),nl,
    write("Health : "),
    write(EnemyHP),nl,
    write("Attack : "),
    Attnew is char_attack + weapon,
    write(EnemyAttack),nl,
    write("Defense : "),
    write(EnemyDefense),nl.
