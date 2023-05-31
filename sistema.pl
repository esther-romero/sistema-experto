
 :- use_module(library(pce)).
 :- pce_image_directory('./imagenes').
 :- use_module(library(pce_style_item)).
 :- dynamic color/2.
 :- dynamic generos_usuario/1.

 resource(inicio, image, image('inicio.jpg')).
 resource(fondo, image, image('fondo.jpg')).
 resource(generos, image, image('generos.jpg')).
resource(actores, image, image('actores.jpg')).
resource(caracteristicas, image, image('caracteristicas.jpg')).

 mostrar_imagen(Pantalla, Imagen) :- new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(100,80)).
 mostrar_imagen_tratamiento(Pantalla, Imagen) :-new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(20,100)).
 nueva_imagen(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(15,10)).
  imagen_pregunta(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(500,60)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  botones:-borrado,
                send(@boton, free),
                send(@btntratamiento,free),
                new(@boton, button('GENERO',
                    message(@prolog, botones)
                    )),
                new(@boton, button('CARACTERISTICAS',
                    message(@prolog, botones)
                    )),
                new(@boton, button('ACTORES',
                    message(@prolog, botones)
                    )),

                new(@btntratamiento,button('Detalles y Tratamiento',
                message(@prolog, mostrar_tratamiento,Enfermedad)
                )),
                send(@main, display,@boton,point(20,450)),
                send(@main, display,@btntratamiento,point(138,450)).

  mostrar_tratamiento(X):-new(@tratam, dialog('Tratamiento')),
                          send(@tratam, append, label(nombre, 'Explicacion: ')),
                          send(@tratam, display,@lblExp1,point(70,51)),
                          send(@tratam, display,@lblExp2,point(50,80)),
                          tratamiento(X),
                          send(@tratam, transient_for, @main),
                          send(@tratam, open_centered).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  interfaz_principal:-new(@main,dialog('Sistema Experto de Cine', size(1000,1000))),
        new(@resp1, label(nombre,'',font('times','roman',22))), %largo del frame
        new(@lblExp1, label(nombre,'',font('times','roman',14))),
        new(@lblExp2, label(nombre,'',font('times','roman',14))),
        new(@botonG, button('GENERO',and(message(@prolog, interfaz_genero), and(message(@main, destroy), message(@main, free))))),
        new(@botonC, button('CARACTERISTICAS',and(message(@prolog, interfaz_caracteristicas), and(message(@main, destroy), message(@main, free))))),
        new(@botonA, button('ACTORES',and(message(@prolog, interfaz_actor), and(message(@main, destroy), message(@main, free))))),
        new(@salir,button('SALIR',and(message(@main,destroy),message(@main,free)))),

        nueva_imagen(@main, fondo),
        send(@main, display,@botonG,point(143,425)),
        send(@main, display,@botonC,point(243,425)),
        send(@main, display,@botonA,point(393,425)),
        send(@main, display,@salir,point(495,425)),
        send(@main, display,@resp1,point(20,180)),
        send(@main,open_centered).

       % borrado:- send(@resp1, selection('')).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
interfaz_genero :- new(@nueva, dialog('Sistema Experto de Cine', size(1000,1000))),
                 new(@btnAccion, button('ACCION', message(@prolog, agregar_genero_a_la_lista, @nueva, accion))),
                  new(@btnDramatico, button('DRAMATICO', message(@prolog, agregar_genero_a_la_lista, @nueva, dramatico))),
                  new(@btnComedia, button('COMEDIA', message(@prolog, agregar_genero_a_la_lista, @nueva, comedia))),
                  new(@btnTerror, button('TERROR', message(@prolog, agregar_genero_a_la_lista, @nueva, terror))),
                  new(@btnRomantico, button('ROMANTICO', message(@prolog, agregar_genero_a_la_lista, @nueva, romantico))),
                  new(@salirGenero,button('SALIR',and(message(@nueva,destroy),message(@nueva,free)))),
                  new(@btn_recomendar, button('RECOMENDAR', message(@prolog, ventana_recomendaciones))),
                  nueva_imagen(@nueva, generos),
                  send(@nueva, display,@btnAccion,point(130,250)),
                  send(@nueva, display,@btnDramatico,point(230,250)),
                  send(@nueva, display,@btnComedia,point(330,250)),
                  send(@nueva, display,@btnTerror,point(430,250)),
                  send(@nueva, display,@btnRomantico,point(530,250)),
                  send(@nueva, display,@salirGenero,point(600,540)),
                  send(@nueva, display,@btn_recomendar,point(480,540)),
                 send(@nueva, open_centered).

ventana_recomendaciones :- 
  new(@ventana_recomendaciones, dialog('Sistema Experto de Cine', size(600,500))),
  list_generos_usuario(GenerosIngresados),
  listar_por_generos(GenerosIngresados, Peliculas),
  send(@ventana_recomendaciones, open_centered).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

interfaz_actor :- new(@nuevaActores, dialog('Sistema Experto de Cine', size(1000,1000))),
                  new(@salirActores, button('SALIR',and(message(@nuevaActores,destroy),message(@nuevaActores,free)))),
                  nueva_imagen(@nuevaActores, actores),
                  send(@nuevaActores, display,@salirActores,point(600,540)),
                  send(@nuevaActores, open_centered).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

interfaz_caracteristicas :- new(@nuevaCarac, dialog('Sistema Experto de Cine', size(1000,1000))),
                            new(@salirCarac, button('SALIR',and(message(@nuevaCarac,destroy),message(@nuevaCarac,free)))),
                            nueva_imagen(@nuevaCarac, caracteristicas),
                            send(@nuevaCarac, display,@salirCarac,point(600,540)),
                            send(@nuevaCarac, open_centered).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-dynamic posicion_generos_agregados/2.
posicion_generos_agregados(340, 350).

agregar_genero_a_la_lista(Ventana, Genero) :-
  list_generos_usuario(GenerosActuales),
  not(member(Genero, GenerosActuales)),
  posicion_generos_agregados(X, Y),
  new(@GeneroXY, label(nombre, Genero)),
  send(Ventana, display, @GeneroXY, point(X, Y)),
  Y1 is Y + 30,
  retract(posicion_generos_agregados(X, Y)),
  assert(posicion_generos_agregados(X, Y1)),
  assert(generos_usuario(Genero)).

list_generos_usuario(Lista) :- findall(X, generos_usuario(X), Lista). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  crea_interfaz_inicio:- new(@interfaz,dialog('Sistema Experto de Cine', size(1000,1000))),

  mostrar_imagen(@interfaz, inicio),

  new(BotonComenzar,button('COMENZAR',and(message(@prolog,interfaz_principal) ,
  and(message(@interfaz,destroy),message(@interfaz,free)) ))),
  new(BotonSalir,button('SALIDA',and(message(@interfaz,destroy),message(@interfaz,free)))),
  send(@interfaz,append(BotonComenzar)),
  send(@interfaz,append(BotonSalir)),
  send(@interfaz,open_centered).

  :-crea_interfaz_inicio.


/*
BASE DE CONOCIMIENTOS
sistema experto de cine
CineExperto
*/

% conocimiento(nombre, [generos], [caracteristicas], [elenco])

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
conocimiento(hambre, [dramatico, de_tailandia], [inspirador, suspenso], [chutimon, nopachai, gunn_svasti]).
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

%ROMANTICO
conocimiento(dos_corazones, [romantico, hechos_reales], [emotivo,romantico], [jacob_elordi, adan_canto, radha_mitchell]).

%filtrar todas las peliculas por genero dado el genero
filtrar_genero(GENERO, PELICULA) :- conocimiento(PELICULA, GENEROS, _, _), member(GENERO, GENEROS).

% motor de inferencia
generos_usuario().

listar_por_generos([], []).
listar_por_generos([H|T], Peliculas) :- 
    listar_por_generos(T, Peliculas2) ,
    peliculas_por_genero(L, H),
    append(L, Peliculas2, Res),
    borrar_repetidos(Res, Peliculas).

%filtrar todas las peliculas por genero dado el genero
filtrar_genero(GENERO, PELICULA) :- conocimiento(PELICULA, GENEROS, _, _), member(GENERO, GENEROS).

%todas las peliculas que cumplen con el genero dado
peliculas_por_genero(Peliculas, GENERO) :- findall(X, filtrar_genero(GENERO, X), Peliculas).

% eliminar elementos repetidos de una lista
borrar_repetidos([], []).
borrar_repetidos([X|Resto], SinRepetidos) :- member(X, Resto), borrar_repetidos(Resto, SinRepetidos).
borrar_repetidos([X|Resto], SinRepetidos) :- not(member(X, Resto)), borrar_repetidos(Resto, Res), SinRepetidos = [X | Res].