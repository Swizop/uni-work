#include <iostream>
#include <fstream>
#include <algorithm>
#include <cmath>

using namespace std;

ifstream f("rmq.in");
ofstream g("rmq.out");

int* v;

int minVal(int** m, int l, int r)
{ 
	int lg = r - l+ 1;
	int k = log2(lg);

	return min(m[l][k], m[r - (1 << k) + 1][k]);
}

int main()
{
	int n, i, L, j, M, l, r;
	f >> n >> M;
	
	L = log2(n) + 1;
	v = new int[n];
	
	int** m = new int*[n];

	for(i = 0; i < n; i++) {
		m[i] = new int[L];
		f >> v[i];
		m[i][0] = v[i];
	}
	
	for(int j = 1; j < L; j++) 
	{
		for(i = 0; i + (1 << j) - 1 < n; i++) 
			m[i][j] = min(m[i][j - 1], m[i+(1 << (j - 1))][j - 1]);
	}
	
	for(i = 0; i < M; i++) 
	{
		int l, r;
		f >> l >> r;
		g << minVal(m, l - 1, r - 1) << '\n';
	}

	return 0;
}
