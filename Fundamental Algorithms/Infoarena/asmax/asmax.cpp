#include <iostream>
#include <fstream>
#include <vector>

using namespace std;


ifstream f("asmax.in");
ofstream g("asmax.out");

int N, S;
vector<int> v;
vector<int> visited;
vector<vector<int>> edges;


int DFS(int curr)
{
    visited[curr] = 1;
    int s = v[curr], following, retval;
    for(int i = 0 ; i < edges[curr].size(); i++)
    {
        following = edges[curr][i];
        if(visited[following] == 0)
        {
            retval = DFS(following);
            if(retval > 0)
                s += retval;
        }
    }
    if(s > S)
        S = s;
    return s;
}
int main()
{
    f >> N;
    int i, ok1 = 0, ok2 = 0, maxi, start = 1, x, y;
    v = vector<int> (N + 1);
    visited = vector<int> (N + 1);
    edges = vector<vector<int>> (N + 1);


    f >> maxi;
    v[1] = maxi;
    S += maxi;
    if(maxi < 0)
        ok2 = 1;
    else
        ok1 = 1;

    for(i = 2; i <= N; i++)
    {
        f >> v[i];
        S += v[i];
        if(v[i] < 0)
            ok2 = 1;
        else
            ok1 = 1;
        
        if(v[i] > maxi)
        {
            maxi = v[i];
            start = i;
        }
    }

    if(ok2 == 0)        //if no negative values, no need to remove
    {
        g << S;
        return 0;
    }
    if (ok1 == 0)       //if no positive values, delete all nodes except the largest one
    {
        g << maxi;
        return 0;
    }

    for(i = 1; i < N; i++)
    {
        f >> x >> y;
        edges[x].push_back(y);
        edges[y].push_back(x);
    }


    DFS(start);      // we will avoid considering a negative value as root
    g << S;
    return 0;
}