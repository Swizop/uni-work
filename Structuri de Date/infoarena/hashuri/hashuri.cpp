#include <iostream>
#include <fstream>
#include <vector>
#include <list>
#define MAX 666013

using namespace std;

ifstream f("hashuri.in");
ofstream g("hashuri.out");

int n, x;
short int op;
vector<list<int>> s(MAX);

int main()
{
    f >> n;
    int i, y;
    list<int>::iterator q;
    for(i = 1; i <= n; i++)
    {
        f >> op >> x;
        switch(op){
            case 1:
                y = x % MAX;
                q = s[y].begin();
                while(q != s[y].end() && *q != x)
                    q++;
                if(q == s[y].end())
                    s[y].push_back(x);
                break;
            case 2:
                s[x % MAX].remove(x);
                break;
            default:
                y = x % MAX;
                q = s[y].begin();
                while(q != s[y].end() && *q != x)
                    q++;
                if(q == s[y].end())
                    g << "0\n";
                else
                    g << "1\n";
                break;
        }
    }
    return 0;
}   