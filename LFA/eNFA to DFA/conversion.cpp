#include <iostream>
#include <fstream>
#include <set>
#include <vector>
#include <unordered_map>
#include <utility>
#include <cstring>

using namespace std;

ifstream f("inp1.in");
ofstream g("dfa1.out");

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
        for(auto letter = alphabet.begin(); letter != alphabet.end(); ++letter)
        {
            set<int> aux;
            for(auto state1 = eClosure[i].begin(); state1!= eClosure[i].end(); ++state1)
            {
                for(int state2 = 0; state2 < nrStates; state2++)
                {
                    if(find(M[*state1][state2], *letter) != -1)
                    {    aux.insert(state2); }              
                        
                }
            }
            funct[i].push_back(aux);
        }
    }
    


    for(i = 0; i < nrStates; i++)
    {
        j = 0;
        for(auto letter = alphabet.begin(); letter != alphabet.end(); ++letter)
        {
            for(auto reachableState = funct[i][j].begin(); reachableState != funct[i][j].end(); ++reachableState)
                for(auto newState = eClosure[*reachableState].begin(); newState != eClosure[*reachableState].end(); ++newState)
                    funct[i][j].insert(*newState);
            j++;
        }
    } 


    vector<set<int>> dfaStates;
    vector<vector<set<int>>> dfa(101);        //DFA FUNCTION
    dfaStates.push_back(eClosure[start]);

    i = 0;
    for(i; i < dfaStates.size(); i++)
    {
        j = 0;
        for(auto lett = alphabet.begin(); lett != alphabet.end(); ++lett)
        {
            set<int> aux;
            set<int>::iterator dState;
            for(dState = dfaStates[i].begin(); dState != dfaStates[i].end(); ++dState)
                for(auto newState = funct[*dState][j].begin(); newState != funct[*dState][j].end(); ++newState)
                    aux.insert(*newState);
            
            dfa[i].push_back(aux);
            if(check(dfaStates, aux) == 0)
                dfaStates.push_back(aux);
            j++;
        }
    }


    for(i = 0; i < dfaStates.size(); i++)
    {
        g << "Starea " << i << ": ";
        set<int>::iterator dState;

        int ok = 0;
        for(dState = dfaStates[i].begin(); dState != dfaStates[i].end(); ++dState)
        {
            g << *dState;
            if(fin.find(*dState) != fin.end())
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
        for(auto transition = alphabet.begin(); transition != alphabet.end(); ++transition)
        {
            set<int>::iterator dState1, dState2;
            for(dState1 = dfaStates[i].begin(); dState1 != dfaStates[i].end(); ++dState1)
                g << *dState1;
            
            g << " ";

            for(dState2 = dfa[i][j].begin(); dState2 != dfa[i][j].end(); ++dState2)
                g << *dState2;

            g << " " << *transition << "\n";
            j++;
        }
        g << '\n';
    }
    return 0;
}
