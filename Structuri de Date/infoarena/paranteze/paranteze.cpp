#include <iostream>
#include <string>
#include <fstream>
#include <stack>
#include <tuple>

using namespace std;

int i, n, maxi, k;
char q;

ifstream f("paranteze.in");
ofstream g("paranteze.out");

int main()
{
    f >> n;
    stack<tuple<int, char>> s;

    for(i = 1; i <= n; i++)
    {
        f >> q;
        if(s.empty())
        {
            s.push(make_tuple(i, q));
        }
        else
        {
            if(( q == ')' && get<1>(s.top()) == '(' )  ||  ( q == ']' && get<1>(s.top()) == '[' )   || ( q == '}' && get<1>(s.top()) == '{' ))
            {
                if(i - get<0>(s.top()) + 1 > maxi)
                    maxi = i - get<0>(s.top()) + 1;
                s.pop();
                if(!s.empty() && i - get<0>(s.top()) > maxi)
                    maxi = i - get<0>(s.top());
            }
            else
                s.push(make_tuple(i, q));
        }
    }

    g << maxi;

    return 0;
}