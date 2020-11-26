/* Calculate new max */
calc_exp(Level, Exp) :-
    power(Level, 3, X1),
    X2 is X1 * 4,
    Exp is ceiling(X2 // 5).

calc_max_exp(Level, MaxExp) :-
    power(Level, 3, X1),
    X2 is X1 * 4,
    MaxExp is ceiling(X2 // 5).

calc_max_hp(Level, Before, Hp) :-
    X1 is 2 * Before,
    X2 is X1 * Level,
    X3 is 100 + Level + 10,
    Hp is ceiling(X2 // X3).   

calc_stats(Level, Before, Stats) :-
    X1 is 2 * Before,
    X2 is X1 * Level,
    Stats is ceiling(X2 // 105).