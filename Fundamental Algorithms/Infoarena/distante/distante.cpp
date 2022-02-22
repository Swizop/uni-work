#include <iostream>
#include <fstream>
#include <queue>
#include <vector>
#include <utility>

#define MAX 1000000000

using namespace std;

ifstream f("distante.in");
ofstream g("distante.out");

int N, M;
vector<int> distanteInput, distanteReale;
vector<vector<pair<int, int>>> weightedEdges;
priority_queue<pair<int, int>> pq;
vector<int> nodesInfo;

int main()
{
    int T, t, start, x, y, c, i, following, ok;
    f >> T;
    for(t = 1; t <= T; t++)
    {
        f >> N >> M >> start;
        distanteInput = vector<int> (N + 1);
        distanteReale = vector<int> (N + 1, MAX);
        weightedEdges = vector<vector<pair<int,int>>> (N + 1);
        nodesInfo = vector<int> (N + 1);

        for(i = 1; i <= N; i++)
            f >> distanteInput[i];
        
        for(i = 1; i <= M; i++)
        {
            f >> x >> y >> c;
            weightedEdges[x].push_back(make_pair(c, y));
            weightedEdges[y].push_back(make_pair(c, x));
        }

        distanteReale[start] = 0;
        pq.push(make_pair(0, start));

        ok = 1;
        while(!pq.empty())
        {
            x = -pq.top().first;
            y = pq.top().second;

            pq.pop();
            if(nodesInfo[y] == 0)       // y can be pushed twice at line 70, through 2 different nodes, before being picked
            {
                nodesInfo[y] = 1;
                for(i = 0; i < weightedEdges[y].size(); i++)
                {
                    following = weightedEdges[y][i].second;
                    c = weightedEdges[y][i].first;
                    if(nodesInfo[following] == 0)             
                    {
                        if(x + c < distanteReale[following])
                        {
                            distanteReale[following] = x + c;

                            pq.push(make_pair(-distanteReale[following], following));
                        }
                    }
                }
            }
        }

        for(i = 1; i <= N; i++)
            if(distanteReale[i] != distanteInput[i])
            {
                g << "NU\n";
                ok = 0;
                break;
            }
        if(ok == 1)
            g << "DA\n";
    }
    return 0;
}