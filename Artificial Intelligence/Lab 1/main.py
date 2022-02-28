from collections import defaultdict
class Elev:
    howMany = 0
    def __init__(self, nume = '', san = 90, intel = 20, obo = 0, bd = 100):
        if nume == '':
            Elev.howMany += 1
            self.nume = "Necunoscut_" + str(self.howMany)
        self.sanatate = san
        self.inteligenta = intel
        self.oboseala = obo
        self.buna_dispozitie = bd
        
        self.activitate_curenta = None
        self.timp_executat_activ = 0
        self.activitati_dict = defaultdict(int)

    def __repr__(self) -> str:
        retVal = "Elev:\n"
        for (k, v) in self.__dict__.items():
            if not isinstance(v, defaultdict):
                retVal += "{} = {}\n".format(k, v)
        retVal += "Raport activitati:\n" + self.returneaza_raport(self.activitati_dict) + '\n'
        return retVal

    def desfasoara_activitate(self, activitate):
        self.activitate_curenta = activitate
        self.timp_executat_activ = 0


    def trece_ora(self, ora):
        if self.activitate_curenta.durata <= 0:
            return False
        self.activitate_curenta.durata -= ora
        self.timp_executat_activ += ora
        self.activitati_dict[self.activitate_curenta] += 1
        return True

    def testeaza_final(self):
        if self.activitate_curenta.durata == 0:
            return True
        return False

    @staticmethod
    def returneaza_raport(d):
        retVal = ''
        if len(d) == 0:
            retVal = "Elevul nu a desfasurat activitati!"
        else:
            for (k, v) in d.items():
                retVal += f"{k}: {v} ore; "
        return retVal


    def afiseaza_raport(self):
        print(self.returneaza_raport(self.activitati_dict))
        

class Activitate:
    all = []
    def __init__(self, nume, fs, fi, fo, fd, dur):
        self.nume = nume
        self.factor_sanatate = fs
        self.factor_inteligenta = fi
        self.factor_oboseala = fo
        self.factor_dispozitie = fd
        self.durata = dur

    def __str__(self):
        return self.nume

    def __repr__(self):
        retVal = "Actvitate: "
        for (k, v) in self.__dict__.items():
            retVal += "{} = {}\n".format(k, v)
        return retVal

    @classmethod
    def read_from_file(cls):
        f = open("in.txt", 'r')
        for line in f.readlines()[1:]:

            # a = Activitate(*tuple(map(int, line.split()[1:])))
            prop = line.split()
            for i in range(1, len(prop)):
                prop[i] = int(prop[i])
            a = Activitate(*tuple(prop))
            # except:
            #     print('aaa')
            cls.all.append(a)


Activitate.read_from_file()
print(Activitate.all)
e = Elev()
f = Elev()

f.desfasoara_activitate(Activitate.all[0])
f.trece_ora(1)

f.desfasoara_activitate(Activitate.all[1])
f.trece_ora(2)
print(f)