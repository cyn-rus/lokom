msg_game_not_started("Game has not started, use \'start.\' to play the game.").
msg_crush_wall("You crush the wall.").
msg_move("W", Y) :- Y is "You move north.", !.
msg_move("S", Y) :- Y is "You move south.", !.
msg_move("A", Y) :- Y is "You move west.", !.
msg_move("D", Y) :- Y is "You move east.", !.
msg_in_battle("You can't do that. You are in battle.").
msg_store_not_near("You can't open store here.").