% Autor:
% Datum: 30.07.2015

test(nachkomme) :-
    %positiv
    write('nachkomme +'),
    nachkomme(helga,eve), write('.'),!,
    nachkomme(susanne,klara),
    %negativ
    write('. -'),!,
    \+ nachkomme(helga,marion), write('.'),!,
    \+ nachkomme(kruemmel,klara),!, writeln('ok').

test(vorfahre) :-
    %positiv
    write('vorfahre +'),
    vorfahre(eve,helga), write('.'),!,
    vorfahre(klara,susanne),
    %negativ
    write('. -'),!,
    \+ vorfahre(marion,helga), write('.'),!,
    \+ vorfahre(klara,kruemmel),!, writeln('ok').

test(geschwister) :-
    %positiv
    write('geschwister +'),
    geschwister(herbert,johanna), write('.'),!,
    geschwister(elsa,anton),
    %negativ
    write('. -'),!,
    \+ geschwister(udo,thea), write('.'),!,
    \+ geschwister(elmo,kruemmel),!, writeln('ok').
    
test(bruder) :-
    %positiv
    write('bruder +'),
    bruder(hubert,karl), write('.'),!,
    bruder(hubert,inge),
    %negativ
    write('. -'),!,
    \+ bruder(manfred,otto), write('.'),!,
    \+ bruder(thea,anton),!, writeln('ok').

test(schwester) :-
    %positiv
    write('schwester +'),
    schwester(inge,johanna), write('.'),!,
    schwester(inge,hubert),
    %negativ
    write('. -'),!,
    \+ schwester(hubert,inge), write('.'),!,
    \+ schwester(lisa,klara),!, writeln('ok').

test(eheleute) :-
    %positiv
    write('eheleute +'),
    eheleute(xaver,vera), write('.'),!,
    eheleute(lisa,otto),
    %negativ
    write('. -'),!,
    \+ eheleute(xaver,xaver), write('.'),!,
    \+ eheleute(otto,helen), write('.'),!,
    \+ eheleute(helen,otto),!, writeln('ok').

test(uroma) :-
    %positiv
    write('uroma +'),
    uroma(eve,alois), write('.'),!,
    uroma(krimhild,steffi),
    %negativ
    write('. -'),!,
    \+ uroma(wall-e,alois), write('.'),!,
    \+ uroma(vera,steffi), write('.'),!,
    \+ uroma(hubert,lutz),!, writeln('ok').
    
test(uropa) :-
    %positiv
    write('uropa +'),
    uropa(wall-e,magda), write('.'),!,
    uropa(hubert,lutz),
    %negativ
    write('. -'),!,
    \+ uropa(eve,magda), write('.'),!,
    \+ uropa(xaver,lutz), write('.'),!,
    \+ uropa(krimhild,steffi),!, writeln('ok').

test(maenUweibl) :-
    write('maenUweibl '),
    maenUweibl([zummsel]),!, writeln('ok').

test(verhKor) :-
    write('verhKor '),
    verhKor([ Tupel ]),!,
    member(Tupel,[ (helge,elisa),(elisa,helge)]),!, writeln('ok').

test(elterVoll) :-
    write('elterVoll '),
    elterVoll([ Tupel ]),!,
    member(Tupel,[ (elmo,kruemmel),(kruemmel,elmo)]),!, writeln('ok').

test(wurzel) :-
    write('wurzel '),
    list_to_ord_set([elisa, wall-e, eve, helge, zummsel],SetA),
    wurzel(Liste),!,
    list_to_ord_set(Liste,SetB),
    ord_seteq(SetA,SetB),!, writeln('ok').

test(my_unify) :-
    %positiv
    write('my_unify +'),
    my_unify(a(b,_C,d(e,_F,g(h,i,j))),a(_B,c,d(_E,f,_X1))), write('.'),!,
    my_unify(h(r(a),l(X2),g(g(Y2))),h(X2,Y2,_Z2)), write('.'),!,
    my_unify(X,X),
    %negativ
    write('. -'),!,
    \+ my_unify(h(r(a),l(_Z3),g(g(Y3))),h(X3,Y3,X3)), write('.'),!,
    \+ my_unify(h(r(a),l(Z4),g(g(Y4))),h(_X4,Y4,Z4)), write('.'),!,
    \+ my_unify(f(X5,Y5),f(Y5,f(X5))), write('.'),!,
    \+ my_unify(f(_X6,_Y6),f(a,b,c)), write('.'),!,
    \+ my_unify(n(a,b),f(_X7,_Y7)),!, writeln('ok').

test(allfamilie) :-
    test(nachkomme),
    test(vorfahre),
    test(geschwister),
    test(bruder),
    test(schwester),
    test(eheleute),
    test(uroma),
    test(uropa),
    test(maenUweibl),
    test(verhKor),
    test(elterVoll),
    test(wurzel)
    .

test(allunify) :-
    test(my_unify)
    .

