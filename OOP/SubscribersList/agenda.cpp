#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Persoana
{
    protected:
        int id;
        string nume;

    
    public:
        
        Persoana(int ID = -1, string n = ""): id(ID), nume(n) { }
        Persoana(const Persoana& cop)
        {
            this->id = cop.id;
            this->nume = cop.nume;
        }
        virtual ~Persoana() { }


        Persoana& operator=(const Persoana& cop)
        {
            this->id = cop.id;
            this->nume = cop.nume;
            return *this;
        }

        friend istream& operator>>(istream&, Persoana&);
        friend ostream& operator<<(ostream&, const Persoana&);
};


ostream& operator<<(ostream& out, const Persoana& p)
{
    out << "Persoana cu id-ul " << p.id << " are numele " << p.nume <<".\n";
    return out; 
}
istream& operator>>(istream& in, Persoana& p)
{
    cout << "Citirea unei persoane. Introduceti ID-ul.\n";
    in >> p.id;

    cout<<"Introduceti numele.\n";
    getline(in, p.nume);
    getline(in, p.nume);
    return in;
}


class Abonat: public Persoana
{
    protected:
        string nr_telefon;
    public:
        
        Abonat(int ID = -1, string n = "", string nr = ""): Persoana(ID, n), nr_telefon(nr) { }
        Abonat(const Abonat& cop): Persoana(cop)
        {
            this->nr_telefon = cop.nr_telefon;
        }
        virtual ~Abonat() { }


        Abonat& operator=(const Abonat& cop)
        {
            Persoana::operator=(cop);
            this->nr_telefon = cop.nr_telefon;
            return *this;
        }

        friend istream& operator>>(istream&, Abonat&);
        friend ostream& operator<<(ostream&, const Abonat&);
};


ostream& operator<<(ostream& out, const Abonat& p)
{
    out << static_cast<const Persoana&>(p);
    out << "Numarul de telefon este: " << p.nr_telefon << ".\n";
    return out; 
}
istream& operator>>(istream& in, Abonat& p)
{
    in >> static_cast<Persoana&>(p);
    cout << "Introduceti numarul de telefon.\n";
    in >> p.nr_telefon;
    return in;
}


class Abonat_Skype: public Abonat
{
    protected:
        string id_skype;
    public:
        Abonat_Skype(int ID = -1, string n = "", string nr = "", string ids = ""): Abonat(ID, n, nr), id_skype(ids) { }
        Abonat_Skype(const Abonat_Skype& cop): Abonat(cop)
        {
            this->id_skype = cop.id_skype;
        }
        virtual ~Abonat_Skype() { }


        Abonat_Skype& operator=(const Abonat_Skype& cop)
        {
            Abonat::operator=(cop);
            this->id_skype = cop.id_skype;
            return *this;
        }

        friend istream& operator>>(istream&, Abonat_Skype&);
        friend ostream& operator<<(ostream&, const Abonat_Skype&);
};


ostream& operator<<(ostream& out, const Abonat_Skype& p)
{
    out << static_cast<const Abonat&>(p);
    out << "ID-ul de Skype este: " << p.id_skype << ".\n";
    return out; 
}
istream& operator>>(istream& in, Abonat_Skype& p)
{
    in >> static_cast<Abonat&>(p);
    cout << "Introduceti ID-ul de Skype.\n";
    in >> p.id_skype;
    return in;
}


class Abonat_Skype_Romania: public Abonat_Skype
{
    protected:
        string adresa_mail;
    public:
        Abonat_Skype_Romania(int ID = -1, string n = "", string nr = "", string ids = "", string mail = ""): 
            Abonat_Skype(ID, n, nr, ids), adresa_mail(mail) { }
        Abonat_Skype_Romania(const Abonat_Skype_Romania& cop): Abonat_Skype(cop)
        {
            this->adresa_mail = cop.adresa_mail;
        }
        ~Abonat_Skype_Romania() { }


        Abonat_Skype_Romania& operator=(const Abonat_Skype_Romania& cop)
        {
            Abonat_Skype::operator=(cop);
            this->adresa_mail = cop.adresa_mail;
            return *this;
        }

        friend istream& operator>>(istream&, Abonat_Skype_Romania&);
        friend ostream& operator<<(ostream&, const Abonat_Skype_Romania&);
};


ostream& operator<<(ostream& out, const Abonat_Skype_Romania& p)
{
    out << static_cast<const Abonat_Skype&>(p);
    out << "Adresa de mail este: " << p.adresa_mail << ".\n";
    return out; 
}
istream& operator>>(istream& in, Abonat_Skype_Romania& p)
{
    in >> static_cast<Abonat_Skype&>(p);
    cout << "Introduceti adresa de mail.\n";
    getline(in, p.adresa_mail);
    getline(in, p.adresa_mail);
    return in;
}


class Abonat_Skype_Extern: public Abonat_Skype
{
    protected:
        string tara;
    public:
        Abonat_Skype_Extern(int ID = -1, string n = "", string nr = "", string ids = "", string t = ""): 
            Abonat_Skype(ID, n, nr, ids), tara(t) { }
        Abonat_Skype_Extern(const Abonat_Skype_Extern& cop): Abonat_Skype(cop)
        {
            this->tara = cop.tara;
        }
        ~Abonat_Skype_Extern() { }


        Abonat_Skype_Extern& operator=(const Abonat_Skype_Extern& cop)
        {
            Abonat_Skype::operator=(cop);
            this->tara = cop.tara;
            return *this;
        }

        friend istream& operator>>(istream&, Abonat_Skype_Extern&);
        friend ostream& operator<<(ostream&, const Abonat_Skype_Extern&);
};


ostream& operator<<(ostream& out, const Abonat_Skype_Extern& p)
{
    out << static_cast<const Abonat_Skype&>(p);
    out << "Tara de provenienta este: " << p.tara << ".\n";
    return out; 
}
istream& operator>>(istream& in, Abonat_Skype_Extern& p)
{
    in >> static_cast<Abonat_Skype&>(p);
    cout << "Introduceti tara de provenienta.\n";
    getline(in, p.tara);
    getline(in, p.tara);
    return in;
}


class Agenda
{
    vector<Abonat*> v;
    public:
        Agenda(vector<Abonat*> w = vector<Abonat*>())
        {
            for(int i = 0 ; i < w.size(); i++)
            {
                Abonat_Skype_Extern* e = dynamic_cast<Abonat_Skype_Extern*>(w[i]);              //DOWNCASTING
                if(e != NULL)
                {
                    v.push_back(new Abonat_Skype_Extern(*e));                                   //UPCASTING
                    continue;
                }

                Abonat_Skype_Romania* r = dynamic_cast<Abonat_Skype_Romania*>(w[i]);
                if(r != NULL)
                {
                    v.push_back(new Abonat_Skype_Romania(*r));
                    continue;
                }

                Abonat_Skype* s = dynamic_cast<Abonat_Skype*>(w[i]);
                if(s != NULL)
                {
                    v.push_back(new Abonat_Skype(*s));
                    continue;
                }

                Abonat* a = dynamic_cast<Abonat*>(w[i]);
                if(a != NULL)
                    v.push_back(new Abonat(*a));
                else
                    cout << "Pointer invalid!\n";
            }
        }
        Agenda(const Agenda& ob)
        {
            for(int i = 0 ; i < ob.v.size(); i++)
            {
                Abonat_Skype_Extern* e = dynamic_cast<Abonat_Skype_Extern*>(ob.v[i]);              //DOWNCASTING
                if(e != NULL)
                {
                    this->v.push_back(new Abonat_Skype_Extern(*e));                                   //UPCASTING
                    continue;
                }

                Abonat_Skype_Romania* r = dynamic_cast<Abonat_Skype_Romania*>(ob.v[i]);
                if(r != NULL)
                {
                    this->v.push_back(new Abonat_Skype_Romania(*r));
                    continue;
                }

                Abonat_Skype* s = dynamic_cast<Abonat_Skype*>(ob.v[i]);
                if(s != NULL)
                {
                    this->v.push_back(new Abonat_Skype(*s));
                    continue;
                }

                Abonat* a = dynamic_cast<Abonat*>(ob.v[i]);
                if(a != NULL)
                    this->v.push_back(new Abonat(*a));
                else
                    cout << "Pointer invalid!\n";
            }
        }
        Agenda& operator=(const Agenda& ob)
        {
            for(int i = 0 ; i < this->v.size(); i++)
                delete this->v[i];
            this->v.clear();

            for(int i = 0 ; i < ob.v.size(); i++)
            {
                Abonat_Skype_Extern* e = dynamic_cast<Abonat_Skype_Extern*>(ob.v[i]);              //DOWNCASTING
                if(e != NULL)
                {
                    this->v.push_back(new Abonat_Skype_Extern(*e));                                   //UPCASTING
                    continue;
                }

                Abonat_Skype_Romania* r = dynamic_cast<Abonat_Skype_Romania*>(ob.v[i]);
                if(r != NULL)
                {
                    this->v.push_back(new Abonat_Skype_Romania(*r));
                    continue;
                }

                Abonat_Skype* s = dynamic_cast<Abonat_Skype*>(ob.v[i]);
                if(s != NULL)
                {
                    this->v.push_back(new Abonat_Skype(*s));
                    continue;
                }

                Abonat* a = dynamic_cast<Abonat*>(ob.v[i]);
                if(a != NULL)
                    this->v.push_back(new Abonat(*a));
                else
                    cout << "Pointer invalid!\n";
            }
        }

        ~Agenda()
        {
            for(int i = 0 ; i < this->v.size(); i++)
                delete this->v[i];
        }

        void introduceti_abonat()
        {
            int q;
            cout << "Introduceti tipul de abonat dorit.\n";
            cout << "1 = Abonat simplu\n2 = Abonat Skype simplu\n3 = Abonat Skype din Romania\n4 = Abonat Skype din alta tara\n";
            cin >> q;
            switch (q)
            {
            case 1:
                Abonat *a;
                cin >> *a;
                this->v.push_back(a);
                break;
            
            case 2:
                Abonat_Skype* s;
                cin >> *s;
                this->v.push_back(s);
                break;

            case 3:
                Abonat_Skype_Romania* r;
                cin >> *r;
                this->v.push_back(r);
            
            case 4:
                Abonat_Skype_Extern* e;
                cin >> *e;
                this->v.push_back(e);
            
            default:
                cout << "Ati introdus un numar gresit";
                break;
            }
        }
        friend istream& operator>>(istream& in, Agenda& ob);
        friend ostream& operator<<(ostream& out, const Agenda& ob);
};


istream& operator>>(istream& in, Agenda& ob)
{
    cout << "Cati abonati doriti sa introduceti?\n";
    int n;
    in >> n;
    for(int i = 1; i <= n ; i++)
        {
            int q;
            cout << "Introduceti tipul de abonat dorit.\n";
            cout << "1 = Abonat simplu\n2 = Abonat Skype simplu\n3 = Abonat Skype din Romania\n4 = Abonat Skype din alta tara\n";
            in >> q;
            switch (q)
            {
            case 1:
                Abonat *a;
                in >> *a;
                ob.v.push_back(a);
                break;
            
            case 2:
                Abonat_Skype* s;
                in >> *s;
                ob.v.push_back(s);
                break;

            case 3:
                Abonat_Skype_Romania* r;
                in >> *r;
                ob.v.push_back(r);
            
            case 4:
                Abonat_Skype_Extern* e;
                in >> *e;
                ob.v.push_back(e);
            
            default:
                cout << "Ati introdus un numar gresit";
                break;
            }
        }
    return in;
}

ostream& operator<<(ostream& out, const Agenda& ob)
{
    int i;
    for(i = 0 ; i < ob.v.size(); i++)
    {
        Abonat_Skype_Extern* e = dynamic_cast<Abonat_Skype_Extern*>(ob.v[i]);              //DOWNCASTING
        if(e != NULL)
        {
            cout << *e;                                 
            continue;
        }

        Abonat_Skype_Romania* r = dynamic_cast<Abonat_Skype_Romania*>(ob.v[i]);
        if(r != NULL)
        {
            cout << *r;
            continue;
        }

        Abonat_Skype* s = dynamic_cast<Abonat_Skype*>(ob.v[i]);
        if(s != NULL)
         {
            cout << *s;
            continue;
         }

        Abonat* a = dynamic_cast<Abonat*>(ob.v[i]);
        if(a != NULL)
            cout << *a;
        else
           cout << "Pointer invalid!\n";
    }
    return out;
}

void foo(Abonat_Skype_Extern x) { Abonat_Skype_Extern q = Abonat_Skype_Extern(); q = x; cout << q; }
int main()
{
    Persoana* p;
    cin >> *p;
    
    return 0;
}
