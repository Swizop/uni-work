#include <iostream>
#include <fstream>
#include <vector>
#include <queue>
#include <stack>
#include <algorithm>


using namespace std;

ifstream f("file.in");
ofstream g("file.out");

class Graph
{
	int N, M;
	vector<vector<int>> edges;

    vector<int> visited;

    vector<int> discovered;         
    vector<int> earliest;
    stack<int> nodes;           
    vector<vector<int>> solution;
    int K;


    vector<vector<int>> reversed;
    vector<int> aux;

    public:
        Graph(int n = 0, int m = 0, vector<vector<int>> ed = vector<vector<int>>()): N(n), M(m), edges(ed), K(0) { }

        void set_N(int n)
        {
            this->N = n;
        }


        void BFS()
        {
            int s, x, y, i, j, curr, val;
            f >> N >> M >> s;

            edges = vector<vector<int>>(N + 1);
            queue<int> q;
            vector<int> dist = vector<int>(N + 1, -1);

            for(i = 1; i <= M; i++)
            {
                f >> x >> y;
                edges[x].push_back(y);
            }

            q.push(s);
            dist[s] = 0;
            while(!q.empty())
            {
                curr = q.front();
                for(j = 0; j < edges[curr].size(); j++)
                {   
                    val = edges[curr][j];
                    if(dist[val] == -1)
                    {
                        dist[val] = dist[curr] + 1;
                        q.push(val);
                    }
                }
                q.pop();
            }

            for(i = 1; i <= N; i++)
                g << dist[i] << " ";
        }


        void dfs_utility(int curr)
        {
            for(int i = 0; i < edges[curr].size(); i++)
                if(visited[edges[curr][i]] == 0)
                {
                    visited[edges[curr][i]] = 1;
                    dfs_utility(edges[curr][i]);
                }
        }
        
        void DFS()
        {
            int i, x, y;

            f >> N >> M;
            edges = vector<vector<int>>(N + 1);
            visited = vector<int>(N + 1);
            
            for(i = 1; i <= M; i++)
            {
                f >> x >> y;
                edges[x].push_back(y);
                edges[y].push_back(x);
            }

            int conexElements = 0;
            for(i = 1; i <= N; i++)
            {
                if (visited[i] == 0)
                {
                    visited[i] = 1;
                    conexElements ++;
                    dfs_utility(i);
                }
            }
            g << conexElements;
        }


        void biconnected_utility(int curr)
        {
            int subComponents = 0, following;

            for(int i = 0; i < edges[curr].size(); i++)
            {
                following = edges[curr][i];
                if(discovered[following] == 0)
                {
                    subComponents += 1;

                    nodes.push(following);
                    discovered[following] = discovered[curr] + 1;
                    earliest[following] = discovered[curr];

                    biconnected_utility(following);

                    if(subComponents > 1 && discovered[curr] == 1)       // the only link between {{v[curr][i] and the nodes that follow it}} and {{the nodes already visited}}
                                            // is through curr => curr is a critical point => from v[curr][i] onwards we have a new biconnected component
                    {
                        solution.push_back(vector<int>());
                        while(!(nodes.top() == following))
                        {
                            solution[K].push_back(nodes.top());
                            nodes.pop();
                        }
                        solution[K].push_back(nodes.top());
                        nodes.pop();
                        solution[K].push_back(curr);        // curr (the top level node) was part of the biconnected component which was just visited in the recursion, but it will
                                                        // also be in the biconnected component with the nodes previous to that, so we keep curr in the stack, adding it sepparately
                        K++;
                    }

                    if(discovered[curr] <= earliest[following] && discovered[curr] > 1)
                    {
                        solution.push_back(vector<int>());
                        while(!(nodes.top() == following))
                        {
                            solution[K].push_back(nodes.top());
                            nodes.pop();
                        }
                        solution[K].push_back(nodes.top());
                        nodes.pop();
                        solution[K].push_back(curr);
                        K++;
                    }
                    else
                        earliest[curr] = min(earliest[following], earliest[curr]);
                    // if curr is the first node, the last biconnected component will remain in the stack bc the program won't go to line 30 again, and we'll empty it in main()
                }
                else
                {
                    earliest[curr] = min(earliest[curr], discovered[following]);
                }
            }
        }

        void biconnected()
        {
            f >> N >> M;
            int x, y, i;

            edges = vector<vector<int>>(N + 1);
            discovered = vector<int> (N + 1);
            earliest = vector<int> (N + 1);
            solution = vector<vector<int>>();

            for(i = 1; i <= M; i++)
            {
                f >> x >> y;
                edges[x].push_back(y);
                edges[y].push_back(x);
            }
            
            for(i = 1; i <= N; i++)
            {
                if (discovered[i] == 0)
                {
                    discovered[i] = earliest[i] = 1;
                    nodes.push(i);
                    biconnected_utility(i);
                }
                if(!nodes.empty())
                {
                    solution.push_back(vector<int>());
                    while(!nodes.empty())
                    {
                        solution[K].push_back(nodes.top());
                        nodes.pop();
                    }
                    K++;
                }
            }

            g << K << '\n';
            for(i = 0; i < K; i++)
            {
                for (int j = 0; j < solution[i].size(); j++)
                {
                    g << solution[i][j] << ' ';
                }
                g << '\n';
            }
        }


        void critical(int curr, int f, vector<vector<int>>& edges, vector<vector<int>>& sol, vector<int>& level, vector<int>& upwards)
        {
            int i, x;
            for(i = 0; i < edges[curr].size(); i++)
            {
                x = edges[curr][i];
                if (level[x] == 0)
                {
                    level[x] = upwards[x] = level[curr] + 1;
                    critical(x, curr, edges, sol, level, upwards);
                    if(upwards[curr] > upwards[x])
                        upwards[curr] = upwards[x];
                }
                else
                    if(x != f && f != -1)
                        if(upwards[curr] > level[x])
                            upwards[curr] = level[x];
            }
            if(level[curr] == upwards[curr] && f != -1)
                sol.push_back(vector<int> {f, curr});
                
        }

        vector<vector<int>> criticalConnections(vector<vector<int>>& connections) {
            vector<int> level = vector<int> (N);
            vector<int> upwards = vector<int> (N);
            edges = vector<vector<int>> (N);
            
            int i, j;
            for(i = 0; i < connections.size(); i++)
            {
                edges[connections[i][0]].push_back(connections[i][1]);
                edges[connections[i][1]].push_back(connections[i][0]);
            }
            
            level[0] = upwards[0] = 1;
            critical(0, -1, edges, solution, level, upwards);
            return solution;
        }


        void havel_hakimi()
        {
            int i, x, j;
            f >> N;
            for(i = 1; i <= N; i++)
            {
                f >> x;
                visited.push_back(x);       // visited[x] = degree of node x actually
            }

            while(true)
            {
                sort(visited.begin(), visited.end());
                i = visited.size() - 1;
                if(visited[i] == 0)     // every node has degree 0 so the graph can be made
                {
                    cout << "Yes.";
                    break;
                }
                j = i - 1;
                while(j >= 0 && visited[i] > 0)
                {
                    visited[j]--;
                    visited[i]--;
                    if(visited[j] < 0)
                    {
                        cout << "No!";
                        return;
                    }
                    j--;
                }
                if(j == -1 && visited[i] > 0)
                {
                    cout << "No!";
                    break;
                }
                visited.pop_back();
            }
        }


        void DFSK(int curr)
        {
            visited[curr] = 0;
            int x;
            for(int j = 0; j < edges[curr].size(); j++)
            {
                x = edges[curr][j];
                if(visited[x] == -1)
                {
                    DFSK(x);
                }
            }
            nodes.push(curr);
        }

        void DFSKR(int curr)
        {
            visited[curr] = 1;
            int x;
            for(int j = 0; j < reversed[curr].size(); j++)
            {
                x = reversed[curr][j];
                if(visited[x] == 0)
                {
                    DFSKR(x);
                }
            }
            aux.push_back(curr);
        }

        void strongly_connected_components()
        {
            f >> N >> M;
            edges = vector<vector<int>>(N + 1);
            reversed = vector<vector<int>>(N + 1);
            visited = vector<int> (N + 1, -1);
            solution = vector<vector<int>>();

            int i, x, y;

            for(i = 1 ; i <= M; i++)
            {
                f >> x >> y;
                edges[x].push_back(y);
                reversed[y].push_back(x);
            }
            
            // kosaraju
            for(i = 1 ; i <= N; i++)
            {
                if(visited[i] == -1)
                    DFSK(i);
            }

            int scc = 0;
            while(!nodes.empty())
            {
                if(visited[nodes.top()] == 0)
                {
                    aux = vector<int>();
                    DFSKR(nodes.top());
                    solution.push_back(aux);
                    scc ++;
                }
                nodes.pop();
            }
            g << scc << '\n';

            for(i = 0; i < solution.size(); i++)
            {
                for(int j = 0; j < solution[i].size(); j++)
                    g << solution[i][j] << ' ';
                g << '\n';
            }
        }


        void top_sort_utility(int curr)
        {
            visited[curr] = 1;
            int x;
            for(int i = 0; i < edges[curr].size(); i++)
            {
                x = edges[curr][i];
                if(visited[x] == 0)
                    top_sort_utility(x);
            }
            discovered.push_back(curr);
        }

        void top_sort()
        {
            f >> N >> M;
            int i, x, y;

            edges = vector<vector<int>> (N + 1);
            visited = vector<int> (N + 1);
            discovered = vector<int>();

            for(i = 1; i <= M; i++)
            {
                f >> x >> y;
                edges[x].push_back(y);
            }

            for(i = 1; i <= N; i++)
            {
                if(visited[i] == 0)
                    top_sort_utility(i);
            }

            for(i = discovered.size() - 1; i >= 0; i --)    // "discovered" contains the topological sort of the nodes
            {
                g << discovered[i] << ' ';
            }
        }
};


int main()
{
    Graph* gh = new Graph();

    //gh->BFS();
    //gh->DFS();
    //gh->biconnected();
    //gh->havel_hakimi();
    //gh->strongly_connected_components();
    //gh->top_sort();


    //bridges in a graph
    int n, m, x, y, i;
    f >> n >> m;
    gh->set_N(n);

    vector<vector<int>> connections;
    for(i = 1; i <= m; i++)
    {
        f >> x >> y;
        connections.push_back({x, y});
    }

    vector<vector<int>> sol = gh->criticalConnections(connections);
    for(i = 0; i < sol.size(); i++)
    {
        g << sol[i][0] << " " << sol[i][1] << '\n';
    }
    return 0;
}