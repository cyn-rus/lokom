/* RandomRate sama RandomRate2 buat nambahin Rate-randomnnya*/
found_enemy(Enemy) :-
    random(0,50,RandomRate),
    random(0,50,RandomRate2),
    random(0,7,EnemyId),
    RandomRate =< RandomRate2,
    write('You found a '),
    enemy(EnemyId,EnemyNama,_,_,_,_),
    write(EnemyNama),
    write('!\n').
