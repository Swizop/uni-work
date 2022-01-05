#include <iostream>
#include <fstream>
#include <vector>
#include <utility>
#include <queue>
 
#define MAX 1000000000
using namespace std;
 
ifstream f("muzeu.in");
ofstream g("muzeu.out");
 
int N;
vector<vector<int>> M;
queue<pair<int,int>> Q;

 
int main()
{
    f >> N;
    M = vector<vector<int>> (N + 2);
    M[0] = vector<int> (N + 2, -2);
    M[N + 1] = vector<int> (N + 2, -2);
    int i, j, x, y;
    char k;
    for(i = 1; i <= N; i ++)
    {
        M[i] = vector<int> (N + 2, MAX);
        M[i][0] = M[i][N + 1] = -2;
 
        for(j = 1 ; j <= N; j++)
        {
            f >> k;
            if (k == '#')
                M[i][j] = -2;
            else if (k == 'P')
            {
                M[i][j] = 0;
                Q.push(make_pair(i, j));
            }
        }
    }
    
 
    while(!Q.empty())
    {
        x = Q.front().first;
        y = Q.front().second;
        Q.pop();
 
        if(M[x][y] + 1 < M[x - 1][y])
        {
            M[x - 1][y] = M[x][y] + 1;
            Q.push(make_pair(x - 1, y));
        }
 
        if(M[x][y] + 1 < M[x + 1][y])
        {
            M[x + 1][y] = M[x][y] + 1;
            Q.push(make_pair(x + 1, y));
        }
 
        if(M[x][y] + 1 < M[x][y + 1])
        {
            M[x][y + 1] = M[x][y] + 1;
            Q.push(make_pair(x, y + 1));
        }
 
        if(M[x][y] + 1 < M[x][y - 1])
        {
            M[x][y - 1] = M[x][y] + 1;
            Q.push(make_pair(x, y - 1));
        }
    }
 
    for(i = 1; i <= N; i ++)
    {
        for(j = 1; j <= N; j++)
            if(M[i][j] == MAX)
                g << -1 << ' ';
            else
                g << M[i][j] << ' ';
        g << '\n';
    }
    return 0;
}