// https://www.infoarena.ro/problema/conexidad
//
#include <iostream>
#include <fstream>
#include <queue>
#include <utility>
#include <algorithm>

using namespace std;

ifstream f("conexidad.in");
ofstream g("conexidad.out");


int N, M;
vector<vector<int>> edges;
priority_queue<pair<int,int>> biggest;
vector<int> components;
vector<pair<int,int>> ambassadors;
vector<pair<int, int>> solution;

int counter, maxi = 0;


void DFS(int curr, int k)
{
    for(int i = 0; i < edges[curr].size(); i++)
        if(components[edges[curr][i]] == 0)
        {
            components[edges[curr][i]] = k;
            counter++;
            DFS(edges[curr][i], k);
        }
}


void DFS_pq(int curr)
{
    components[curr] = 0;
    for(int i = 0; i < edges[curr].size(); i++)
        if(components[edges[curr][i]] > 0)
        {
            biggest.push(make_pair(0, edges[curr][i]));
            DFS_pq(edges[curr][i]);
        }
}


int main()
{
    f >> N >> M;
    int x, y, i, nrConnected = 0;

    edges = vector<vector<int>> (N + 1);
    components = vector<int> (N + 1);

    for(i = 1; i <= M; i++)
    {
        f >> x >> y;
        edges[x].push_back(y);
        edges[y].push_back(x);
    }

    for(i = 1; i <= N; i++)
        if(components[i] == 0)
        {
            nrConnected ++;
            counter = 1;
            components[i] = nrConnected;
            DFS(i, nrConnected);
            ambassadors.push_back(make_pair(counter, i));
        }

    
    sort(ambassadors.begin(), ambassadors.end());
    
    biggest.push(make_pair(0, ambassadors[ambassadors.size() - 1].second));
    DFS_pq(biggest.top().second);

    for(i = ambassadors.size() - 2; i >= 0; i--)
    {
        x = biggest.top().second;
        y = biggest.top().first;
        biggest.pop();

        biggest.push(make_pair(-1, ambassadors[i].second));
        biggest.push(make_pair(y - 1, x));
        if(-y + 1 > maxi)
            maxi = -y + 1;
        solution.push_back(make_pair(x, ambassadors[i].second));

        DFS_pq(ambassadors[i].second);
    }

    g << maxi << '\n' << solution.size() << '\n';
    for(i = 0; i < solution.size(); i++)
        g << solution[i].first << ' ' << solution[i].second << '\n';
    return 0;
}