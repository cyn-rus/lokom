/* Fakta mengenai equipment (menambah berapa attack, defense, dll.) dan potion */

/* Equipments */
/* Format: ID, Name, att, def, HP */
equipment(999, "Nothing", 0, 0, 0).
equipment(0, "He_em_Sword", 3, 0, 0). 
equipment(1, "Manna_Bow", 5, 0, 0).
equipment(2, "Silicon_Staff", 7, 0, 0).
equipment(3, "Fesh_Dagger", 8, 0, 0).
equipment(4, "Stack_Overflow", 99, 99, 99).
equipment(5, "Nomiap_Armor", 0, 5, 0).
equipment(6, "Saiacan_Icant_Armor", 0, 7, 3).
equipment(7, "Teesllat_Headband", 2, 4, 3).
equipment(8, "Cabooru_Necklace", 3, 7, 6).
idx_maxequipment(9).

/* Facts for weapons */
weapon(0).
weapon(1).
weapon(2).
weapon(3).
weapon(4).

/* Facts for armor */
armor(5).
armor(6).

/* Facts for accessories */
accessories(7).
accessories(8).

/* Potions */
/* Format: ID, Name, att, def, HP, price */
potion(-1, "Yuk", 0, 0, 5, 5).
potion(-2, "Bisa_Yucc", 0, 2, 4, 7).
potion(-3, "IF2121", 5, 5, 0, 14).
potion(-4, "Assembly", 7, 2, 3, 18).
potion(-5, "Emergency_Food", 2, 10, 10, 25).
potion(-6, "Childe", 10, 10, 10, 30).

item_print(NAME, ATK, DEF, HP) :-
    write(NAME), nl,
    write("ATK: "), write(ATK), nl,
    write("DEF: "), write(DEF), nl,
    write("HP : "), write(HP), nl.

every_potion_print(ID, NAME, ATK, DEF, HP, PRICE) :-
    Number is ID*(-1),
    write(Number), write(". "),
    write(NAME), nl,
    write("ATK   : "), write(ATK), nl,
    write("DEF   : "), write(DEF), nl,
    write("HP    : "), write(HP), nl,
    write("Price : "), write(PRICE), nl, nl.

potion_print(ID, NAME, ATK, DEF, HP, PRICE) :-
    ID =:= -6,
    every_potion_print(ID, NAME, ATK, DEF, HP, PRICE), !.

potion_print(ID, NAME, ATK, DEF, HP, PRICE) :-
    every_potion_print(ID, NAME, ATK, DEF, HP, PRICE),
    NEW_ID is ID - 1,
    potion(NEW_ID, NEW_NAME, NEW_ATK, NEW_DEF, NEW_HP, NEW_PRICE),
    potion_print(NEW_ID, NEW_NAME, NEW_ATK, NEW_DEF, NEW_HP, NEW_PRICE).