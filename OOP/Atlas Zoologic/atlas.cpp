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
            out << "\nHabitat animal: " <<  ob._habitat << '\n';
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
            cout << *this;          //as putea ca aici in loc de cout sa fac o afisare ca intr-un atlas, iar cout ul simplu sa fie afisare a datelor sumar
        }
        void read()
        {
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
            out << "Animalul este un nevertebrat cu " << ob._tipCorp << ".\n";
            return out;
        }
};


// template <typename T = string>
// class Vertebrate: public Animal<>
// {
//     T _modHranire;             //erbivor / omnivor

// };

int main()
{
    Nevertebrat<string> x, y;
    x.read();
    x.afis();
    y.read();
    y.afis();
    return 0;
}