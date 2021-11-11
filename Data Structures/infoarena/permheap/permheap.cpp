#include <iostream>
#include <fstream>

using namespace std;

ifstream f("permheap.in");
ofstream g("permheap.out");

int n, NR;
int *v;

void rec(int k)
{
    if(k == n + 1)
    {
        NR = (NR + 1) % 666013;
    }
    int j, i, ok;
    for(i = v[k / 2] - 1; i >= 1; i --)
    {
        ok = 1;
        for(j = 2; j < k; j++)
            if(v[j] == i)
            {
                ok = 0;
                break;
            }
        if(ok)
        {
            v[k] = i;
            rec(k+1);
        }
    }
}

int main()
{
    
    f >> n;

    v = new int[n];

    v[1] = n;
    rec(2);

    g << NR;
    return 0;
}