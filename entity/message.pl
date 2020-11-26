/* In Game Messages */
msg_game_not_started("Game has not started, use \'start.\' to play the game.").
msg_crush_wall("You crush the wall.").
msg_move("W", "You moved north.").
msg_move("S", "You moved south.").
msg_move("A", "You moved west.").
msg_move("D", "You moved east.").
msg_teleport(X, Y) :-
    write("You teleported to <"), write(X), write(","), write(Y), write(">."), nl.
msg_in_battle("You can't do that. You are in battle.").
msg_level_up("Congratulations, you've leveled up!").
msg_get_exp(Exp) :-
	write("You got "),
	write(Exp),
	write(" Exp! ").
msg_get_gold(Gold, Total) :-
	write("You got "),
	write(Gold),
	write(" Gold! Your total Gold is "),
	write(Total).

/* Store Messages */
msg_store_not_near("You can't open store here.").
msg_store_inventory_full("Inventory full. Please remove an item before you proceed.").
msg_store_gold_not_enough("Gold not enough. Go kill some enemies or clear some quests.").
msg_store_welcome("Welcome to SimpaeTu\'s Store, you need it, we got it.", "Use \'gacha\' to get weapons (100 Gold).", "Use \'buy\' to buy potions.", "Move to quit the store.").
msg_gacha_get("Congratulations! You got: ").
msg_store_after_buy("Thank you for purchasing!").
msg_store_potions("Type the potion's number or use \'back\' to go back to main store.").
msg_store_show_gold(Gold) :-
	write("You have "),
	write(Gold),
	write(" gold"), nl.
msg_store_wrong_param("Oops, input not valid!").

/* Dungeon Messages */
msg_dungeon_not_near("You can't open dungeon here.").

/* Quest Messages */
msg_quest_not_near("You can't accept quest here.").
msg_quest_choose("Type the quest's number or move to not accept.").
msg_quest_in_quest("Oops, it looks like there was a wrong input or you've accepted a quest, go finish the quest first.").
msg_quest_not_in_quest("Well, you don't have any ongoing quest, go to \'Q\' and type \'quest.\' to accept one.").
msg_quest_finish("Congratz, you've finished your quest").
msg_quest_took_quest(Name) :-
	write("You've just taken "), write(Name), write(" quest. Good luck!").

/* Inventory Messages */
msg_invent_empty :-
	write("Nothing to see here. Move along.").
msg_invent_notempty :-
	write("Your current items:").
msg_invent_command :-
	write("Type \'remove(Item)\' to remove an item.").

msg_remove_success(Item) :-
	write("You\'ve successfully removed "),
	write(Item),
	write(" from your inventory.").

msg_remove_fail :-
	write("There's no such item.").

msg_select_command :-
	write("Select one weapon by typing this \'selects(your weapon)\' command").

/* Help Messages */
show_help :-
    write("COMMAND LIST"), nl,
    nl,
	write("start.          : start a new game"), nl,
    write("load.           : load previously saved game"), nl,
	write("save(Filename). : save your game"), nl,
	write("status.         : show character stats"), nl,
	write("map.            : look at the map "), nl,
	write("w.		       : move north"), nl,
	write("a.			   : move west"), nl,
	write("s.			   : move south"), nl,
	write("d.              : move east"), nl,
	write("open_inventory  : see inventory items"), nl,
    write("store.          : enter store (must be standing near store)"), nl,
    write("dungeon.        : enter dungeon (must be standing near dungeon)"), nl,
	write("quest.		   : accept a quest (must be standing near quest or not taking any)"), nl,
	write("current_quest.  : see progress of ongoing quest"), nl,
	write("help.           : show available commands"), nl,
	write("quit.           : quit the game"), nl.
    /* Tambah seperlunya. */

/* Battle messages */
msg_ask_what_to_do :-
	write("What are you going to do?"), nl.

msg_battle_commands :-
	write("Type \'attack\' or \'special\' or \'do_nothing_if_you_mager_and_mau_bobo_aja\' or \'run\'?"), nl.

msg_attack(Damage) :-
	write("You deals "), write(Damage), write(" damage to enemy!"), nl.

msg_spattack(Damage) :-
    write("Special Attack!"), nl,
	write("You deals "), write(Damage), write(" damage to enemy!"), nl.

msg_enemy_attack(Damage) :-
	write("Enemy deals "), write(Damage), write(" damage to you!"), nl.

msg_special :-
	char_job(Job),
    special_attack(_, Job, Name, _),
	write("You used special attack \'"), write(Name), write("\'!"), nl.

msg_cannot_special :-
	write("You can\'t use special right now. Choose another move!"), nl.

msg_enemy_hp(Enemyid, Enemyhealth) :-
	enemy(Enemyid, Enemyname, Enemymaxhp, _, _, _),
	write(Enemyname),write("\'s HP : "), write(Enemyhealth), write("/"), write(Enemymaxhp), nl.

msg_player_hp :-
	char_hp(hp),
	char_maxhp(maxhp),
	write("Player HP : "), write(hp), write("/"), write(maxhp), nl.

msg_player_level :-
	char_level(level),
	write("Level : "), write(level), nl.
msg_not_in_battle("Not in battle").
msg_run_success :-
	write("Kaboerrrrr!"), nl.
msg_run_failed :-
	write("Gagal kaboerrr!"), nl.
msg_player_death :-
	write("Yha keburu mati y. Game over"), nl.
msg_enemy_death :-
	write("ggwp ezpz"), nl.
msg_enemy_found :-
    write("You found an enemy."), nl.

msg_pick_job :-
    write("Welcome to Mana Sempat Keburu Telat!"), nl,
    write("Choose your job"), nl.