/* In Game Messages */
msg_game_not_started("Gamenya belum dimulai, gunakan \'start.\' untuk bermain segara sebelum terlambat.").
msg_crush_wall("Depan kamu tembok tuh :(").
msg_move("W", "Derapkan langkah tatap ke Utara.").
msg_move("S", "Derapkan langkah tatap ke Selatan.").
msg_move("A", "Derapkan langkah tatap ke Barat.").
msg_move("D", "Derapkan langkah tatap ke Timur.").
msg_teleport(X, Y) :-
    write("BOOM! Sudah teleport ke <"), write(X), write(","), write(Y), write(">."), nl.
msg_in_battle("Mana sempat, depan kamu ada musuh >:(").
msg_level_up("Hooray, sudah naik ke level ").
msg_get_exp(Exp) :-
	write("Cie dapat "),
	write(Exp),
	write(" Exp! \n").
msg_get_gold(Gold, Total) :-
	write("Cie dapat "),
	write(Gold),
	write(" Gold! Total Gold yang dimiliki adalah "),
	write(Total).

/* Store Messages */
msg_store_not_near("Hei, tidak ada toko di sekitar kamu!!!!").
msg_store_inventory_full("Mana sempat, Inventory sudah penuh. Kosongi dulu yuk Inventory-nya").
msg_store_gold_not_enough("Mana sempat, Gold tidak cukup. Yuk bunuh enemy dulu atau selesaikan quest.").
msg_store_welcome("Selamat datang di Toko SimpaeTu, you need it, we got it.", "Gunakan \'gacha.\', mungkin kamu bisa dapet SSR :3.", "Gunakan \'buy.\' untuk beli potion, tapi tidak ada ramuan cinta :(.", "Tidak mau beli atau gacha? Derapkan langkahmu!").
msg_gacha_get("Cieee.. kamu dapet: ").
msg_store_after_buy("Makasih udah beli di toko SimpaeTu <3").
msg_store_potions("Diketik yuk angka dari potionnya atau kalau ga mau, ketik \'back.\' aja EHE.").
msg_store_show_gold(Gold) :-
	write("Wah, kamu punya "),
	write(Gold),
	write(" Gold"), nl.
msg_store_wrong_param("Punten, inputnya yang bener dong :(").

/* Dungeon Messages */
msg_dungeon_not_near("Hei, tidak ada dungeon di sekitar kamu!!!!").

/* Quest Messages */
msg_quest_not_near("Hei, tidak ada quest di sekitar kamu!!!").
msg_quest_choose("Diketik sekuy nomor questnya, sekalian grinding eyak, tapi kalau kamu ga mau, bisa gerak aja hehe.").
msg_quest_in_quest("Punten, kamu antara salah masukin input atau masih ada quest, kelarin dulu lah >:(").
msg_quest_not_in_quest("He em, emang kamu udah ambil quest? Coba ke \'Q\' terus ketik \'quest.\' deh.").
msg_quest_finish("Cie, ada yang questnya kelar nih.").
msg_quest_took_quest(Name) :-
	write("Wadadidaw, kamu ngambil quest "), write(Name), write(". Semangat ya, lup lup <3").

/* Inventory Messages */
msg_invent_empty :-
	write("Heh, inventory kamu k o s o n g."), nl.
msg_invent_notempty :-
	write("Hemmmmmmm, jadi isi inventory kamu: "), nl.
msg_invent_command :-
	write("Mau buang barang ga berguna? Ketik aja \'remove(Item).\', \'Item\' yang dimaksud ini nama barangnya yaaa :3 pake kutip \" jangan lupa"), nl.

msg_remove_success(Item) :-
	write("Cieeee, ada yang berhasil buang "), nl,
	write(Item),
	write(" dari inventronya nich."), nl.

msg_remove_fail :-
	write("Mana ada barang itu!"), nl.

msg_select_command :-
	write("Hayu hayu hayu, dipilih dulu salah satu weapon/armornya."),nl.

/* Help Messages */
show_help :-
    write("                          COMMAND LIST                          "), nl,
	write(" ==============================================================="), nl,
	write("||start.              : start game"), nl,
    write("||load.               : load game"), nl,
	write("||save(Filename).     : save game"), nl,
	write("||show_status.        : lihat status kamu, single </3"), nl,
	write("||map.                : kepo mau liat map"), nl,
	write("||w.    				 : derapkan langkah tatap ke Utara"), nl,
	write("||a.	    	   		 : derapkan langkah tatap ke Barat"), nl,                                 
	write("||s.	   				 : derapkan langkah tatap ke Selatan"), nl,
	write("||d.       	   		 : derapkan langkah tatap ke Timur"), nl,
	write("||open_inventory.     : cek inventory"), nl,
	write("||select_weapon.      : untuk memilih weapon"), nl,
	write("||select_armor.       : untuk memilih armor "), nl,
	write("||select_accessories. : untuk memilih accessories"), nl,
    write("||store.              : masuk ke dalam toko (harus berada di dekat \'S\')"), nl,
    write("||dungeon.            : masuk ke dalam dungeon (harus berada di dekat \'D\')"), nl,
	write("||quest.              : terima quest (harus berada di dekat \'Q\'"), nl,
	write("||                      dan tidak ada quest yang aktif)"), nl,
	write("||current_quest.      : cek progres quest yang sedang aktif"), nl,
	write("||help.               : lupa commandnya apa aja? Ketik ini aja"), nl,
	write("||quit.               : keluar dari game :("), nl,
	write(" ==============================================================="),nl.
    /* Tambah seperlunya. */

/* Battle messages */
msg_ask_what_to_do :-
	write("Hayo, mau ngapain?"), nl.

msg_battle_commands :-
	write("Ketik \'attack.\' atau \'special.\' atau \'do_nothing_if_you_mager_and_mau_bobo_aja.\' atau \'run.\'?"), nl.

msg_attack(Damage) :-
	write("Wah ketjeh banget, kamu barusan hantam dengan kekuatan "), write(Damage), write("."), nl.

msg_spattack(Damage) :-
    write("SUPESYARU ATAKKU !1!!!11!1!"), nl,
	write("Hantaman kamu barusan sebesar "), write(Damage), write("."), nl.

msg_enemy_attack(Damage) :-
	write("Aduh, hantamannya sebesar  "), write(Damage), write(" :("), nl.

msg_special :-
	char_job(Job),
    special_attack(_, Job, Name, _),
	write("Wah, special attack \'"), write(Name), write(" digunakan!"), nl.

msg_cannot_special :-
	write("Ga bisa pake special attacknya sekarang :'(. Gunakan langkah lain ya :("), nl.

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
msg_not_in_battle("Lagi kagak battle cuy.").
msg_run_success :-
	write("Kaboerrrrr!"), nl.
msg_run_failed :-
	write("Gagal kaboerrr! Mana sempat, keburu dihantam duluan."), nl.
msg_player_death :-
	write("Yha keburu mati y. Game over"), nl.
msg_enemy_death :-
	write("ggwp ezpz"), nl.
msg_enemy_found :-
    write("Euh, ada enemy."), nl.

msg_pick_job :-
    write("Welcome to Mana Sempat Keburu Telat!"), nl,
    write("Choose your job"), nl.

/* Credits yay! */

show_credits :-
	write("This game is made for Tubes IF2121 Logika Komputasional by:"), nl,
	write("-----------------------------------------------------------"), nl,
	write("                13519002    Steven Nataniel                "), nl,
	write("                13519089    Marcello Faria                 "), nl,
	write("                13519118    Cynthia Rusadi                 "), nl,
	write("                13519134    Frederic Ronaldi               "), nl,
	write("                13519166    Karina Imani                   "), nl,
	write("-----------------------------------------------------------"), nl,
	write("                            FIN                            "), nl.