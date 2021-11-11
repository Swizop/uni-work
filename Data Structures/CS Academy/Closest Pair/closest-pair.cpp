#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int closestPair(vector<int>& first, vector<int>& second) {
    sort(first.begin(), first.end());
    sort(second.begin(), second.end());
    
    int x = 0, y = 0, ab;
    int m = abs(first[x] - second[y]);
    
    
    while(x < first.size() && y < second.size())
    {
        ab = abs(first[x] - second[y]);
        if(ab < m)
            m = ab;
        
        if(first[x] - first[y] < 0)
            x++;
        else
            y++;
    }
    
    return m;
}

int main() {
    int n; cin >> n;
    vector<int> first, second;
    for (int i = 0; i < n; ++i) {
        int val; cin >> val;
        first.push_back(val);
    }
    for (int i = 0; i < n; ++i) {
        int val; cin >> val;
        second.push_back(val);
    }
    cout << closestPair(first, second) << "\n";
    return 0;
}
