#include <iostream>
#include <fstream>
#include <vector>
#include <set>

using namespace std;

ifstream f("heapuri.in");
ofstream g("heapuri.out");

int op, x, N, lg, a, mini;
int v[200002];
set<int> h;

int main()
{ 
    int i, indx, j;
    f >> N;
    for(i = 1 ; i <= N; i++)
    {
        f >> op;
        if(op == 1)
        {
            f >> v[++lg];
            h.insert(v[lg]);
        }
        else
        {
            if(op == 2)
            {
                f >> x;
                h.erase(v[x]);
            }
            else
                if(op == 3)
                {
                    g << *h.begin() << '\n';
                }
        }
    }
    return 0;
}