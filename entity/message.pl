/* In Game Messages */
msg_game_not_started("Game has not started, use \'start.\' to play the game.").
msg_crush_wall("You crush the wall.").
msg_move("W", "You move north.").
msg_move("S", "You move south.").
msg_move("A", "You move west.").
msg_move("D", "You move east.").
msg_in_battle("You can't do that. You are in battle.").
msg_level_up("Congratulations, you've leveled up!").

/* Store Messages */
msg_store_not_near("You can't open store here.").
msg_store_inventory_full("Inventory full. Please remove an item before you proceed.").
msg_store_gold_not_enough("Gold not enough. Go kill some enemies or clear some quests.").
msg_store_welcome("Welcome to SimpaeTu\'s Store, you need it, we got it.", "Use \'gacha\' to get weapons. Gold needed is 100.", "Use \'buy\' to buy potions.", "Use \'quit\' to go back to your adventure!").
msg_gacha_get("Congratulations! You got: ").
msg_store_after_buy("Thank you for purchasing!").
msg_store_potions("Type the potion's name or use \'back\' to go back to main store.").

/* Inventory Messages */
msg_remove_success(Item) :-
	write('You\'ve successfully removed '),
	write(Item),
	write(' from your inventory.'), !.

msg_remove_fail("There's no such item.").

/* Dungeon Messages */
msg_dungeon_not_near("You can't open dungeon here.").

/* Help Messages */
show_help :-
    write('COMMAND LIST'), nl,
    nl,
	write('start.          : start a new game'), nl,
    write('load.           : load previously saved game'), nl,
	write('save(Filename). : save your game'), nl,
	write('status.         : show character stats'), nl,
	write('map.            : look at the map '), nl,
	write('w. a. s. d.     : move'), nl,
	write('inventory.      : open inventory'), nl,
    write('store.          : enter store (must be standing near store)'), nl,
    write('dungeon.        : enter dungeon (must be standing near dungeon)'), nl,
	write('help.           : show available commands'), nl,
	write('quit.           : quit the game'), nl.
    /* Tambah seperlunya. */