#include <iostream>
#include <fstream>
#include <vector>
#include <queue>
#include <utility>
#include <algorithm>

using namespace std;

ifstream f("marmelada.in");
ofstream g("marmelada.out");

int N, M, S, D;
vector<vector<pair<int, int>>> edges;
vector<int> solution;
vector<pair<int,int>> costs;
vector<int> visited;
vector<pair<int, int>> fathers;
queue<int> Q;

int main()
{
    f >> N >> M >> S >> D;
    edges = vector<vector<pair<int, int>>> (N + 1);
    fathers = vector<pair<int,int>> (N + 1);
    costs = vector<pair<int,int>> (M + 1);
    visited = vector<int> (N + 1);

    int i, x, y, curr;
    pair<int, int> aux;
    
    for(i = 1 ; i <= M; i++)
    {
        f >> x >> y;
        edges[x].push_back(make_pair(y, i));
        edges[y].push_back(make_pair(x, i));
    }

    for(i = 1 ; i <= M; i++)
    {
        f >> costs[i].first;
        costs[i].second = i;
    }

    sort(costs.begin() + 1, costs.end());
    
    Q.push(S);
    visited[S] = 1;
    while(!Q.empty())
    {
        curr = Q.front();
        Q.pop();
        for(i = 0; i < edges[curr].size(); i++)
        {
            aux = edges[curr][i];
            if(visited[aux.first] == 0)
            {
                visited[aux.first] = 1;
                Q.push(aux.first);
                fathers[aux.first] = make_pair(curr, aux.second);
                if(aux.first == D)
                {
                    Q = queue<int>();
                    break;
                }
            }
        }
    }

    visited = vector<int> (M + 1);
    curr = 0;
    while(D != S)
    {
        visited[fathers[D].second] = 1;
        D = fathers[D].first;
        curr++;
    }

    x = 1;
    y = curr + 1;
    for(i = 1; i <= M; i++)
        if(visited[i])
        {
            g << costs[x].second << '\n';
            x ++;
        }
        else
        {
            g << costs[y].second << '\n';
            y ++;
        }
    return 0;
}