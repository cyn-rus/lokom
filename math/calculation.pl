/* Calculate new max */
calc_exp(Level, Exp) :-
    power(Level, 3, X1),
    X2 is X1 * 6,
    Exp is ceiling(X2 / 5).

calc_max_exp(Level, MaxExp) :-
    power(Level, 3, X1),
    X2 is X1 * 4, 
    (Level =:= 2 -> MaxExp is 12 ; MaxExp is ceiling(X2 / 5)), !.

calc_max_hp(Level, Before, Hp) :-
    X1 is Level-1,
    X2 is X1 * 5,
    Hp is Before+X2.   

calc_stats(Level, Before, Stats) :-
    X1 is Level-1,
    Stats is Before+X1.   