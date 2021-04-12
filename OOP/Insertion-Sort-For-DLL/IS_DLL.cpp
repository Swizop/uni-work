// Toate clasele vor conține obligatoriu constructori de inițializare (0.25p),
//parametrizați (0.25p) și de copiere (0.25p); destructor (0.25p); 
//operatorii „=” (0.5p), „>>” (0.5p), „<<” (0.5p) supraîncărcați 
//corespunzător, moșteniri & encapsulare (0.5p)  
// Clasele derivate trebuie sa contina constructori parametrizati
// (prin care sa se evidentieze transmiterea parametrilor catre constructorul
// din clasa de baza) si destructori. (1p) 
// În fiecare proiect vor fi ilustrate conceptele de upcasting, downcasting,
// funcții virtuale (pure – unde se consideră mai natural) – 1.5p (0.5p / cerință) 
// Utilizarea de variabile și de funcții statice – 1p 
// Citirea informațiilor complete a n obiecte, memorarea și
// afișarea acestora – 0.5p 
// Meniu interactiv – 0.5p 
// Rezolvarea corectă a cerințelor suplimentare corespunzatoare fiecarei teme – 1.5p. 
// Se acordă punctaje parțiale corespunzător și 1p oficiu.  

// Liste de numere întregi 1 (implementate dinamic) 
// Se dau următoarele clase:  
// -Nod (int info, Nod * next); 
// -Nod_dublu (Nod * ante) : Nod; 
// -LDI (elemente de tip Nod_dublu); // listă dublu înlănțuită 
// -LSI : LDI; //listă simplu înlănțuită, obținută mostenind caracteristicile unei LDI adaptate la o înlănțuire simplă; 
// Să se exemplifice sortarea prin inserție directă utilizând LDI. 
#include <iostream>
#include <vector>

using namespace std;

class Node
    {
        Node *nextnode;
        protected:
            int info;
        public:
            Node(const int& info = 0, Node* next = NULL)
            {
                this->info = info;
                this->nextnode = next;
            }

            Node(const Node& cop)
            {
                info = cop.info;
                nextnode = cop.nextnode;
            }

            ~Node()
            {
                delete nextnode;
            }


            void setnodeinfo(const int& x)
            {
                this->info = x;
            }
            virtual void setnodenext(Node *n)
            {
                this->nextnode = n;
            }
            
            int getnodeinfo()
            {
                return this->info;
            }
            virtual Node* getnodenext()
            {
                return this->nextnode;
            }


            Node& operator=(const Node& n)
            {
                delete this->nextnode;
                
                this->info = n.info;
                this->nextnode = n.nextnode;
            }
            friend ostream& operator<<(ostream&, const Node&);
            friend istream& operator>>(istream&, Node&);
    };

class Node_dublu: public Node
    {
        Node_dublu *prev, *nextnode;
        public:
            Node_dublu(const int& info = 0, Node_dublu* prev = NULL, Node_dublu* next = NULL): Node(info), nextnode(next), prev(prev) 
            {
                if(prev != NULL)
                    this->prev->nextnode = this;
                if(next != NULL)
                    this->nextnode->prev = this;
            }

            Node_dublu(const Node_dublu& cop)
            {
                info = cop.info;
                prev = cop.prev;
                nextnode = cop.nextnode;
            }

            ~Node_dublu()
            {
                delete prev;
                delete nextnode;
            }

            
            
            void setnodeprev(Node_dublu* n)
            {
                this->prev = n;
            }
            void setnodenext(Node_dublu *n)
            {
                this->nextnode = n;
            }
            
            
            Node_dublu* getprev()
            {
                return this->prev;
            }
            Node_dublu* getnodenext()
            {
                return this->nextnode;
            }
    };

class doubly_linked_list
{
    friend class Node;
    Node *first, *last;

    public:
       doubly_linked_list();
       doubly_linked_list(doubly_linked_list&);
       Node* getfirst()
       {
           return this->first;
       }
       Node* getlast()
       {
           return this->last;
       }
       void setfirst(Node* n)
       {
           this->first = n;
       }
       void setlast(Node* n)
       {
           this->last = n;
       }
       ~doubly_linked_list()
       {
           Node* aux = this->first;
           while(aux != NULL)
           {
               Node* deln = aux;
               aux = aux->getnodenext();
               delete deln;
           }
       }


       void add_element(int, int);
       friend ostream& operator<<(ostream&, doubly_linked_list&);
       friend istream& operator>>(istream&, doubly_linked_list&);
       void delete_element(int);
       friend doubly_linked_list operator+ (doubly_linked_list, doubly_linked_list);
       friend void universal_method(int);
};

void f(doubly_linked_list x)
{
    return;
}

doubly_linked_list::doubly_linked_list()
{
    first = last = NULL;
}


doubly_linked_list::doubly_linked_list(doubly_linked_list& cop)
{
    Node* aux = cop.getfirst();
    if(!aux)
    {
        this->first = this->last = NULL;
    }
    else
    {
        this->first = new Node();
        this->first->setnodeinfo(aux->getnodeinfo());
        this->first->setnodenext(aux->getnodenext());
        this->setlast(this->getfirst());
        Node *prev;
        while(aux->getnodenext() != NULL)
        {
            aux = aux->getnodenext();
            prev = this->getlast();
            last = new Node();
            last->setnodeprev(prev);
            last->setnodeinfo(aux->getnodeinfo());
            prev->setnodenext(last);
        }
    }
}


void doubly_linked_list::add_element(int val, int poz)
{
    Node* aux = this->getfirst();
    Node* de_adaugat = new Node(val);
    if(aux == NULL && poz == 1)
    {
        setfirst(de_adaugat);
        setlast(de_adaugat);
    }
    else
    {
        if(poz == 1)
        {
            aux->setnodeprev(de_adaugat);
            de_adaugat->setnodenext(aux);
            this->setfirst(de_adaugat);
        }
        else
            if(aux == NULL)
                cout<<"Pozitie invalida!"<<endl;
            else
            {
                int i = 1;
                while(i < poz && aux != NULL)
                {
                    aux = aux->getnodenext();
                    i++;
                }
                if(i != poz)
                    cout<<"Pozitie invalida!"<<endl;
                else
                    if(aux == NULL)
                    {
                        this->last->setnodenext(de_adaugat);
                        de_adaugat->setnodeprev(this->last);
                        this->setlast(de_adaugat);
                    }
                    else
                    {
                        de_adaugat->setnodenext(aux);
                        de_adaugat->setnodeprev(aux->getprev());
                        aux->getprev()->setnodenext(de_adaugat);
                        aux->setnodeprev(de_adaugat);
                    }
            }
    }
}


ostream& operator<<(ostream& out, const Node& n)
{
    out << n.info;
    return out;
}


istream& operator>>(istream& in, Node& n)
{
    in >> n.info;
    return in;
}


ostream& operator<<(ostream& out, doubly_linked_list& L)
{
    Node* aux = L.getfirst();
    if(aux == NULL)
    {
        out<<"Lista este vida!"<<endl;
        return out; }
    out<<endl<<"Afisarea in ordine: "<<endl;
    while(aux != NULL)
    {
        out<<aux->getnodeinfo()<<" ";
        aux = aux->getnodenext();
    }
    out<<endl<<"Afisarea in ordine inversa: "<<endl;
    aux = L.getlast();
    while(aux != NULL)
    {
        out<<aux->getnodeinfo()<<" ";
        aux = aux->getprev();
    }
    out<<endl;
    return out;
}


istream& operator>>(istream& in, doubly_linked_list& L)
{
    int k = 1, ok, x;
    cout<<endl<<"Initializare lista. Introduceti o valoare intreaga"<<endl;
    in>>x;
    L.add_element(x, k);
    k++;
    while(true)
    {
        cout<<endl<<"Inserati valoarea 1 daca doriti sa continuati"<<endl;
        in>>ok;
        if(ok != 1)
            return in;
        cout<<"Introduceti o valoare"<<endl;
        in>>x;
        L.add_element(x, k);
        k++;
    }
    return in;
}


void doubly_linked_list::delete_element(int poz)
{
    Node* aux = this->getfirst();
    if(aux == NULL)
    {
        cout<<endl<<"Eroare! Lista este vida"<<endl;
        return;
    }
    if(poz == 1)
        {
            aux->getnodenext()->setnodeprev(NULL);
            this->setfirst(aux->getnodenext());
            delete aux;
        }
        else
        {
            int i = 1;
            while(i < poz && aux != NULL)
            {
                aux = aux->getnodenext();
                i++;
            }
            if(aux == NULL)
                cout<<"Pozitie invalida!"<<endl;
            else
            {
                aux->getprev()->setnodenext(aux->getnodenext());
                if(aux->getnodenext() != NULL)
                    aux->getnodenext()->setnodeprev(aux->getprev());
                cout<<aux->getprev()->getnodenext()->getnodeinfo()<<" ";
                cout<<aux->getnodenext()->getprev()->getnodeinfo()<<" ";
            }
        }
}


doubly_linked_list operator+ (doubly_linked_list L1, doubly_linked_list L2)
{
    L1.getlast()->setnodenext(L2.getfirst());
    L2.getfirst()->setnodeprev(L1.getlast());
    L1.setlast(L2.getlast());
    return L1;
}


void universal_method(int n)
{
    int i;
    doubly_linked_list* ls = new doubly_linked_list[n];
    for(i = 0; i < n; i++)
    {
        cout<<"Citire lista "<<i+1<<":\n";
        cin>>ls[i];
    }
    for(i = 0; i < n; i++)
    {
        cout<<"Afisare lista "<<i+1<<":\n";
        cout<<ls[i];
    }
}
int main()
{
    doubly_linked_list d1, d2, s;
    int n;
    int opt, k = 0, x, y, z;
    while(true)
    {
        cin>>opt;
        switch(opt)
        {
            case 1:
                cout<<"Introduceti d1"<<endl;
                cin>>d1;
                break;
            case 2:
                d2 = d1;
                break;
            case 3:
                d2 = doubly_linked_list();
                break;
            case 4:
                cout<<"Indicele listei la care doriti sa adaugati un element:\n";
                cin>>x;
                cout<<"\nElementul pe care doriti sa-l adaugati:\n";
                cin>>y;
                cout<<"\nPozitia in lista la care doriti sa adaugati un element:\n";
                cin>>z;
                if(x >= 3)
                    cout<<"Indice invalid";
                else
                    if(x == 1)
                        d1.add_element(y,z);
                    else
                        if(x == 2)
                            d2.add_element(y,z);
            case 5:
                
                cout<<"Indicele listei pe care doriti sa o afisati:\n";
                if(x >= 3)
                    cout<<"Indice invalid";
                else
                    if(x == 1)
                        cout<<d1;
                    else
                        if(x == 2)
                            cout<<d2;
            case 6:
                cout<<"Indicele listei la care doriti sa stergeti un element:\n";
                cin>>x;
                cout<<"\nElementul pe care doriti sa-l stergeti(pozitia):\n";
                cin>>y;
                if(x >= 3)
                    cout<<"Indice invalid";
                else
                    if(x == 1)
                        d1.delete_element(y);
                    else
                        if(x == 2)
                            d2.delete_element(y);
            case 7:
                s = d1 + d2;
                cout<<"Suma este: "<<s;
            default:
                cout<<"Indice gresit"<<endl;
            
            case 8:
                cout<<"Introduceti d2"<<endl;
                cin>>d2;
                break;
            case 9:
                cout<<"Introduceti n"<<endl;
                cin>>n;
                universal_method(n);
                break;
        }
        cout<<"Continuati? (1 = Da)"<<endl;
        cin>>x;
        if(x != 1)
            break;
    }
    return 0;
}