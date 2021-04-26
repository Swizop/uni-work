#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

ifstream f("heapuri.in");
ofstream g("heapuri.out");

int op, x, N, lg, a;
int v[200002], h[200002];

int main()
{ 
    int i, indx, j;
    f >> N;
    for(i = 1; i <= N; i++)
    {
        f >> op;
        if(op == 3)
        {
            g << h[1] << '\n';
            continue;
        }
        f >> x;
        
        if(op == 1)
        {
            lg++;
            h[lg] = v[lg] = x;

            indx = lg;
            while(true)                     //heapify up
            {
                a = indx / 2;
                if(a == 0)
                    break;
                if(h[indx] < h[a])
                {
                    swap(h[a], h[indx]);
                    indx = a;
                }
                else break;
            }
        }
        else
        {
            x = v[x];
            for(j = 1; j <= lg; j++)
                if(h[j] == x)
                {
                    indx = j;
                    break;
                }
            if(indx == lg)
                lg--;
            
            else
            {
            swap(h[indx], h[lg]);
            lg--;
            
            while(true)                     //heapify down
            {
                a = indx * 2;
                if(a > lg)
                    break;
                if(a + 1 <= lg)
                {
                    if(h[a] <= h[a + 1] && h[indx] > h[a])
                    {
                        swap(h[a], h[indx]);
                        indx = a;
                    }
                    else
                        if(h[a] > h[a + 1] && h[indx] > h[a+1])
                        {
                            swap(h[a+1], h[indx]);
                            indx = a;
                        }
                        else break;
                }
                else
                    if(h[indx] > h[a])
                    {
                        swap(h[a], h[indx]);
                        indx = a;
                    }
                    else break;
            }

            while(true)                     //heapify up
            {
                a = indx / 2;
                if(a < 1)
                    break;
                if(h[indx] < h[a])
                {
                    swap(h[a], h[indx]);
                    indx = a;
                }
                else break;
            }
            }
        }
    }
    return 0;
}