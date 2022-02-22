#include <iostream>
#include <fstream>

using namespace std; 

ifstream f("rf.in");
ofstream g("rf.out");

int N;
int M[257][257];
int val[257][257];
int main()
{

    f >> N;
    int i, j, k;
    for(i = 1; i <= N; i++)
        for(j = 1; j <= N; j++)
        {
            f >> M[i][j];
            val[i][j] = 1;
        }

    for(i = 1; i <= N; i++)
        val[i][i] = 0;
        
    for(k = 1; k <= N; k++)
        for(i = 1; i <= N; i++)
        {
            if(i == k) continue;
            for(j = 1; j <= N; j++)
                {
                    if(M[i][k] + M[k][j] < M[i][j])
                    {
                        M[i][j] = M[i][k] + M[k][j];
                        val[i][j] = val[i][k] + val[k][j];
                    }
                    else if(M[i][k] + M[k][j] == M[i][j] && val[i][k] + val[k][j] > val[i][j])
                        val[i][j] = val[i][k] + val[k][j];
                }
        }

    for(i = 1; i <= N; i++)
    {
        for(j = 1; j <= N; j++)
            g << M[i][j] << ' ';
        g << '\n';
    }

    for(i = 1; i <= N; i++)
    {
        for(j = 1; j <= N; j++)
            g << val[i][j] << ' ';
        g << '\n';
    }
    return 0;
}