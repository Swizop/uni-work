#include <iostream>
#include <fstream>
#include <iomanip>
#include <algorithm>
#include <cmath>

using namespace std;

ifstream f("sea.in");
ofstream g("sea.out");

struct S {
    double d, x, y;
};

bool comp(S v1, S v2)
{
    if(v1.x < v2.x)
        return 1;
    return 0;
}


S v[401];

int N, M, a, subFar, poz;

double x;

int main()
{
    f >> N >> M;

    for(int i = 0; i < N; i++)
        f >> v[i].x >> v[i].y;
    
    sort(v, v + N, comp);

    for(int k = 0; k < M; k++)
    {
        f >> x >> a;
        while((subFar < N) && (v[subFar].x < x))
            subFar++;
        for(int j = 0; j < subFar; j++)
        {
            v[j].d = (v[j].x - x) * (v[j].x - x) + v[j].y * v[j].y;
            poz = j;
            while((v[poz - 1].d > v[poz].d) && (poz > 0))
            {
                swap(v[poz - 1], v[poz]);
                poz--;
            }
        }
        g << fixed << setprecision(4) << sqrt(v[a - 1].d) << '\n';
    }

    return 0;
}