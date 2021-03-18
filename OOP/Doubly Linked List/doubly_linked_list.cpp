#include <iostream>
#include <vector>

using namespace std;

class Node
    {
        int info;
        Node *prev, *nextnode;
        public:
            Node(const int& info = 0, Node* prev = NULL, Node* next = NULL)
            {
                this->info = info;
                this->prev = prev;
                this->nextnode = next;
            }

            Node(const Node& cop)
            {
                info = cop.info;
                prev = cop.prev;
                nextnode = cop.nextnode;
            }

            ~Node()
            {
                delete prev;
                delete nextnode;
            }

            void setnodeinfo(const int& x)
            {
                this->info = x;
            }
            void setnodeprev(Node* n)
            {
                this->prev = n;
            }
            void setnodenext(Node *n)
            {
                this->nextnode = n;
            }
            
            int getnodeinfo()
            {
                return this->info;
            }
            Node* getprev()
            {
                return this->prev;
            }
            Node* getnodenext()
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
