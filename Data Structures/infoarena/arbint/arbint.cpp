#include <iostream> 
#include <fstream>
#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;
ifstream f("arbint.in");
ofstream g("arbint.out");
    
int* v;
int* segTree;
int lg;


int buildTree(int curr, int l, int r)
{
    if(l == r)
    {
        segTree[curr] = v[l];
        return segTree[curr];
    }

    int mid = l + (r - l) / 2;
    segTree[curr] = max(buildTree(curr * 2, l, mid), buildTree(curr * 2 + 1, mid + 1, r));
    return segTree[curr];
}


int maxSeg(int curr, int lS, int rS, int l, int r)
{
    if(r < lS || l > rS)
        return -1;
    
    if(l <= lS && r >= rS)
    {
        return segTree[curr];
    }
    int mid = lS + (rS - lS) / 2;
    return max(maxSeg(curr * 2, lS, mid, l, r), maxSeg(curr * 2 + 1, mid + 1, rS, l, r));
}


int update(int curr, int lS, int rS, int poz, int val)
{
    if(poz < lS || poz > rS)
        return segTree[curr];
    if(lS == rS)
    {
        segTree[curr] = val;
        return val;
    }

    int mid = lS + (rS - lS) / 2;
    
    segTree[curr] = max(update(curr * 2, lS, mid, poz, val), update(curr * 2 + 1, mid + 1, rS, poz, val));
    return segTree[curr];
}
int main()
{
    int n, m;

    f >> n >> m;
    v = new int[n + 1];
    int i, x, y, z;
    for(i = 1; i <= n; i++)
    {
        f >> v[i];
    }

    lg = pow(2, (int)(ceil(log2(n))) + 1) - 1;
    segTree = new int[lg + 1];
    buildTree(1, 1, n);
    
    for(i = 1; i <= m; i++)
    {
        f >> x >> y >> z;
        if(x == 0)
            g << maxSeg(1, 1, n, y, z) << '\n';
        else
        {
            update(1, 1, n, y, z);
        }
    }
    return 0; 
}