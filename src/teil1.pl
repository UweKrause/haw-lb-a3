/*
 * Aufgabe 3 - Teil 1
 * Gruppe 2 Team 03
 * Uwe Krause
 */

/** Aufgabe 1
 * Definieren Sie zwei Praedikat vorfahre(X,Y) (descendant) und nachkomme(X,Y) (ancestor), die alle Vorfahren bzw. Nachkommen von Y (nacheinander) berechnen koennen.
 */

% Auf ein Cut wird verzichtet, um die Moeglichkeit offen zu halten,
% sich alle Vorfahren einer bestimmten Person durch Anfrage mit einer Variable anzeigen zu lassen

% Einfachster Fall: Vorfahre ist Elternteil von Person
vorfahre(Vorfahre, Person) :-
  elternteil(Vorfahre, Person).

% Speziellerer Fall: Vorfahre ist Vorfahre eines Elternteils der Person  
vorfahre(Vorfahre, Person) :-
  elternteil(Elternteil, Person),
  vorfahre(Vorfahre, Elternteil).
 
  
  


% Eine Nachfrage nach den Nachkommen ist eine umgekehrte Nachfrage nach den Vorfahren
nachkomme(Nachkomme, Person) :-
  vorfahre(Person, Nachkomme).





/** Aufgabe 2
 * Definieren Sie ein Praedikat geschwister(X,Y) (siblings). Sie koennen die Bedingung X ungleich Y (in Prolog X \== Y) verwenden.
 */

% symmetrisches Praedikat, Reihenfolge der Argumente irrelevant
geschwister(X, Y) :-
  elternteil(Elternteil, X),
  elternteil(Elternteil, Y),
  X \== Y.





/** Aufgabe 3
 * Definieren Sie unter Verwendung des Praedikates geschwister(X,Y) die beiden Praedikate bruder(X,Y) und schwester(X,Y).
 */

% ist X ein Bruder von Y?
bruder(Bruder, Person) :-
  maennlich(Bruder),
  geschwister(Bruder, Person).

% ist Y eine Schwester von Y?
schwester(Schwester, Person) :-
  weiblich(Schwester),
  geschwister(Schwester, Person).





/** Aufgabe 4
 * Definieren Sie unter Verwendung des Praedikates verheiratet(X,Y) das symmetrische Praedikat eheleute(X,Y).
 */

eheleute(X, Y) :- verheiratet(X, Y); verheiratet(Y, X).





/** Aufgabe 5
 * Definieren Sie unter Verwendung von Verwandtschaftsstufen (oma,opa) die Praedikat uropa(X,Y) und uroma(X,Y).
 */

% ist X ist eine Uroma von Y?
uroma(Uroma, Person) :-
  weiblich(Uroma),
  elternteil(Uroma, OmaOderOpa),
  ( oma(OmaOderOpa, Person); opa(OmaOderOpa, Person) ).

uropa(Uropa, Person) :-
  maennlich(Uropa),
  elternteil(Uropa, OmaOderOpa),
  ( oma(OmaOderOpa, Person); opa(OmaOderOpa, Person) ).



% ist Oma ist eine Oma von Person?
oma(Oma, Person) :-
  weiblich(Oma),
  elternteil(Oma, MutterOderVater),
  elternteil(MutterOderVater, Person).

% ist X ist ein Opa von Y?
opa(Opa, Person) :-
  maennlich(Opa),
  elternteil(Opa, MutterOderVater),
  elternteil(MutterOderVater, Person).



/*
 * Weitere sich anbietende Verwandtschaftsbeziehungen
 */

% ist X die Mutter von Y?
mutter(Mutter, Person) :-
  weiblich(Mutter),
  elternteil(Mutter, Person).

% ist X der Vater von Y?
vater(Vater, Person) :-
  maennlich(Vater),
  elternteil(Vater, Person).



/*
 * Eine für den Entwickler leichteren Variante, basierend auf den anderen Praedikaten
 * im Vergleich zu einer direkten Implementierung.
 * 
 * mit time/1 lassen sich die Anzahl der Inferenzen zaehlen
 * (als _grobes_ Merkmal zur Abschaetzung der Geschwindigkeit)
 */

versuchUromaFaul :-
  Uroma = eve, Person = alois,
  time( (
    mutter(Uroma, OmaOderOpa),
    ( oma(OmaOderOpa, Person) ; opa(OmaOderOpa, Person) )
  ) ).

versuchUromaGut :-
  Uroma = eve, Person = alois,
  time( (
    weiblich(Uroma),
    elternteil(Uroma, OmaOderOpa),
    elternteil(OmaOderOpa, MutterOderVater),
    elternteil(MutterOderVater, Person)
  ) ).





/**
 * Durch den Verzicht auf rote Cuts bleibt es möglich,
 * sich alle moeglichen Belegungen fuer Anfragen anzeigen zu lassen.
 */

/*
 * Einmal eine ausfuehrliche und komplett eigene Implementierung,
 * anschliessend wird hier nur noch das vorhandene setof/3 verwendet.
 */

vorfahrenliste(Person, Out) :-
    findall(
        X,
        vorfahre(X, Person),
        Vorfahrenliste),
    mehrfacheintreage_entfernen(Vorfahrenliste, Out).

nachkommenliste(Person, Out) 	:- setof(X, nachkomme(X, Person), Out).

geschwisterliste(Person, Out) 	:- setof(X, geschwister(Person, X), Out).

bruderliste(Person, Out) 	:- setof(X, bruder(X, Person), Out).

schwesterliste(Person, Out) 	:- setof(X, schwester(X, Person), Out).

uromaliste(Person, Out) 	:- setof(X, uroma(X, Person), Out).

uropaliste(Person, Out) 	:- setof(X, uropa(X, Person), Out).

 

/**
 * Eigene Implementierungen von Prolog-Hilfspraedikaten
 */

/*
 * mehrfacheintreage_entfernen(IN: List, OUT: Set) 
 */

mehrfacheintreage_entfernen([], []).			% Abbruchbedingung, leere Liste,  Buttom Up / uebergibt leere Liste nach Oben

mehrfacheintreage_entfernen([Head|Tail], Set) :-	% Entfernt Den Kopf der Liste
    mehrfacheintreage_entfernen(Tail, TmpSet),		% Ruft sich selbst rekursiv auf, solange bis Liste leer ist
    append_ifnotmember(Head, TmpSet, Set).  		% Auf dem "Rueckweg" vom Bottom Up fuege der Liste Element hinzu, WENN noch nicht drin
    
    
    
/*
 * append_ifnotmember( IN: Element, IN: Liste, OUT: Liste mit _einem_ Vorkommen von Element )
 */
    
% wenn Element schon Teil der Liste ist, dann ist die Ausgabeliste gleich Eingabeliste
append_ifnotmember(Element, Liste, Out) :- element_der_liste(Element, Liste), Out = Liste, !. 

% wenn Element noch nicht Teil der Ausgabeliste, fuege Element der Liste hinzu
append_ifnotmember(Element, Liste, Out) :- Out = [Element|Liste].



/*
 * element_der_liste
 * Prueft ob Element Teil der Liste ist
 * element_der_liste(IN: Element, IN: Liste)
 */
    
% Prueft ob Element gleich dem Kopf der Liste ist,
% wenn nicht, entferne den Kopf und pruefe wieder mit dem Rest der Liste, solange bis Element gefunden (oder nicht)
element_der_liste(Element, [Head|Tail]) :- Element = Head ; element_der_liste(Element, Tail).






/** Aufgabe 6
 * Definieren Sie Praedikate zur Konsistenzpruefung der Datenbank (maenUweibl/1, verhKor/1, elterVoll/1, wurzel/1) und geben Sie ggf. die Fehleintraege als Liste zurueck.
 * In diesen Listen sollen keine Mehrfacheintraege vorkommen. Sie koennen das Praedikat findall/3 verwenden.:
 */

/** Aufgabe 6.1
 * maenUweibl/1: Gibt es eine Person, die zugleich maennlich und weiblich ist?
 */

maenUweibl(FehlerSet) :-
  % findet alle maennlichen X, fuer die gleichzeitig "weiblich" gilt
  findall(
    X,
    ( maennlich(X), weiblich(X) ),
    Fehlerliste
  ),
  mehrfacheintreage_entfernen(Fehlerliste, FehlerSet). % hier nicht notwendig, aber ggf. bei sich aendernder Datenbasis





/** Aufgabe 6.2
 * verhKor/1: Ist das Praedikat verheiratet korrekt abgespeichert? (links Mann, rechts Frau).
 */

verhKor(FehlerSet) :-
  findall(
    (Mann, Frau),
    (
      verheiratet(Mann, Frau),
      ( weiblich(Mann); maennlich(Frau) )
    ),
    Fehlerliste
  ),
  mehrfacheintreage_entfernen(Fehlerliste, FehlerSet).





/** Aufgabe 6.3
 * elterVoll/1: Sind alle Personen im Praedikat elternteil auch als maennlich oder weiblich registriert?
 */

elterVoll(FehlerSet) :-
  findall(
    (Elter, Kind),
    (
      elternteil(Elter, Kind),
     (
       ( \+ weiblich(Elter), \+ maennlich(Elter) )
       ; %oder
       ( \+ weiblich(Kind), \+ maennlich(Kind) )
     )
    ),
    Fehlerliste
  ),
  mehrfacheintreage_entfernen(Fehlerliste, FehlerSet).





/** Aufgabe 6.4
* wurzel/1: Gibt es jemand ohne Eltern?
*/

wurzel(FehlerSet) :-
  findall(
    Kind,
    (
      ( weiblich(Kind) ; maennlich(Kind) ),
      \+ elternteil(_X, Kind)
    ),
    Fehlerliste
  ),
  mehrfacheintreage_entfernen(Fehlerliste, FehlerSet).
  