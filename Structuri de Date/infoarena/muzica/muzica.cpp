#include <iostream>
#include <fstream> 
#include <unordered_set>
 
using namespace std;
ifstream f("muzica.in");
ofstream g("muzica.out");
 
long long N, M, A, B, C, D, E, NR, r, x;
unordered_set<long long> m(100001);
int i;
 
int main ()
{
 f >> N >> M >> A >> B >> C >> D >> E;
 
for(i = 1; i<= N; i++)
{
 f >> x;
m.insert(x);
}

for(i=1; i<= M; i++)
{
 
if(m.find(A) != m.end())
{
    NR++;
   m.erase(A);
}

    r = (C * B + D * A) % E;
    A = B;
    B = r;
}
 
g << NR; 
return 0; 
}
