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
            //getline(in, ob._denumire);
            cout << "\nDenumire: ";
            //getline(in, ob._denumire);
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
            cout << *this;
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
            string aux;
            getline(in, aux);
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


template <typename T = string>
class Pasare: public Vertebrat<T>
{
    T _culoarePenaj;

    public:


        Pasare(T nume = "", T inc = "", T cls = "", T ord = "", T hab = "", T mH = "", T cP = ""): 
            Vertebrat<T>(nume, inc, cls, ord, hab, mH), _culoarePenaj(cP) { }
        ~Pasare() = default;

        Pasare(const Pasare& cop): Vertebrat<T>(cop)
        {
            this->_culoarePenaj = cop._culoarePenaj;
        }

        Pasare& operator=(const Pasare& cop)
        {
            Vertebrat<T>::operator=(cop);
            this->_culoarePenaj = cop._culoarePenaj;
            return *this;
        }

        void afis()
        {
            cout << *this;
            cout << "Animalul este o pasare.\n";
        }
        void read()
        {
            cout << "\nIntroduceti datele despre pasare.";
            cin >> *this;
        }

        friend istream& operator>>(istream& in, Pasare& ob)
        {
            in >> static_cast<Vertebrat<T>&> (ob);                       //UPCASTING
            cout << "Culoare penaj: ";
            getline(in, ob._culoarePenaj);
            cout << '\n';
            return in;
        }
        friend ostream& operator<<(ostream& out, const Pasare& ob)
        {
            out << static_cast<const Vertebrat<T>&>(ob);                     //UPCASTING
            out << "Culoare penaj: " << ob._culoarePenaj << '\n';
            return out;
        }
};


template <typename T = string>
class Mamifer: public Vertebrat<T>
{
    T _procentGrasimeLapte;

    public:


        Mamifer(T nume = "", T inc = "", T cls = "", T ord = "", T hab = "", T mH = "", T pr = ""): 
            Vertebrat<T>(nume, inc, cls, ord, hab, mH), _procentGrasimeLapte(pr) { }
        ~Mamifer() = default;

        Mamifer(const Mamifer& cop): Vertebrat<T>(cop)
        {
            this->_procentGrasimeLapte = cop._procentGrasimeLapte;
        }

        Mamifer& operator=(const Mamifer& cop)
        {
            Vertebrat<T>::operator=(cop);
            this->_procentGrasimeLapte = cop._procentGrasimeLapte;
            return *this;
        }

        void afis()
        {
            cout << *this;
            cout << "Animalul este un mamifer.\n";
        }
        void read()
        {
            cout << "\nIntroduceti datele despre mamifer.";
            cin >> *this;
        }

        friend istream& operator>>(istream& in, Mamifer& ob)
        {
            in >> static_cast<Vertebrat<T>&> (ob);                       //UPCASTING
            cout << "Procentul grasimii laptelui mamiferului: ";
            getline(in, ob._procentGrasimeLapte);
            cout << '\n';
            return in;
        }
        friend ostream& operator<<(ostream& out, const Mamifer& ob)
        {
            out << static_cast<const Vertebrat<T>&>(ob);                     //UPCASTING
            out << "Procent grasime lapte: " << ob._procentGrasimeLapte << '\n';
            return out;
        }
};


template <typename T = string>
class Reptila: public Vertebrat<T>
{
    T _tipPiele;        // solzoasa / acoperita cu placi

    public:


        Reptila(T nume = "", T inc = "", T cls = "", T ord = "", T hab = "", T mH = "", T tP = ""): 
            Vertebrat<T>(nume, inc, cls, ord, hab, mH), _tipPiele(tP) { }
        ~Reptila() = default;

        Reptila(const Reptila& cop): Vertebrat<T>(cop)
        {
            this->_tipPiele = cop._tipPiele;
        }

        Reptila& operator=(const Reptila& cop)
        {
            Vertebrat<T>::operator=(cop);
            this->_tipPiele = cop._tipPiele;
            return *this;
        }

        void afis()
        {
            cout << *this;
            cout << "Animalul este o reptila.\n";
        }
        void read()
        {
            cout << "\nIntroduceti datele despre reptila.";
            cin >> *this;
        }

        friend istream& operator>>(istream& in, Reptila& ob)
        {
            in >> static_cast<Vertebrat<T>&> (ob);                       //UPCASTING
            cout << "Tip piele (solzoasa, acoperita cu placi): ";
            getline(in, ob._tipPiele);
            cout << '\n';
            return in;
        }
        friend ostream& operator<<(ostream& out, const Reptila& ob)
        {
            out << static_cast<const Vertebrat<T>&>(ob);                     //UPCASTING
            out << "Tip piele: " << ob._tipPiele << '\n';
            return out;
        }
};


template <typename T = string>
class AtlasZoologic
{
    T _titlu;
    int _nrPagini;
    list<Animal<T>*> _file;
    const T _editura;

    public:
        T get_editura() const                                           //FUNCTIE CONST
        {
            return _editura;
        }
        int get_nrPagini() const
        {
            return _nrPagini;
        }


        AtlasZoologic(T titlu = "", int nr = 0, list<Animal<T>*> l = list<Animal<T>*>()): 
            _titlu(titlu), _nrPagini(nr), _editura("MattSRL") {
                for(auto i = l.begin(); i != l.end(); ++i)
                {
                    Nevertebrat<T> *p1 = dynamic_cast<Nevertebrat<T>*>(*i);                                     //DOWNCASTING
                    if(p1 != NULL)
                    {
                        _file.push_back(static_cast<Animal<T>*>(p1));
                        continue;
                    }

                    Reptila<T> *p2 = dynamic_cast<Reptila<T>*>(*i);                                            //DOWNCASTING
                    if(p2 != NULL)
                    {
                        _file.push_back(static_cast<Animal<T>*>(p2));
                        continue;
                    }

                    Pasare<T> *p3 = dynamic_cast<Pasare<T>*>(*i);                                              //DOWNCASTING
                    if(p3 != NULL)
                    {
                        _file.push_back(static_cast<Animal<T>*>(p3));
                        continue;
                    }

                    Peste<T> *p4 = dynamic_cast<Peste<T>*>(*i);                                                 //DOWNCASTING
                    if(p4 != NULL)
                    {
                        _file.push_back(static_cast<Animal<T>*>(p4));
                        continue;
                    }

                    Mamifer<T> *p5 = dynamic_cast<Mamifer<T>*>(*i);                                             //DOWNCASTING
                    if(p5 != NULL)
                    {
                        _file.push_back(static_cast<Animal<T>*>(p5));
                        continue;
                    }
                }
             }
        ~AtlasZoologic()
        {
            for(auto i = _file.begin(); i != _file.end(); ++i)
            {
                delete *i;
            }
            _file.clear();
        }

        AtlasZoologic(const AtlasZoologic& cop)
        {
            this->_titlu = cop._titlu;
            this->_nrPagini = cop._nrPagini;
            for(auto i = cop._file.begin(); i != cop._file.end(); ++i)
                {
                    Nevertebrat<T> *p1 = dynamic_cast<Nevertebrat<T>*>(*i);                                     //DOWNCASTING
                    if(p1 != NULL)
                    {
                        this->_file.push_back(static_cast<Animal<T>*>(p1));
                        continue;
                    }

                    Reptila<T> *p2 = dynamic_cast<Reptila<T>*>(*i);                                            //DOWNCASTING
                    if(p2 != NULL)
                    {
                        this->_file.push_back(static_cast<Animal<T>*>(p2));
                        continue;
                    }

                    Pasare<T> *p3 = dynamic_cast<Pasare<T>*>(*i);                                              //DOWNCASTING
                    if(p3 != NULL)
                    {
                        this->_file.push_back(static_cast<Animal<T>*>(p3));
                        continue;
                    }

                    Peste<T> *p4 = dynamic_cast<Peste<T>*>(*i);                                                 //DOWNCASTING
                    if(p4 != NULL)
                    {
                        this->_file.push_back(static_cast<Animal<T>*>(p4));
                        continue;
                    }

                    Mamifer<T> *p5 = dynamic_cast<Mamifer<T>*>(*i);                                             //DOWNCASTING
                    if(p5 != NULL)
                    {
                        this->_file.push_back(static_cast<Animal<T>*>(p5));
                        continue;
                    }
                }
        }

        AtlasZoologic& operator=(const AtlasZoologic& cop)
        {
            this->_titlu = cop._titlu;
            this->_nrPagini = cop._nrPagini;
            for(auto i = _file.begin(); i != _file.end(); ++i)
            {
                delete i;
            }
            _file.clear();

            
            for(auto i = cop._file.begin(); i != cop._file.end(); ++i)
                {
                    Nevertebrat<T> *p1 = dynamic_cast<Nevertebrat<T>*>(*i);                                     //DOWNCASTING
                    if(p1 != NULL)
                    {
                        this->_file.push_back(static_cast<Animal<T>*>(p1));
                        continue;
                    }

                    Reptila<T> *p2 = dynamic_cast<Reptila<T>*>(*i);                                            //DOWNCASTING
                    if(p2 != NULL)
                    {
                        this->_file.push_back(static_cast<Animal<T>*>(p2));
                        continue;
                    }

                    Pasare<T> *p3 = dynamic_cast<Pasare<T>*>(*i);                                              //DOWNCASTING
                    if(p3 != NULL)
                    {
                        this->_file.push_back(static_cast<Animal<T>*>(p3));
                        continue;
                    }

                    Peste<T> *p4 = dynamic_cast<Peste<T>*>(*i);                                                 //DOWNCASTING
                    if(p4 != NULL)
                    {
                        this->_file.push_back(static_cast<Animal<T>*>(p4));
                        continue;
                    }

                    Mamifer<T> *p5 = dynamic_cast<Mamifer<T>*>(*i);                                             //DOWNCASTING
                    if(p5 != NULL)
                    {
                        this->_file.push_back(static_cast<Animal<T>*>(p5));
                        continue;
                    }
                }
            return *this;
        }

        void afis()
        {
            cout << endl;
            cout << "Atlasul zoologic \"" << _titlu << "\"\nEditura " << _editura << '\n';
            cout << *this;
        }
        void read()
        {
            cout << "\nIntroduceti datele din atlas.\n";
            cin >> *this;
        }

        friend istream& operator>>(istream& in, AtlasZoologic& ob)
        {
            cout << "Numarul de pagini: ";
            in >> ob._nrPagini;
            cout << '\n';
            cout << "\nTitlul atlasului: ";
            getline(in, ob._titlu);
            getline(in, ob._titlu);
            cout << '\n';

            for(int i = 1; i <= ob._nrPagini; i++)
            {
                cout << "Animalul " << i << ". Introduceti tipul de animal dorit.\n1 = Nevertebrat, 2 = Reptila, 3 = Pasare, 4 = Peste, 5 = Mamifer\n";
                string op;
                getline(in, op);
                if(op == "1")
                {
                    Nevertebrat<T> *p1 = new Nevertebrat<T>;
                    in >> *p1;
                    ob._file.push_back(static_cast<Animal<T>*>(p1));
                    continue;
                }
                if(op == "2")
                {
                    Reptila<T> *p2 = new Reptila<T>;
                    in >> *p2;
                    ob._file.push_back(static_cast<Animal<T>*>(p2));
                    continue;
                }
                if(op == "3")
                {
                    Pasare<T> *p3 = new Pasare<T>;
                    in >> *p3;
                    ob._file.push_back(static_cast<Animal<T>*>(p3));
                    continue;
                }
                if(op == "4")
                {
                    Peste<T> *p4 = new Peste<T>;
                    in >> *p4;
                    ob._file.push_back(static_cast<Animal<T>*>(p4));
                    continue;
                }
                if(op == "5")
                {
                    Mamifer<T> *p5 = new Mamifer<T>;
                    in >> *p5;
                    ob._file.push_back(static_cast<Animal<T>*>(p5));
                    continue;
                }
                cout << "\nIndice gresit.";
            }
            return in;
        }
        friend ostream& operator<<(ostream& out, const AtlasZoologic& ob)
        {
            int i = 1;
            for(auto j = ob._file.begin(); j != ob._file.end(); ++j)
            {
                out << "\n\nPAGINA " << i << "\n";
                i++;

                Nevertebrat<T> *p1 = dynamic_cast<Nevertebrat<T>*>(*j);                                     //DOWNCASTING
                if(p1 != NULL)
                {
                    p1->afis();
                    continue;
                }

                Reptila<T> *p2 = dynamic_cast<Reptila<T>*>(*j);                                            //DOWNCASTING
                if(p2 != NULL)
                {
                    p2->afis();
                    continue;
                }

                Pasare<T> *p3 = dynamic_cast<Pasare<T>*>(*j);                                              //DOWNCASTING
                if(p3 != NULL)
                {
                    p3->afis();
                    continue;
                }

                Peste<T> *p4 = dynamic_cast<Peste<T>*>(*j);                                                 //DOWNCASTING
                if(p4 != NULL)
                {
                    p4->afis();
                    continue;
                }

                Mamifer<T> *p5 = dynamic_cast<Mamifer<T>*>(*j);                                             //DOWNCASTING
                if(p5 != NULL)
                {
                    p5->afis();
                    continue;
                }
            }
            return out;
        }


        AtlasZoologic& operator+=(Animal<T>* ob)
        {
            this->_nrPagini++;
            this->_file.push_back(ob);
            return *this;
        }
};

template<typename T>
void universal_method(int n)                                //citirea, stocarea si afisarea a n elemente
{
    vector<AtlasZoologic<T>*> vec;
    AtlasZoologic<T>* A = new AtlasZoologic<T>;
    for(int i = 0 ; i < n; i ++ )
    {
        cout << "Citirea Atlasului Zoologic cu numarul " << i + 1 << ":\n";
        cin >> *A;
        vec.push_back(A);
    }

    for(int i = 0 ;  i < n; i ++)
    {   cout << "Afisarea Atlasului Zoologic cu numarul " << i + 1 << ":\n";
        vec[i]->afis();
        cout << endl;
    }
}


void afisareMeniu()
{
    cout << "================" << endl;
    cout << "1. Cititi A de la tastatura" << endl;
    cout << "2. Afisati editura atlasului" << endl;
    cout << "3. Afisati cati pesti rapitori de lungime mai mare de 1m s-au citit." << endl;
    cout << "4. Adaugati un animal manual la A" << endl;
    cout << "5. Afisati A" << endl;
    cout << "6. Afisati numarul de pagini din atlas" << endl;
    cout << "7. Cititi n obiecte. Stocati-le si afisati-le " << endl;
    cout << "8. Iesiti din program" << endl;
    cout << "================" << endl;
}


int main()
{


    AtlasZoologic<string> A;
    int n;
    string nume;
    string O, op;


    cout << "Aveti un atlas zoologic, A.\n";
    while(true)
    {
        cout << "Introduceti o comanda. Pentru legenda, introduceti 0\n";
        getline(cin, O);

        if(O == "0")
            afisareMeniu();
        if(O == "1")
            A.read();
        if(O == "2")
            cout << A.get_editura() << '\n';
        if(O == "3")
        {
            cout << "Numarul total de pesti rapitori de lungime mai mare de 1m este: ";
            Peste<string>::show_nr();
            cout << endl;
        }
        if(O == "4")
        {
            cout <<  "Introduceti tipul de animal dorit.\n1 = Nevertebrat, 2 = Reptila, 3 = Pasare, 4 = Peste, 5 = Mamifer\n";

            getline(cin, op);
            if(op == "1")
            {
                Nevertebrat<string> *p1 = new Nevertebrat<string>;
                cin >> *p1;
                A += p1;
            }
            if(op == "2")
            {
                Reptila<string> *p2 = new Reptila<string>;
                cin >> *p2;
                A += p2;
            }
            if(op == "3")
            {
                Pasare<string> *p3 = new Pasare<string>;
                cin >> *p3;
                A += p3;
            }
            if(op == "4")
            {
                Peste<string> *p4 = new Peste<string>;
                cin >> *p4;
                A += p4;
            }
            if(op == "5")
            {
                Mamifer<string> *p5 = new Mamifer<string>;
                cin >> *p5;
                A += p5;
            }
            if(op > "5")
                cout << "\nIndice gresit.";
        }
        if(O == "5")
            A.afis();
        
        if(O == "6")
            cout << A.get_nrPagini() << '\n';
        if(O == "7")
        {
            cout<<"Introduceti n"<<endl;
            cin >> n;
            universal_method<string>(n);
        }
        if(O == "8")
            return 0;
        if(O > "8")
            cout << "Indice gresit\n";
    }
    return 0;
}