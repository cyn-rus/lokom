/* Membuat rule untuk generate map */
/* map_object(X, Y, Obj) | Obj at position (X, Y) */
:- dynamic(map_object/3).

map_wall("#").
map_boulderwall("X").
map_store("S").
map_player("P").
map_nothing("-").
map_dungeon("D").
map_quest("Q").

map_size(20).

generate_structure :- generate_wall, generate_wall, generate_building.

generate_building :-    map_size(S), map_store(Store), map_dungeon(Dungeon), map_quest(Quest),
                        XR is div(S, 2), YR is div(S, 2),
                        ShopX is 1+XR, ShopY is 1+YR, %kuadran 2
                        random(1, ShopX, X), random(1, ShopY, Y), asserta(map_object(X,Y, Store)),
                        DungeonY is ShopY+YR, %kuadran 3
                        random(1, ShopX, X2), random(ShopY, DungeonY, Y2), asserta(map_object(X2,Y2, Dungeon)),
                        QuestX is ShopX+XR, %kuadran 4
                        random(ShopX, QuestX, X3), random(ShopY, DungeonY, Y3), asserta(map_object(X3,Y3, Quest)).
                    

generate_wall :-    generate_random_hwall, generate_random_vwall,
                    ( chance_vwall -> ( chance_hwall -> true ; true) ; (chance_hwall -> true ; true) ).

chance_vwall :-  random(0, 50, VW), (VW >= 25), generate_random_vwall.

chance_hwall :-  random(0, 50, HW), (HW >= 25), generate_random_hwall.

generate_structure_2(X) :- (X >= 25), generate_random_vwall.

generate_random_hwall :-    map_size(S), HWallMin is div(S, 4), HWallMax is div(S,2),
                            random(HWallMin, HWallMax, HWall),
                            random(HWall, S, StartY), random(2, S, StartX),
                            make_hwall(StartX, StartY, HWall), !.

make_hwall(X, Y, 1) :-      map_boulderwall(Wall), assertz(map_object(X,Y, Wall)).

make_hwall(X, Y, Count) :-  map_boulderwall(Wall), assertz(map_object(X,Y, Wall)), 
                            DCount is Count-1, DY is Y-1, make_hwall(X, DY, DCount).

generate_random_vwall :-    map_size(S), VWallMin is div(S, 5), VWallMax is div(S,2),
                            random(VWallMin, VWallMax, VWall),
                            random(VWall, S, StartX), random(2, S, StartY),
                            make_vwall(StartX, StartY, VWall), !.

make_vwall(X, Y, 1) :-      map_boulderwall(Wall), assertz(map_object(X,Y, Wall)).

make_vwall(X, Y, Count) :-  map_boulderwall(Wall), assertz(map_object(X,Y, Wall)), 
                            DCount is Count-1, DX is X-1, make_vwall(DX, Y, DCount).

map :- game_start(true), !, draw_map.

map :- !,
	msg_game_not_started(MSG), write(MSG).
		
% Left Border
draw_point(X, Y) :- map_size(S), map_wall(W),
					X =:= 0, Y =< S+1, write(W), write(" "),
					DX is X+1, draw_point(DX, Y).
% Right Border
draw_point(X, Y) :- map_size(S), map_wall(W),
                    X =:= S+1, Y =< S+1, write(W), write(" "), nl,
					DY is Y+1, draw_point(0, DY).

% Top Border		
draw_point(X, Y) :- map_size(S), map_wall(W),
                    X < S+1, X > 0, Y =:= 0, write(W), write(" "),
					DX is X+1, draw_point(DX, Y).
% Bottom Border	
draw_point(X, Y) :- map_size(S), map_wall(W),
					X < S+1, X > 0, Y =:= S+1, write(W), write(" "),
					DX is X+1, draw_point(DX, Y).				

draw_point(X, Y) :- map_size(S),
					X < S+1, X > 0, Y < S+1, Y > 0,
					map_object(X, Y, Smth), !, write(Smth), write(" "),
					DX is X+1, draw_point(DX, Y).

draw_point(X, Y) :- map_size(S), map_nothing(N),
					X < S+1, X > 0, Y < S+1, Y > 0,
					(\+ map_object(X, Y, _)),
					write(N), write(" "),
					DX is X+1, draw_point(DX, Y).

draw_map :- draw_point(0, 0).

isWall(DX, DY) :-
    map_player(P), map_boulderwall(W), map_object(X, Y, P), CheckX is DX+X, CheckY is DY+Y,
    map_object(CheckX, CheckY, Obj), Obj =:= W,
    msg_crush_wall(MSG),
    write(MSG), !.

isWall(DX, DY) :-
    map_player(P), map_size(S), map_object(X, Y, P), 
    CheckX is X+DX, CheckY is Y+DY, (CheckX > S ; CheckX < 1 ; CheckY > S; CheckY < 1),
    msg_crush_wall(MSG),
    write(MSG), !.

isMoveable(DX, DY) :-
    map_player(P), map_nothing(N), map_object(X, Y, P), CheckX is DX+X, CheckY is DY+Y,
    map_object(CheckX, CheckY, Obj), Obj =:= N, !.

isNear(Obj) :-
    map_player(P), map_object(X, Y, P),
    A is X-1, map_object(A, Y, Obj2),
    Obj2 =:= Obj, !.

isNear(Obj) :-
    map_player(P), map_object(X, Y, P),
    A is X+1, map_object(A, Y, Obj2),
    Obj2 =:= Obj, !.

isNear(Obj) :-
    map_player(P), map_object(X, Y, P),
    A is Y-1, map_object(X, A, Obj2),
    Obj2 =:= Obj, !.

isNear(Obj) :-
    map_player(P), map_object(X, Y, P),
    A is Y+1, map_object(A, Y, Obj2),
    Obj2 =:= Obj, !.