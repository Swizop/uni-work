#include <iostream> 
#include <fstream>
#include <utility>
#include <vector>


using namespace std;
ifstream f("timbre.in");
ofstream g("timbre.out");

int N, M, K, i, mini, pos;
long long suma;
int w[10002], a[10002], b[10002];
int main()
{
f >> N >> M >> K;
for(i = 0; i< M; i++)
  f >> a[i] >> b[i];

while(N > 0)
{
  mini = 100002;
  for(i = 0 ; i < M ; i++)
  {
    if(w[i] == 0 && a[i] >=N)
      if(b[i] < mini)
      {
        mini = b[i];
        pos = i;
      }
  }
  N -= K;
  suma += mini;
  w[pos] = 1;
}
g << suma;
return 0; 
}
