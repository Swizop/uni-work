#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

ifstream f("pamant.in");
ofstream g("pamant.out");

int N, M, critical;
vector<vector<int>> edges;
vector<int> solution, nodesInfo, level, upwards;


void DFS(int curr)
{
    int following;
    nodesInfo[curr] = 1;
    for(int j = 0; j < edges[curr].size(); j++)
    {
        following = edges[curr][j];
        if(nodesInfo[following] == 0)
        {
            upwards[following] = level[curr];
            level[following] = level[curr] + 1;

            DFS(following);
            if(level[curr] <= upwards[following])
            {
                if(nodesInfo[curr] == 1)
                {
                    critical++;
                    nodesInfo[curr] = -1;
                }
            }
            else if (upwards[curr] > upwards[following])
                upwards[curr] = upwards[following];
        }
        else
            if(level[following] < upwards[curr])
                upwards[curr] = level[following];
    }
}


int main()
{
    f >> N >> M;
    int i, x, y, j, ok;
    edges = vector<vector<int>> (N + 1);
    nodesInfo = vector<int> (N + 1);
    level = vector<int> (N + 1);
    upwards = vector<int> (N + 1);

    for(i = 0; i < M; i++)
    {
        f >> x >> y;
        edges[x].push_back(y);
        edges[y].push_back(x);
    }

    for(i = 1; i <= N; i++)
    {
        if(nodesInfo[i] == 0)
        {
            solution.push_back(i);

            nodesInfo[i] = 1;
            level[i] = upwards[i] = 1;
            ok = 0;

            for(j = 0; j < edges[i].size(); j++)
            {
                x = edges[i][j];
                if(nodesInfo[x] == 0)
                {
                    if(ok == 1 && nodesInfo[i] == 1)
                    {
                        critical++;
                        nodesInfo[i] = -1;
                    }
                    ok = 1;
                    level[x] = 2;
                    upwards[x] = 1;
                    DFS(x);
                }
            }
        }
    }
    g << solution.size() << '\n';
    for(i = 0; i < solution.size(); i++)
        g << solution[i] << ' ';
    g << '\n';
    g << critical << '\n';
    for(i = 1; i <= N; i++)
        if(nodesInfo[i] == -1)
            g << i << ' ';
    return 0;
}