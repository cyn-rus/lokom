/* Fakta mengenai setiap quest, berapa enemy yang harus dikalahkan dan apa bountynya */

/* Dynamic predicates */
:- dynamic(curr_quest/2).
:- dynamic(is_in_quest/1).
:- dynamic(current_temp/1).

/* Quest */
/* Format: Number, ID, kill, ID kill, ...., Gold, Exp */
quest(1, "Mana Tahu", [0, 5], 10, 10).
quest(2, "Semppato Key", [1, 4], 12, 20).
quest(3, "Keburururu TayLate", [2, 4], 15, 30).
quest(4, "Saia Fish", [3, 5], 15, 40).
quest(5, "Toffu Mixed Manna", [0, 3, 2, 5], 20, 20).
quest(6, "Tellat Yuk", [0, 1, 2, 4, 3, 3], 20, 15).

/* Just sum func to print */
print_bounty(Gold, Exp) :-
    write("Reward(s)"), nl,
    write("Gold : "), write(Gold), nl,
    write("Exp  : "), write(Exp), nl, nl.
    
print_quest_kill([Kill|B]) :-
    write(Kill), nl,
    print_quest_enemy(B).

print_quest_enemy([]).
print_quest_enemy([ID|B]) :-
    enemy(ID, Name, _, _, _, _),
    write("Kill "), write(Name), write(": "),
    print_quest_kill(B).

print_quest(Num) :-
    Num =:= 7, !.
print_quest(Num) :-
    quest(Num, Name, List, Gold, Exp),
    write(Num), write(". "), write(Name), nl,
    print_quest_enemy(List),
    print_bounty(Gold, Exp),
    Next_num is Num + 1,
    print_quest(Next_num).

print_curr_quest(Name) :-
    write("Quest Name: "), write(Name), nl,
    curr_quest(Name, Enemy),
    write("Enemies left"), nl,
    print_quest_enemy(Enemy).

/* Quest is chosen! */
choose_quest(Num) :-
    retractall(current_quest(_, _)),
    retract(is_in_quest(false)),
    asserta(is_in_quest(true)),
    quest(Num, Name, Arr, _, _),
    asserta(curr_quest(Name, Arr)),
    msg_quest_took_quest(Name), nl, nl, map, !.

acc_quest :-
    is_in_quest(false),
    print_quest(1),
    msg_quest_choose(MSG), write(MSG), nl,
    read(Param),
    ((Param = w -> w);
    (Param = a -> a);
    (Param = s -> s);
    (Param = d -> d);
    (choose_quest(Param))), !.

acc_quest :-
    is_in_quest(true), !,
    msg_quest_in_quest(MSG), write(MSG), nl.

cleared_quest :-
    retract(is_in_quest(true)),
    asserta(is_in_quest(false)),
    curr_quest(Name, _),
    quest(_, Name, _, Gold, Exp),
    retractall(curr_quest(_, _)),
    msg_quest_finish(MSG), write(MSG), nl,
    addExp(Exp),
    addGold(Gold).

current_quest :-
    game_start(true),
    is_in_quest(true),
    curr_quest(Name, _),
    print_curr_quest(Name), !.

current_quest :-
    game_start(true),
    is_in_quest(false),
    msg_quest_not_in_quest(MSG), write(MSG), nl, !.

current_quest :-
    game_start(false),
    msg_game_not_started(MSG), write(MSG), nl.

/* Functions after battle */
is_quest_finish_enemy([A|B]) :-
    (A = 0 -> is_quest_finish(B)), !.

is_quest_finish([]).
is_quest_finish([_|B]) :-
    is_quest_finish_enemy(B).

is_kill_zero(N) :-
    N =:= 0.

/* list itu isinya dari yg sebelumnya, X itu list yang habis diappend sblmnya, after_add newest list*/
enemy_decrease([Kill|_]) :-
    current_temp(X),
    (\+ is_kill_zero(Kill) -> (New_kill is Kill-1, add_after_elmt(X, New_kill, After_add), 
                               retractall(current_temp(_)), asserta(current_temp(After_add)))), !.

/* ceritanya dia mau ngurangin enemy yg udah dibunuh, nanti return list yang enemy udah kebunuh */
/* ID itu id enemy, [A|B] itu list lama */
move_to_new_list_enemy(ID, [A|B]) :-
    current_temp(Arr),
    add_after_elmt(Arr, A, New_arr),
    retractall(current_temp(_)),
    asserta(current_temp(New_arr)),
    move_to_new_list(ID, B).

move_to_new_list(_, []).
move_to_new_list(ID, [A|B]) :-
    current_temp(Arr),
    add_after_elmt(Arr, A, New_arr),
    retractall(current_temp(_)),
    asserta(current_temp(New_arr)),
    (ID = A -> (enemy_decrease(B), after(B, After_B), move_to_new_list(ID, After_B)) ;
    move_to_new_list_enemy(ID, B)).

reduce_enemy(ID):-
    curr_quest(Name, Enemy),
    move_to_new_list(ID, Enemy),
    current_temp(After_reduce),
    retractall(curr_quest(_, _)),
    asserta(curr_quest(Name, After_reduce)),
    retractall(current_temp(_)),
    (is_quest_finish(After_reduce) -> (cleared_quest);
    (current_quest)).

/* Let's use this func in battle */
is_enemy_in_quest(Id) :-
    asserta(current_temp([])),
    is_in_quest(true),
    curr_quest(_, Arr),
    (is_member(Id, Arr) -> (reduce_enemy(Id))), !.
is_enemy_in_quest(_).