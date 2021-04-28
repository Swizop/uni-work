#include <iostream>
#include <fstream>
#include <queue>
#include <utility>

using namespace std;

ifstream f("proc2.in");
ofstream g("proc2.out");

int N, M, s, d;
priority_queue<pair<int, int>> bsy;
priority_queue<int> fre;

int main()
{
    int i, x;
    f >> N >> M;
    for(i = 1 ; i <= N ; ++i)
        fre.push(-i);
    for(i = 1 ; i <= M ; ++i)
    {
        f >> s >> d;
        while(!bsy.empty())
            if(-bsy.top().first <= s)
            {
                fre.push(bsy.top().second);
                bsy.pop();
            }
            else break;
        x = fre.top();
        g << -x << '\n';
        bsy.push(make_pair(-s - d, x));
        fre.pop();
    }
    return 0;
}

//folosim 2 heapuri. unul contine indicii procesoarelor disponibile intr-un anumit moment, din care extragem indicele minim.
// celalat contine procesoarele care sunt ocupate in acel moment, sortate dupa momentele de timp in care se vor elibera,
// astfel ca de fiecare data se vor putea extrage procesoarele care s-au eliberat (uitandu-ne in varf)