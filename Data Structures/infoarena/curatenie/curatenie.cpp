#include <iostream>
#include <fstream>
#include <unordered_map>
#include <vector>

using namespace std;

ifstream f("curatenie.in");
ofstream g("curatenie.out");

int *inord, *preord;
unordered_map<int, int> h;
vector<int> lchild(500002);
vector<int> rchild(500002);

int preordIndx = 1, N;

int rec(int l, int r)
{
    if(l > r || preordIndx > N)
        return 0;
    
    int y = preord[preordIndx];         //value
    int x = h[y];      //inorder pos of value
    preordIndx++;

    if(l == r)
        return y;
    
    lchild[y] = rec(l, x - 1);
    rchild[y] = rec(x + 1, r);

    return y;
}

int main()
{
    int i;
    f >> N;
    inord = new int[N + 1];
    preord = new int[N + 1];

    for(i = 1; i <= N; i++)
    {
        f >> inord[i];
        h[inord[i]] = i;
    }

    for(i = 1; i <= N; i++)
        f >> preord[i];
    
    rec(1, N);

    for(i = 1; i <= N; i++)
        g << lchild[i] << " " << rchild[i] << '\n';
    return 0;
}