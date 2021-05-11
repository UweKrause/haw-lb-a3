from pyswip import Prolog

prolog = Prolog()

prolog.consult("src/familie.pl")
prolog.consult("src/teil1.pl")
prolog.consult("src/test.pl")

for x in prolog.query("test(allfamilie)"):
    print(x)
