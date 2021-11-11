        #include <iostream>
        #include <fstream>
        #include <vector>
        #include <unordered_map>
        #include <tuple>

        using namespace std;

        ifstream f("loto.in");
        ofstream g("loto.out");

        int N, S, dif, a, b;
        vector<int> v;
        unordered_map<int, tuple<int,int,int>> m;

        int main()
        {
            int i, x, j, k; 
            f >> N >> S;
            for(i = 0; i < N; i ++)
            {
                f >> x;
                v.push_back(x);
            }

            for(i = 0; i < N; i++)
                for(j = i; j < N; j++)
                    for(k = j; k < N; k++)
                    m[v[i] + v[j] + v[k]] = make_tuple(v[i],v[j],v[k]);
            
            
            unordered_map<int,tuple<int,int,int>>::iterator q;
            for(q = m.begin(); q != m.end(); q++)
            {
                    dif = S - q->first;
                    if(m.find(dif) != m.end())
                    {
                        g << get<0>(q->second) << " " << get<1>(q->second) << " " <<
                        get<2>(q->second) << " " << get<0>(m[dif]) << " " << get<1>(m[dif]) << " "
                        << get<2>(m[dif]);
                        return 0;
                    }
                }
            g << -1;
            return 0;
        }