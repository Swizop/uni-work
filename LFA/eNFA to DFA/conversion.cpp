#include <iostream>
#include <fstream>
#include <set>
#include <vector>
#include <unordered_map>
#include <utility>
#include <cstring>

using namespace std;

ifstream f("inp2.in");
ofstream g("dfa2.out");

char M[101][101][101];        //adjacency matrix
int v[101], nrStates;

int find(char p[], char q)
{
    int k = 0;
    while(p[k] != '\0')
    {
        if(p[k] == q)
            return k;
        k++;
    }
    return -1;
}


void complete(set<int> &e, int curr, set<int> &f)
{
    for(int i = 0; i < nrStates; i++)
        if(find(M[curr][i], '#') != -1 && v[i] == 0)
        {
            v[i] = 1;
            e.insert(i);
            complete(e, i, f);
            if(f.find(i) != f.end())
                f.insert(curr);
        }
}


int check(vector<set<int>> w, set<int> z)
{
    for(int u = 0; u < w.size(); u++)
        if(w[u] == z)
            return 1;
    return 0;
}


int main()
{
    int i, j, nrTrans, x, y, start, finLength, l;
    char t;
    set<char> alphabet;
    set<int> fin;

    f >> nrStates >> nrTrans;

    for(i = 0; i < nrTrans; i++)
    {
        f >> x >> y;
        f >> t;
        if(t != '#')
            alphabet.insert(t);
        l = strlen(M[x][y]);
        M[x][y][l] = t;
        M[x][y][l + 1] = '\0';
    }

    f >> start;
    f >> finLength;
    for(i = 0 ; i < finLength; i++)
    {
        f >> x;
        fin.insert(x);
    }

    for(i = 0; i < nrStates; i++)               //each state has an e transition to itself
    {
        l = strlen(M[i][i]);
        M[i][i][l] = '#';
        M[i][i][l + 1] = '\0';
    }
    
    vector<set<int>> eClosure;
    for(i = 0; i < nrStates; i++)
    {
        set<int> aux;
        aux.insert(i);
        for(int j = 0; j < nrStates; j++)
            v[j] = 0;
        
        v[i] = 1;
        complete(aux, i, fin);
        eClosure.push_back(aux);
    }

    // for(i = 0; i < eClosure.size(); i++)
    // {
    //     g << "e closure of " << i << ": ";
    //     for(auto j = eClosure[i].begin(); j != eClosure[i].end(); ++j)
    //         g << *j << " ";
    //     g << endl;
    // }
    

    vector<vector<set<int>>> funct(101);        //e nfa function
    for(i = 0; i < nrStates; i++)
    {
        //j = 0;
        for(auto k = alphabet.begin(); k != alphabet.end(); ++k)
        {
            set<int> aux;
            for(auto t = eClosure[i].begin(); t!= eClosure[i].end(); ++t)
            {
                for(int t2 = 0; t2 < nrStates; t2++)
                {
                    if(find(M[*t][t2], *k) != -1)
                    {    aux.insert(t2); }               //cout <<i << " " << *k << " " << *t << " " << t2 << endl; }
                        
                //cout << *t << " " << t2 << endl;
                }
            }
            funct[i].push_back(aux);
            //cout << endl;
        }
    }
    
    
    // for(i = 0; i < nrStates; i++)
    // {
    //     j = 0;
    //     for(auto k = alphabet.begin(); k != alphabet.end(); ++k)
    //     {
    //         g << "state " << i << " letter " << *k << ": ";
    //         for(auto t3 = funct[i][j].begin(); t3 != funct[i][j].end(); ++t3)
    //             g << *t3 << " ";
    //         g << endl;
    //         j++;
    //     }
    // } 


    for(i = 0; i < nrStates; i++)
    {
        j = 0;
        for(auto k = alphabet.begin(); k != alphabet.end(); ++k)
        {
            for(auto t3 = funct[i][j].begin(); t3 != funct[i][j].end(); ++t3)
                for(auto t4 = eClosure[*t3].begin(); t4 != eClosure[*t3].end(); ++t4)
                    funct[i][j].insert(*t4);
            j++;
        }
    } 

    // for(i = 0; i < nrStates; i++)
    // {
    //     j = 0;
    //     for(auto k = alphabet.begin(); k != alphabet.end(); ++k)
    //     {
    //         g << "state " << i << " letter " << *k << ": ";
    //         for(auto t3 = funct[i][j].begin(); t3 != funct[i][j].end(); ++t3)
    //             g << *t3 << " ";
    //         g << endl;
    //         j++;
    //     }
    // }


    vector<set<int>> dfaStates;
    vector<vector<set<int>>> dfa(101);        //DFA FUNCTION
    dfaStates.push_back(eClosure[start]);

    i = 0;
    for(i; i < dfaStates.size(); i++)
    {
        j = 0;
        for(auto cr = alphabet.begin(); cr != alphabet.end(); ++cr)
        {
            set<int> aux;
            set<int>::iterator t3;
            for(t3 = dfaStates[i].begin(); t3 != dfaStates[i].end(); ++t3)
                for(auto t4 = funct[*t3][j].begin(); t4 != funct[*t3][j].end(); ++t4)
                    aux.insert(*t4);
            
            dfa[i].push_back(aux);
            if(check(dfaStates, aux) == 0)
                dfaStates.push_back(aux);
            j++;
        }
    }


    for(i = 0; i < dfaStates.size(); i++)
    {
        g << "Starea " << i << ": ";
        set<int>::iterator t3;

        int ok = 0;
        for(t3 = dfaStates[i].begin(); t3 != dfaStates[i].end(); ++t3)
        {
            g << *t3;
            if(fin.find(*t3) != fin.end())
                ok = 1;
        }
        
        if(i == 0)
            g << " initiala";
        
        if(ok)
            g << " finala";
        g << '\n';
    }
    
    g << '\n';

    i = 0;
    for(i; i < dfaStates.size(); i++)
    {
        j = 0;
        for(auto cr = alphabet.begin(); cr != alphabet.end(); ++cr)
        {
            set<int>::iterator t3, t4;
            for(t3 = dfaStates[i].begin(); t3 != dfaStates[i].end(); ++t3)
                g << *t3;
            
            g << " ";

            for(t4 = dfa[i][j].begin(); t4 != dfa[i][j].end(); ++t4)
                g << *t4;

            g << " " << *cr << "\n";
            j++;
        }
        g << '\n';
    }
    return 0;
}
