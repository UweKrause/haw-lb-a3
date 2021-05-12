from pyswip import Prolog

prolog = Prolog()

prolog.consult("src/familie.pl")
prolog.consult("src/teil1.pl")
prolog.consult("src/test.pl")

# Tests, executed by prolog
for result in prolog.query("test(allfamilie)"):
    print(result)

# Example from prolog code
"""
test(nachkomme) :-
    %positiv
    write('nachkomme +'),
    nachkomme(helga,eve), write('.'),!,
    nachkomme(susanne,klara),
    %negativ
    write('. -'),!,
    \+ nachkomme(helga,marion), write('.'),!,
    \+ nachkomme(kruemmel,klara),!, writeln('ok').
"""

# Tests, example translated to python
# (not 1:1 the same, but tests same behaviour)

# positive
descendants = []
for results in prolog.query("nachkomme(helga,Y)"):
    descendants.append(results['Y'])
assert 'eve' in descendants

# positive
descendants = []
for results in prolog.query("nachkomme(susanne,Y)"):
    descendants.append(results['Y'])
assert 'klara' in descendants

# positive / relationship twisted
ancestors = []
for results in prolog.query("nachkomme(X,klara)"):
    ancestors.append(results['X'])
assert 'susanne' in ancestors

# negative
descendants = []
for results in prolog.query("nachkomme(helga,Y)"):
    descendants.append(results['Y'])
assert 'marion' not in descendants

# negative
descendants = []
for results in prolog.query("nachkomme(kruemel,Y)"):
    descendants.append(results['Y'])
assert 'klara' not in descendants
