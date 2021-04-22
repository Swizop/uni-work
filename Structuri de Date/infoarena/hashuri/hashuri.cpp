#include <iostream>
#include <fstream>
#include <unordered_set>

using namespace std;

ifstream f("hashuri.in");
ofstream g("hashuri.out");

int n, x;
short int op;
unordered_set<int> s;

int main()
{
    f >> n;
    int i;

    for(i = 1; i <= n; i++)
    {
        f >> op >> x;
        switch(op){
            case 1:
                s.insert(x);
                break;
            case 2:
                s.erase(x);
                break;
            default:
                if(s.find(x) != s.end())
                    g << 1 << endl;
                else
                    g << 0 << endl;
                break;
        }
    }
    return 0;
}   