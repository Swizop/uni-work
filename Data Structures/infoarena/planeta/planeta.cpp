#include <iostream>
#include <fstream>
#include <stdlib.h>

using namespace std;

ifstream f("planeta.in");
ofstream g("planeta.out");

int n, K, x;
int v[31];

void perm(int poz)
{
    if(poz == n + 1)
    {
        x++;
        if(x == K)
        {
            for(int i = 1; i < poz; i++)
                g << v[i] << " ";
            exit(0);
        }
    }
    else
    {
        for(v[poz] = 1; v[poz] <= n; v[poz] ++)
        {
            int ok = 2, max1 = v[1], max2 = v[1];
            for(int i = 1; i < poz; i++)
            {
                if(v[poz] == v[i])
                {
                    ok = 0;
                    break;
                }
                if(i >= 2 && v[poz] < v[i - 1] && v[i - 1] < v[i])
                    ok = 0;
                if(v[i] > max2)
                {
                    max1 = max2;
                    max2 = v[i];
                    if(v[poz] < max1)
                    {
                        ok = 0;
                        break;
                    }
                }
            }
            if(ok)
                perm(poz + 1);
        }
    }
}
int main()
{
    f >> n >> K;
    perm(1);
    return 0;
}