#include <iostream>
#include <fstream>
#include <deque>
using namespace std;

ifstream f("vila2.in");
ofstream g("vila2.out");

int n, k, i, difmax, d;
int* v;

int main()
{
    deque<int> mini;
    deque<int> maxi;
    f >> n >> k;
    v = new int[n+1];

    for(i = 1; i <= n; i++)
    {
        f >> v[i];
        while(!mini.empty() && v[i] < v[mini.back()])
            mini.pop_back();
        mini.push_back(i);
        if(mini.front() == i - k - 1)
            mini.pop_front();

        while(!maxi.empty() && v[i] > v[maxi.back()])
            maxi.pop_back();
        maxi.push_back(i);
        if(maxi.front() == i - k - 1)
            maxi.pop_front();
        
        d = v[maxi.front()] - v[mini.front()];
        if(d > difmax)
            difmax = d;
    }
    g<<difmax;
    return 0;
}