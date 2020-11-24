/* Fakta mengenai equipment (menambah berapa attack, defense, dll.) dan potion */

/* Equipments */
/* Format: ID, Name, att, def, HP */
equipment(0, "He em Sword", 3, 0, 0). 
equipment(1, "Manna Bow", 5, 0, 0).
equipment(2, "Silicon Staff", 7, 0, 0).
equipment(3, "Fesh Dagger", 8, 0, 0).
equipment(4, "Stack Overflow", 99, 99, 99).
equipment(5, "Nomiap ", 0, 5, 0).
equipment(6, "Saiacan Icant", 0, 7, 3).
equipment(7, "Teesllat", 2, 4, 3).
equipment(8, "Cabooru", 3, 7, 6).
idx_maxequipment(8).

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
potion(0, "Yuk", 0, 0, 5, 5).
potion(1, "Bisa Yucc", 0, 2, 4, 7).
potion(2, "IF2121", 5, 5, 0, 14).
potion(3, "Assembly", 7, 2, 3, 18).
potion(4, "Emergency Food", 2, 10, 10, 25).
potion(5, "Childe", 10, 10, 10, 30).

item_print(NAME, ATK, DEF, HP) :-
    write(NAME), nl,
    write("ATK: "), write(ATK), nl,
    write("DEF: "), write(DEF), nl,
    write("HP : "), write(HP), nl.

potion_print(NAME, ATK, DEF, HP, PRICE) :-
    write(NAME), nl,
    write("ATK   : "), write(ATK), nl,
    write("DEF   : "), write(DEF), nl,
    write("HP    : "), write(HP), nl,
    write("Price : "), write(PRICE), nl.