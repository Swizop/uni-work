//functie pur virtuala -> mananca animalul
#include <iostream>
#include <string>
#include <list>
#include <vector>

using namespace std;


template <typename T = string>
class Animal
{
    T _denumire, _increngatura, _clasa, _ordin, _habitat;

    public:
        Animal(T nume = "", T inc = "", T cls = "", T ord = "", T hab = ""): 
            _denumire(nume), _increngatura(inc), _clasa(cls), _ordin(ord), _habitat(hab) { }
        ~Animal() = default;
        Animal(const Animal& cop)
        {
            this->_denumire = cop._denumire;
            this->_increngatura = cop._increngatura;
            this->_clasa = cop._clasa;
            this->_ordin = cop._ordin;
            this->_habitat = cop._habitat;
        }

        Animal& operator=(const Animal& cop)
        {
            this->_denumire = cop._denumire;
            this->_increngatura = cop._increngatura;
            this->_clasa = cop._clasa;
            this->_ordin = cop._ordin;
            this->_habitat = cop._habitat;
            return *this;
        }

        virtual void afis() = 0;
        virtual void read() = 0;

        friend istream& operator>>(istream& in, Animal& ob)
        {
            cout << "\nDenumire: ";
            getline(in, ob._denumire);
            cout << "\nIncrengatura animal: ";
            getline(in, ob._increngatura);
            cout << "\nClasa animal: ";
            getline(in, ob._clasa);
            cout << "\nOrdin animal: ";
            getline(in, ob._ordin);
            cout << "\nHabitat animal: ";
            getline(in, ob._habitat);
            return in;
        }
        friend ostream& operator<<(ostream& out, const Animal& ob)
        {
            out << "\nDenumire: " << ob._denumire;
            out << "\nIncrengatura animal: " <<  ob._increngatura;
            out << "\nClasa animal: " << ob._clasa;
            out << "\nOrdin animal: " <<  ob._ordin;
            out << "\nHabitat animal: " <<  ob._habitat;
            return out;
        }
};


template <typename T = string>
class Nevertebrat: public Animal<T>
{
    T _tipCorp;          //exoschelet / corp moale

    public:
        Nevertebrat(T nume = "", T inc = "", T cls = "", T ord = "", T hab = "", T tc = ""): 
            Animal<T>(nume, inc, cls, ord, hab), _tipCorp(tc) { }
        ~Nevertebrat() = default;
        Nevertebrat(const Nevertebrat& cop): Animal<T>(cop)
        {
            this->_tipCorp = cop._tipCorp;
        }

        Nevertebrat& operator=(const Nevertebrat& cop)
        {
            Animal<T>::operator=(cop);
            this->_tipCorp = cop._tipCorp;
            return *this;
        }

        void afis()
        {
            cout << *this;          
            cout << "Animalul este un nevertebrat.\n";
        }
        void read()
        {
            cout << "\nIntroduceti informatiile despre nevertebrat.";
            cin >> *this;
        }

        friend istream& operator>>(istream& in, Nevertebrat& ob)
        {
            in >> static_cast<Animal<T>&> (ob);                       //UPCASTING
            cout << "\nTipul corpului (exoschelet / corp moale): ";
            getline(in, ob._tipCorp);
            cout << '\n'; 
            return in;
        }
        friend ostream& operator<<(ostream& out, const Nevertebrat& ob)
        {
            out << static_cast<const Animal<T>&>(ob);                     //UPCASTING
            out << "\nTip corp: " << ob._tipCorp << "\n";
            return out;
        }
};


template <typename T = string>
class Vertebrat: public Animal<T>
{
    T _modHranire;             //erbivor / omnivor / carnivor

    public:
        Vertebrat(T nume = "", T inc = "", T cls = "", T ord = "", T hab = "", T mH = ""): 
            Animal<T>(nume, inc, cls, ord, hab), _modHranire(mH) { }
        ~Vertebrat() = default;

        Vertebrat(const Vertebrat& cop): Animal<T>(cop)
        {
            this->_modHranire = cop._modHranire;
        }

        Vertebrat& operator=(const Vertebrat& cop)
        {
            Animal<T>::operator=(cop);
            this->_modHranire = cop._modHranire;
            return *this;
        }

        virtual void afis()
        {
            cout << *this;          
            cout << "Animalul este un vertebrat.\n";
        }
        virtual void read()
        {
            cout << "\nIntroduceti informatiile despre vertebrat.";
            cin >> *this;
        }

        friend istream& operator>>(istream& in, Vertebrat& ob)
        {
            in >> static_cast<Animal<T>&> (ob);                       //UPCASTING
            cout << "\nMod hranire (ierbivor/ carnivor/ omnivor): ";
            getline(in, ob._modHranire);
            cout << '\n'; 
            return in;
        }
        friend ostream& operator<<(ostream& out, const Vertebrat& ob)
        {
            out << static_cast<const Animal<T>&>(ob);                     //UPCASTING
            out << "\nMod hranire: " << ob._modHranire << "\n";
            return out;
        }
};


template <typename T = string>
class Peste: public Vertebrat<T>
{
    T _tip;             //tip: rapitor, luptator etc.
    float _lungime;     //lungime in metri

    static int _nr;          //nr de pesti rapitori mai mari de 1m cititi

    public:


        Peste(T nume = "", T inc = "", T cls = "", T ord = "", T hab = "", T mH = "", T tip = "", float lg = 0): 
            Vertebrat<T>(nume, inc, cls, ord, hab, mH), _tip(tip), _lungime(lg) { }
        ~Peste() = default;

        Peste(const Peste& cop): Vertebrat<T>(cop)
        {
            this->_tip = cop._tip;
            this->_lungime = cop._lungime;
        }

        Peste& operator=(const Peste& cop)
        {
            Vertebrat<T>::operator=(cop);
            this->_tip = cop._tip;
            this->_lungime = cop._lungime;
            return *this;
        }

        void afis()
        {
            cout << *this;          //as putea ca aici in loc de cout sa fac o afisare ca intr-un atlas, iar cout ul simplu sa fie afisare a datelor sumar
            cout << "Animalul este un peste.\n";
        }
        void read()
        {
            cout << "\nIntroduceti datele despre peste.";
            cin >> *this;
        }

        friend istream& operator>>(istream& in, Peste& ob)
        {
            in >> static_cast<Vertebrat<T>&> (ob);                       //UPCASTING
            cout << "Tip peste (luptator, rapitor etc): ";
            getline(in, ob._tip);
            cout << "\nLungime peste (in metri): ";
            in >> ob._lungime;
            cout << '\n';
            if(ob._lungime >= 1)
                inc_nr();  
            return in;
        }
        friend ostream& operator<<(ostream& out, const Peste& ob)
        {
            out << static_cast<const Vertebrat<T>&>(ob);                     //UPCASTING
            out << "Tip: " << ob._tip;
            out << "\nLungime: " << ob._lungime << '\n';
            return out;
        }

        
        static void inc_nr()            //gestionarea nrului de pesti rapitori >= 1m
        {
            _nr++;
        }
        static void show_nr()
        {
            cout << _nr;
        }
};

template<typename T>
int Peste<T>::_nr = 0;

int main()
{
    // Nevertebrat<string> x, y;
    // x.read();
    // x.afis();
    // y.read();
    // y.afis();

    // Vertebrat<string> a;
    // cin >> a;
    // cout << a;

    Peste<string> p1, p2;
    cin >> p1;

    cout << p1;
    Peste<>::show_nr();

    p2 = p1;
    p2.afis();
    return 0;
}
