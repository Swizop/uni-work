#include <iostream>
#include <fstream>

using namespace std;

ifstream f("deque.in");
ofstream g("deque.out");

int n, k, l = 1, r = 0, i;
int *v, *dq;
long long s = 0;

int main()
{
    f >> n >> k;
    v = new int[n+1];
    dq = new int[n+1];

    for(i = 1; i <=n ; i++)
    {
        f >> v[i];
        while(l <= r && v[i] < v[dq[r]])
            r--;
        r++;
        dq[r] = i;

        if(dq[l] == i - k)
            l++;
        
        if(i >= k)
            s += v[dq[l]];
    }

    g<<s;
    
    return 0;
}