%Parcial Lógico
persona(ale, 15, [claustrofobia, cuentasRapidas, amorPorLosPerros]).
persona(agus, 25, [lecturaVeloz, ojoObservador, minuciosidad]).
persona(fran, 30, [fanDeLosComics]).
persona(rolo, 12, []).

esSalaDe(elPayasoExorcista, salSiPuedes).
esSalaDe(socorro, salSiPuedes).
esSalaDe(linternas, elLaberintoso).
esSalaDe(guerrasEstelares, escapepe).
esSalaDe(fundacionDelMulo, escapepe).

sala(elPayasoExorcista, terrorifica(100, 18)).
sala(socorro, terrorifica(20, 12)).
sala(linternas, familiar(comics, 5)).
sala(guerrasEstelares, familiar(futurista, 7)).
sala(fundacionDelMulo, enigmatica([combinacionAlfanumerica, deLlave, deBoton])).

%Punto 1
nivelDeDificultadDeLaSala(Sala, Dificultad) :-
    sala(Sala, Experiencia),
    nivelDeDificultadSegun(Experiencia, Dificultad).

nivelDeDificultadSegun(terrorifica(CantidadDeSustos, EdadMinima), Dificultad) :-
    Dificultad is CantidadDeSustos - EdadMinima.

nivelDeDificultadSegun(familiar(futurista, _), 15).

nivelDeDificultadSegun(familiar(Tematica, Dificultad), Dificultad) :- Tematica \= futurista.

nivelDeDificultadSegun(enigmatica(Candados), Dificultad) :- length(Candados, Dificultad).

%Punto 2
puedeSalir(Persona, Sala) :-
    persona(Persona, _, _),
    not(esClaustrofobica(Persona)),
    puedeSalirSegun(Persona, Sala).

puedeSalirSegun(_, Sala) :-
    nivelDeDificultadDeLaSala(Sala, 1).

puedeSalirSegun(Persona, Sala) :-
    persona(Persona, Edad, _),
    Edad > 13,
    nivelDeDificultadDeLaSala(Sala, Dificultad),
    Dificultad < 5.

esClaustrofobica(Persona) :-
    persona(Persona, _, Peculiaridades),
    member(claustrofobia, Peculiaridades).

%Punto 3
tieneSuerte(Persona, Sala) :-
    persona(Persona, _, []),
    puedeSalir(Persona, Sala).

%Punto 4
esMacabra(Empresa) :-
    esSalaDe(Sala, Empresa),
    forall( esSalaDe(Sala, Empresa), sala(Sala, terrorifica(_, _))).

%Punto 5
empresaCopada(Empresa) :-
    esSalaDe(_, Empresa),
    not(esMacabra(Empresa)),
    promedioDeDificultad(Empresa, Promedio),
    Promedio < 4.

promedioDeDificultad(Empresa, Promedio) :-
    findall(Dificultad, dificultadDeSalaDe(Empresa, Dificultad), Dificultades),
    sumlist(Dificultades, SumaDeDificultades),
    length(Dificultades, CantidadDeSalas),
    Promedio is SumaDeDificultades / CantidadDeSalas.

dificultadDeSalaDe(Empresa, Dificultad) :-
    esSalaDe(Sala, Empresa),
    nivelDeDificultadDeLaSala(Sala, Dificultad).

%Punto 6
esSalaDe(estrellasDePelea, supercelula).
sala(estrellasDePelea, familiar(videojuegos, 7)).

esSalaDe(miseriaDeLaNoche, skPista).
sala(miseriaDeLaNoche, terrorifica(150, 21)).

% Justificación: Por PUC (Principio de Universo Cerrado), el motor asume como falso
%todo lo que no pueda probar como verdadero, (lo desconocido y falso) no entra en la base de conocimientos. 

