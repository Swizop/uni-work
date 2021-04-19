#include <iostream>
#include <unordered_map>
#include <fstream>
#include <vector>

using namespace std;

int N, M, x, y, s;
unordered_map<int, int> m;
vector<int> v;

ifstream f("pariuri.in");
ofstream g("pariuri.out");

int main()
{
    f >> N;
    int j;
    for(int i = 1; i <= N; i ++)
    {
        f >> M;
        for(j = 1; j <= M; j++)
        {
            f >> x >> y;
            m[x] += y;
        }
    }

    for(auto i = m.begin(); i != m.end(); i++)
    {
        s++;
        v.push_back(i->first);
    }
    
    g << s << endl;
    for(j = 0; j < v.size(); j++)
    {
        g << v[j] << " " << m[v[j]] << " ";
    }
    return 0;
}