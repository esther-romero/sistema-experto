
%ACCION
conocimiento(lucy, [accion, aventura], [adrenalinico, emocionante], [scarlett_johansson, morgan_freeman, min_sik_choi]).
conocimiento(alias, [accion, aventura, policiales], [crudo], [alban_lenoir, eric_cantona]).
conocimiento(linea_de_fuego, [accion, aventura, policiales], [violento, crudo], [jason_statham, james_franco, izabela_vidovic]).
conocimiento(alerta_roja, [comedia, accion, aventura], [irrelevante, emocionante], [dwayne_johnson, ryan_reynolds, gal_gadot]).
conocimiento(se_busca, [accion, aventura], [violento], [james_mcavoy, angelina_jolie, morgan_freeman]).
conocimiento(el_infierno, [dramatico, accion, aventura], [violento, crudo], [damian_alcazar, joaquin_cosio, ernesto_gomez]).
conocimiento(lou, [dramatico, accion, aventura], [crudo, suspenso], [allison_janney, jurnee_smollett, logan]).
conocimiento(pixeles, [comedia, accion, aventurera], [emocionante], [adam_sandler, kevin_james, michelle_monaghan]).

%DRAMA
conocimiento(crepusculo, [dramatico, romantico], [inquietud, suspenso, romantico], [kristen_stewart, robert_pattinson, billy_burke]).
conocimiento(anonima, [dramatico, romantico], [excentrico, optimista, romantico], [annie_cabello, ralf, estefi_merelles]).
conocimiento(paternidad, [dramatico, hechos_reales], [emotivo], [kevin_hart, alfre_woodard, lil_rel]).
conocimiento(mujercitas, [dramatico, familia], [emotivo], [saoirse_ronan, emma_watson, florence_pugh]).
conocimiento(nunca_mas, [dramatico, intriga], [suspenso], [jennifer_lopez, billy_campbell, tessa_allen]).
conocimiento(after, [dramatico, romance], [intenso], [tamara_chestna, susan_mcmartin, tom_betterton]).
conocimiento(spider_man, [dramatico, accion, aventura], [ciencia_ficcion, suspenso, emocionante], [tom_holland, michael_keaton, robert_downey]).
conocimiento(el_ultimo_vagon, [familia, dramatico], [optimista, emotivo], [adriana_barraza, kaaclo_isaacs])

%COMEDIA
conocimiento(turbo, [comedia, animacion, familia], [ingenioso, emocionante], [ryan_reynolds, paul_giamatti, samuel_jackson]).
conocimiento(son_como_ninios, [comedia], [optimista, disparatado], [adam_sandler, kevin_james, chris_rock]).
conocimiento(mascotas, [comedia, familia], [disparatado], [louis, erick_stonestreet, kevin_hart]).
conocimiento(donde_estan_las_rubias, [comedia, policiales], [picante, disparatado], [shawn_wayans, marion_wayans, jaime_king]).
conocimiento(tres_idiotas, [romantica, comedia], [picante, romance], [alfonso_dosal, christian_vazquez, martha_higareda]).
conocimiento(misterio_a_la_vista, [comedia, misterio, accion, aventura], [disparatado, suspenso, emocionante], [adam_sandler, jennifer_aniston, mark_strong]).
conocimiento(fubar, [dramatico, accion, aventura], [irreverente, emocionante], [arnold_schwarzenegger, monica_barbaro, milan_carter]).
conocimiento(shrek, [familia, comedia, satiras], [ingenioso, optimista], [mike_myers, eddie_murphy, cameron_diaz]).
conocimiento(sing, [familia, comedia, infantil], [disparatado], [matthew_mcconaughey, reese_witherspoon, seth_macfarlane]).

%TERROR
conocimiento(tin_tina, [terror, intriga], [traumatico], [milesa_smit, jaime_lorente, anastasia_russo]).
conocimiento(los_inocentes, [terror, intriga], [traumatico, suspenso], [sandra_escacena, bruna_gonzalez, claudia_placer]).

conocimiento(dos_corazones, [romantico, hechos_reales], [emotivo,romantico], [jacob_elordi, adan_canto, radha_mitchell]).
conocimiento(hambre, [dramatico, de_tailandia], [inspirador, suspenso], [chutimon, nopachai, gunn_svasti]).


% conocimiento(nombre, [generos], [caracteristicas], [elenco])

%filtrar todas las peliculas por genero dado el genero
filtrar_genero(GENERO, PELICULA) :- conocimiento(PELICULA, GENEROS, _, _), member(GENERO, GENEROS).

%filtrar todas las peliculas por genero dado una lista de generos
cumple_con_genero(Pelicula, Genero) :- conocimiento(Pelicula, Generos, _, _), member(Genero, Generos).
filtrar_por_generos(Generos, Peliculas) :- setof(Pelicula, Genero^(conocimiento(Pelicula, _, _, _), member(Genero, Generos), cumple_con_genero(Pelicula, Genero)), Peliculas).

%filtrar todas las peliculas por caracteristica dado la caracteristica
filtrar_caracteristica(CARACTERISTICA, PELICULA) :- conocimiento(PELICULA, _, CARACTERISTICAS, _), member(CARACTERISTICA, CARACTERISTICAS).

%filtrar todas las peliculas por caracteristica dado una lista de caracteristicas
cumple_con_caracteristica(Pelicula, Caracteristica) :- conocimiento(Pelicula, _, Caracteristicas, _), member(Caracteristica, Caracteristicas).
filtrar_por_caracteristicas(Caracteristicas, Peliculas) :- setof(Pelicula, Caracteristica^(conocimiento(Pelicula, _, _, _), member(Caracteristica, Caracteristicas), cumple_con_caracteristica(Pelicula, Caracteristica)), Peliculas).

%filtrar todas las peliculas por actor dado el actor
filtrar_actor(ACTOR, PELICULA) :- conocimiento(PELICULA, _, _, ELENCO), member(ACTOR, ELENCO).

%filtrar todas las peliculas por actor dado una lista de actores
cumple_con_actor(Pelicula, Actor) :- conocimiento(Pelicula, _, _, Elenco), member(Actor, Elenco).
filtrar_por_actores(Actores, Peliculas) :- setof(Pelicula, Actor^(conocimiento(Pelicula, _, _, _), member(Actor, Actores), cumple_con_actor(Pelicula, Actor)), Peliculas).