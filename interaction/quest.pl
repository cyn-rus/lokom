/* Fakta mengenai setiap quest, berapa enemy yang harus dikalahkan dan apa bountynya */

:- include("../entity/enemy.pl").
:- include("../entity/character.pl").
:- include("../entity/inventory.pl").
:- include("../entity/message.pl").

/* Dynamic predicates */
:- dynamic(current_quest/2).
:- dynamic(is_in_quest/1).

is_in_quest(false).
game_start(true).

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
    current_quest(Name, Enemy),
    write("Enemies left"), nl,
    print_quest_enemy(Enemy).

/* Quest is chosen! */
choose_quest(Num) :-
    retract(is_in_quest(false)),
    asserta(is_in_quest(true)),
    quest(Num, Name, Arr, _, _),
    asserta(current_quest(Name, Arr)),
    msg_quest_took_quest(Name), nl, nl, map.

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
    current_quest(Name, _),
    quest(_, Name, _, Gold, Exp),
    retractall(current_quest(_, _)),
    msg_quest_finish(MSG), write(MSG), nl,
    addExp(Exp),
    addGold(Gold).

current_quest :-
    game_start(true),
    is_in_quest(true),
    current_quest(Name, _),
    print_curr_quest(Name), !.

current_quest :-
    game_start(true),
    is_in_quest(false),
    msg_quest_not_in_quest(MSG), write(MSG), nl, !.

current_quest :-
    game_start(false),
    msg_game_not_started(MSG), write(MSG), nl.

/* Functions after battle */
is_quest_finish([], _).
is_quest_finish([A|B], X) :-
    add_elmt(A, X, New_list),
    ((B = 0 -> (after(B, After_B), is_quest_finish(After_B, New_list)));
    !).

enemy_decrease([Kill|_], X, After_add) :-
    New_kill is Kill-1,
    add_elmt(New_kill, X, After_add).

move_to_new_list(_, [], _).
move_to_new_list(ID, [A|B], X) :-
    add_elmt(A, X, After_add),
    (ID = A -> (enemy_decrease(B, After_add, New_arr),
    after(B, After_B), move_to_new_list(ID, After_B, New_arr));
    (move_to_new_list(ID, B, After_add))).

reduce_enemy(ID) :-
    current_quest(ID, Enemy),
    move_to_new_list(ID, Enemy, After_reduce),
    retract(ID, Enemy),
    asserta(ID, After_reduce),
    (is_quest_finish(After_reduce, []) -> (cleared_quest);
    (curret_quest)).

/* Let's use this func in battle */
is_enemy_in_quest(Id) :-
    is_in_quest(true),
    current_quest(_, Arr),
    (is_member(Id, Arr) -> reduce_enemy(Id)), !.
is_enemy_in_quest(_).