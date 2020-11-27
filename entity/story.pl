story_intro :-
  write('Pada suatu hari, hiduplah seorang manusia yang hidup sendiri, tanpa seorang yang menemani, bernama Syello.'), nl,
  write('Ia terbangun dan tersadar bahwa ia berada di dunia lain yang tidak diketahui.'), nl,
  syello,
  write('Sambil menatap langit yang berwarna-warni, Syello tidak mengingat apapun kecuali satu kalimat yaitu \'Mana sempat keburu telat\','), nl,
  write('dan fakta bahwa ia harus keluar dari dunia itu dalam beberapa hari saja,'), nl,
  write('jika tidak, ia akan terperangkap di dunia itu selamanya.'), nl,
  langit, nl,
  write('Syello sudah bertanya kepada orang-orang disekitar disana, namun jawaban mereka selalu'), nl,
  write('\"Lah mana saya tahu, saya kan ikan\".'), nl,
  ikan, nl,
  write('Sehingga, ia harus mencari jalan keluar sendiri.'), nl,
  write('Ia memutuskan untuk berpetualang di dalam dunia itu dengan harapan dapat mencari memorinya yang hilang.'), nl,
  write('Di awal petualangannya, Ia diharuskan memilih satu dari beberapa class yang tersedia.'), nl,
  write('Dan disitulah petualangannya dimulai...'), nl, 
  lets_go, nl.

boss_appear :-
  write('Syello melihat ke langit,'), nl,
  langit, nl,
  write('Ia melihat sebuah fenomena yang tidak biasa'), nl,
  write('\"Apakah langitnya bergetar? Gempa ya?!\", Syello bertanya-tanya.'), nl,
  write('Tak lama, langit pun membalas, \"Benar anakku\"'), nl,
  write('\"Lohhh kok kayaknya kenal, eh, Bapak?!!! Kenapa turun dari langit?\"'), nl,
  write('"Tadinya saya ingin turun pake tangga, tapi mana sempat lah keburu telat!", balas Bapak_Syello'), nl, nl,
  write('DUARRRR! Bapak_Syello menghancurkan tanah disekitar Syello'), nl,
  write('\"BAPAK! Kenapa menyerang bumi?!\"'), nl,
  write('\"Gapapa, pengen aja, bosen\"'), nl,
  papa_syello, nyerang_bumi, nl.

boss_death :-
  write('\"Adudu, ampun mas, jangan bunuh saya mas\", Bapak_Syello memohon'), nl,
  write('\"HENTIKAN SYELLO!\", dari kejauhan Syello mendengar suara yang tak asing'), nl,
  write('Ternyata oh ternyata, itu adalah Ibu_Syello'), nl,
  write('\"IBU?!! Ibu kita harus membunuh ayah karena ayah sudah menyerang bumi!\",'), nl,
  write('\"He em mana sempat\"'), nl,
  the_end,
  nl, nl,
  show_credits.