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
        protected:
            Node *nextnode;
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
            Node* getnodenext()
            {
                return this->nextnode;
            }


            Node* operator=(const Node& n)
            {
                delete this->nextnode;
                
                this->info = n.info;
                this->nextnode = n.nextnode;

                return this;
            }
            friend ostream& operator<<(ostream&, const Node&);
            friend istream& operator>>(istream&, Node&);
    };


class Node_dublu: public Node
    {
        Node *prev;
        public:
            Node_dublu(const int& info = 0, Node* next = NULL, Node* prev = NULL): Node(info, next), prev(prev) {}

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

            
            
            void setnodeprev(Node* n)
            {
                this->prev = n;
            }
            
            
            Node* getprev()
            {
                return this->prev;
            }
            
            
            Node_dublu* operator=(const Node_dublu& ob)
            {
                delete this->nextnode;
                delete this->prev;

                this->info = ob.info;
                this->nextnode = ob.nextnode;
                this->prev = ob.prev; 
                return this;
            }


            friend istream& operator>>(istream&, Node_dublu&);
            friend ostream& operator<<(ostream& out,const Node_dublu& n);
    };


class DLL
{
    Node_dublu *first, *last;

    public:
       DLL(Node_dublu* l = NULL, Node_dublu* r = NULL): first(l), last(r) {}
       DLL(DLL& cop)
       {
           Node *aux = cop.first;
           if (!aux)
           {
               this->first = this->last = NULL;
           }
           else
           {
               this->first = new Node_dublu(aux->getnodeinfo(), aux->getnodenext());
               this->last = this->first;
               Node *left;
               while (aux->getnodenext() != NULL)
               {
                   aux = aux->getnodenext();
                   left = this->getlast();                                                 //UPCASTING
                   last = new Node_dublu(aux->getnodeinfo(), NULL, left);
                   left->setnodenext(last);
               }
           }
       }
       Node_dublu* getfirst()
       {
           return this->first;
       }
       Node_dublu* getlast()
       {
           return this->last;
       }
       void setfirst(Node_dublu* n)
       {
           this->first = n;
       }
       void setlast(Node_dublu* n)
       {
           this->last = n;
       }
       ~DLL()
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
       friend ostream& operator<<(ostream&, const DLL&);
       friend istream& operator>>(istream&, DLL&);
       void delete_element(int);
       friend DLL operator+ (DLL, DLL);
};

void f(DLL x)
{
    return;
}


void DLL::add_element(int val, int poz)
{
    Node_dublu* aux = this->getfirst();
    Node_dublu* de_adaugat = new Node_dublu(val);
    if(aux == NULL && poz == 1)
    {
        this->setfirst(de_adaugat);
        this->setlast(de_adaugat);
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
                    aux = new Node_dublu(aux->getnodenext()->getnodeinfo(), aux->getnodenext(), aux);
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


istream& operator>>(istream& in, Node_dublu& n)
{
    in >> n.info;
    return in;
}


ostream& operator<<(ostream& out, const Node_dublu& n)
{
    out << n.info;
    return out;
}


ostream& operator<<(ostream& out,const DLL& L)
{
    Node* aux = L.first;
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
    Node_dublu* right = L.last;
    while(right != NULL)
    {
        out<<right->getnodeinfo()<<" ";
        right = new Node_dublu(right->getprev()->getnodeinfo(), NULL, right->getprev());
    }
    out<<endl;
    return out;
}


istream& operator>>(istream& in, DLL& L)
{
    int k, ok, x, n;
    cout<<endl<<"Initializare lista. Introduceti lungimea listei"<<endl;
    in>>n;
    cout << endl << "Introduceti cele " << n << " valori din lista" << endl;
    for(k = 1; k <= n; k++)
    {
        in >> x;
        L.add_element(x, k);
    }
    return in;
}


void DLL::delete_element(int poz)
{
    Node_dublu *aux = this->getfirst(), *urm;
    if(aux == NULL)
    {
        cout<<endl<<"Eroare! Lista este vida"<<endl;
        return;
    }
    if(poz == 1)
        {
            urm = new Node_dublu(aux->getnodenext()->getnodeinfo(), aux->getnodenext()->getnodenext(), NULL);
            this->setfirst(urm);
            delete aux;
        }
        else
        {
            int i = 1;
            while(i < poz && aux != NULL)
            {
                aux =  new Node_dublu(aux->getnodenext()->getnodeinfo(), aux->getnodenext()->getnodenext(), aux);
                i++;
            }
            if(aux == NULL)
                cout<<"Pozitie invalida!"<<endl;
            else
            {
                if(aux->getnodenext() != NULL)
                {
                    urm = new Node_dublu(aux->getnodenext()->getnodeinfo(), aux->getnodenext()->getnodenext(), aux->getprev());
                    aux->getprev()->setnodenext(urm);
                    delete aux;
                }
                else
                {
                    aux->getprev()->setnodenext(aux->getnodenext());
                    delete aux;
                }
                // cout<<aux->getprev()->getnodenext()->getnodeinfo()<<" ";
                // cout<<aux->getnodenext()->getprev()->getnodeinfo()<<" ";
            }
        }
}


DLL operator+ (DLL L1, DLL L2)
{
    L1.getlast()->setnodenext(L2.getfirst());
    L2.getfirst()->setnodeprev(L1.getlast());
    L1.setlast(L2.getlast());
    return L1;
}

template <typename T>
void prelucrare_n_elemente(int n)
{
    int i;
    T* storageUnit = new T[n];
    for(i = 0; i < n; i++)
    {
        cout<<"Citirea instantei de obiect cu numarul "<<i+1<<":\n";
        cin>>storageUnit[i];
    }
    for(i = 0; i < n; i++)
    {
        cout<<"Afisare instanta de obiect cu numarul "<<i+1<<":\n";
        cout<<storageUnit[i];
    }
}
int main()
{
    DLL d1, d2, s;
    int n;
    int opt, k = 0, x, y, z;
    cin >> d1;
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
                d2 = DLL();
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
            
            case 8:
                cout<<"Introduceti d2"<<endl;
                cin>>d2;
                break;
            case 9:
                cout<<"Introduceti n"<<endl;
                cin>>n;
                prelucrare_n_elemente<DLL>(n);
                break;
            default:
                cout<<"Indice gresit"<<endl;
        }
        
        cout<<"Continuati? (1 = Da)"<<endl;
        cin>>x;
        if(x != 1)
            break;
    }
    return 0;
}
