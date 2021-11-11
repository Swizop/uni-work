#include <iostream> 
#include <fstream>
#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;
ifstream f("datorii.in");
ofstream g("datorii.out");
    
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
    segTree[curr] = buildTree(curr * 2, l, mid) + buildTree(curr * 2 + 1, mid + 1, r);
    return segTree[curr];
}


int sumSeg(int curr, int lS, int rS, int l, int r)
{
    if(r < lS || l > rS)
        return 0;
    
    if(l <= lS && r >= rS)
    {
        return segTree[curr];
    }
    int mid = lS + (rS - lS) / 2;
    return sumSeg(curr * 2, lS, mid, l, r) + sumSeg(curr * 2 + 1, mid + 1, rS, l, r);
}


int update(int curr, int lS, int rS, int poz, int val)
{
    if(poz < lS || poz > rS)
        return segTree[curr];
    if(lS == rS)
    {
        segTree[curr] += val;
        v[curr] += val;
        return segTree[curr];
    }

    int mid = lS + (rS - lS) / 2;
    
    segTree[curr] = update(curr * 2, lS, mid, poz, val) + update(curr * 2 + 1, mid + 1, rS, poz, val);
    return segTree[curr];
}


int main()
{
    int n, m;
    f >> n;
    
    lg = pow(2, (int)(ceil(log2(n))) + 1) - 1;
    segTree = new int[lg + 1];
    v = new int[n + 1];

    int i, x, y, z;
    f >> m;
    for(i = 1; i <= n; i++)
    {
        f >> v[i];
    }

    buildTree(1, 1, n);


    for(i = 1; i <= m; i++)
    {
        f >> x >> y >> z;
        if(x == 0)
            update(1, 1, n, y, -z);
        else
            g << sumSeg(1, 1, n, y, z) << '\n';
    }
    
    return 0; 
}
