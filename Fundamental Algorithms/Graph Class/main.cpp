#include <iostream>
#include <fstream>
#include <vector>
#include <utility>
#include <string>
#include <queue>
#include <stack>
#include <algorithm>

#define MAX 1000000000
#define MAXCAPACITY 200000
using namespace std;

ifstream f("dfs.in");
ofstream g("dfs.out");


void print_stack(stack<int>& nodes)
{
    while(!nodes.empty())
    {
        g << nodes.top() << ' ';
        nodes.pop();
    }
}


class Disjoint_Set_Forest{
    int N;
    vector<int> father;
    vector<int> height;
    public:

        Disjoint_Set_Forest(int = 0);
        int represents(int);
        void unite(int, int);
};


Disjoint_Set_Forest :: Disjoint_Set_Forest(int x): N(x) {
    father = vector<int> (N + 1);
    height = vector<int> (N + 1);
}


int Disjoint_Set_Forest :: represents(int curr)
{
    if(father[curr] == 0)
        return curr;
    
    int f = represents(father[curr]);
    father[curr] = f;
    return f;
}


void Disjoint_Set_Forest :: unite(int x, int y)
{
    if(height[x] < height[y])
        father[x] = y;
    else
        father[y] = x;
 
    if(height[x] == height[y])
        height[x] ++;
}


class Graph
{
    int N, M;

    vector<int> nodesInfo;
    queue<int> Q;
    vector<pair<int, pair<int, int>>> weightedEdges;            //first -> edge cost, second -> nodes in edge
    vector<vector<pair<int, int>>> weightedNeighbours;          // first -> edge weight ; second -> 2nd node in edge
    vector<vector<int>> edges;

    public:
        Graph() = default;

        void set_unoriented_edge(int, int);
        void set_oriented_edge(int, int);

        void init_edges();

        void set_nodesInfo(int);
        void set_fathers(vector<int>&);

        void read_N();
        void read_M();

        int get_N();
        int get_node_info(int);
        void set_node_info(int, int);

        void read_edges();      // use when edges are given in the form of adjacency list
        void read_edges_oriented();
        void read_edges_oriented_with_reversed(vector<vector<int>>&);
        
        void read_edges_matrix();       // edges are given in the form of adjacency matrix
        void read_weightedEdges();
        void read_weightedNeighbours();
        void read_edges_flow(vector<vector<int>>&);

        void print_message(string);
        void print_array(vector<int>, int);
        void print_nodesInfo(int, int, int);

        void BFS(int);
        void DFS(int);
        void DFS_kosaraju(int, vector<vector<int>>&, vector<int>&);
        
        void biconnected_utility(int, stack<int>&, vector<int>&, vector<vector<int>>&, int&);
        void biconnected();
        void strongly_connected();
        void top_sort_utility(int, stack<int>&);
        void topological_sort();
        void havel_hakimi();
        void critical(int, int, vector<vector<int>>&, vector<int>&);
        void bridges();
        void kruskal();
        void dijkstra(int);
        void bellman_ford();
        void edmonds_karp();
        void graph_diameter();
        void roy_floyd();
        void euler_cycle();
};


void Graph :: init_edges() { edges = vector<vector<int>> (N + 1);}
void Graph :: set_nodesInfo(int value) { nodesInfo = vector<int> (N + 1, value); }
void Graph :: set_fathers(vector<int>& fathers) { fathers = vector<int> (N + 1);}


void Graph :: set_unoriented_edge(int x, int y) { edges[x].push_back(y); edges[y].push_back(x); }
void Graph :: set_oriented_edge(int x, int y) { edges[x].push_back(y); }


void Graph :: read_N() { f >> N; }
void Graph :: read_M() { f >> M; }


int Graph :: get_N() { return N; }
int Graph :: get_node_info(int x) { return nodesInfo[x]; }
void Graph :: set_node_info(int x, int val) { nodesInfo[x] = val; }


void Graph :: read_edges_matrix()
{
    int i, j;
    for(i = 1; i <= N; i++)
        edges[i] = vector<int> (N + 1);
    
    for(i = 1; i <= N; i++)
        for(j = 1; j <= N; j++)
        {
            f >> edges[i][j];
            if(edges[i][j] == 0 && i != j)
                edges[i][j] = MAX;
        }
}


void Graph :: read_edges()
{
    int i, x, y;
    for(i = 1; i <= M; i++)
    {
        f >> x >> y;
        set_unoriented_edge(x, y);
    }
}


void Graph :: read_edges_oriented()
{
    int i, x, y;
    for(i = 1; i <= M; i++)
    {
        f >> x >> y;
        set_oriented_edge(x, y);
    }
}


void Graph :: read_edges_oriented_with_reversed(vector<vector<int>>& reversed)
{
    int i, x, y;
    for(i = 1; i <= M; i++)
    {
        f >> x >> y;
        set_oriented_edge(x, y);
        reversed[y].push_back(x);
    }
}


void Graph :: read_weightedEdges()
{
    read_N();
    read_M();

    int i, x, y, c;
    for(i = 1; i <= M; i++)
    {
        f >> x >> y >> c;
        weightedEdges.push_back(make_pair(c, make_pair(x, y)));
    }
}


void Graph :: read_weightedNeighbours()
{
    read_N();
    read_M();

    weightedNeighbours = vector<vector<pair<int, int>>> (N + 1);    // first -> edge weight ; second -> 2nd node in edge

    int i, x, y, c;
    for(i = 1; i <= M; i++)
    {
        f >> x >> y >> c;
        weightedNeighbours[x].push_back(make_pair(c, y));
    }
}


void Graph :: read_edges_flow(vector<vector<int>>& flow)
{
    f >> N >> M;
    edges = vector<vector<int>> (N + 1);
    flow = vector<vector<int>> (N + 1);

    int i, x, y, c;
    
    for(i = 1; i <= N; i++)
        flow[i] = vector<int> (N + 1);

    for(i = 1; i <= M; i++)
    {
        f >> x >> y >> c;
        edges[x].push_back(y);
        edges[y].push_back(x);

        flow[x][y] = c;
    }
}


void Graph :: print_message(string m) { g << m; }


void Graph :: print_array(vector<int> solution, int start)
{
    for(int i = start; i < solution.size(); i ++)
    {
        g << solution[i] << ' ';
    }
}


void Graph :: print_nodesInfo(int start, int replaced, int replaceWith)
{
    for(int i = start; i <= N; i++)
        if(nodesInfo[i] == replaced)
            g << replaceWith << " ";
        else
            g << nodesInfo[i] << " ";
}


void Graph :: BFS(int start)
{
    nodesInfo[start] = 0;
    Q.push(start);
    int curr, i, following;
    while(!Q.empty())
    {
        curr = Q.front();
        Q.pop();
        for(i = 0; i < edges[curr].size(); i++)
        {
            following = edges[curr][i];
            if(nodesInfo[following] == MAX)
            {
                Q.push(following);
                nodesInfo[following] = nodesInfo[curr] + 1;
            }
            else if(nodesInfo[curr] + 1 < nodesInfo[following])
                nodesInfo[following] = nodesInfo[curr] + 1;
        }
    }
}


void Graph :: DFS(int curr)
{
    for(int i = 0; i < edges[curr].size(); i++)
        if(nodesInfo[edges[curr][i]] == 0)
        {
            nodesInfo[edges[curr][i]] = 1;
            DFS(edges[curr][i]);
        }
}


void Graph :: biconnected_utility(int curr, stack<int>& nodes, vector<int>& earliest, vector<vector<int>>& solution, int& K)
{
    int subComponents = 0, following;
 
    for(int i = 0; i < edges[curr].size(); i++)
    {
        following = edges[curr][i];
        if(nodesInfo[following] == 0)
        {
            subComponents += 1;
 
            nodes.push(following);
            nodesInfo[following] = nodesInfo[curr] + 1;
            earliest[following] = nodesInfo[curr];
 
            biconnected_utility(following, nodes, earliest, solution, K);
 
            if(subComponents > 1 && nodesInfo[curr] == 1)       // the only link between {{v[curr][i] and the nodes that follow it}} and {{the nodes already visited}}
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
 
            if(nodesInfo[curr] <= earliest[following] && nodesInfo[curr] > 1)
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
            earliest[curr] = min(earliest[curr], nodesInfo[following]);
        }
    }
}

void Graph :: biconnected()
{
    read_N();
    read_M();

    init_edges();
    read_edges();
    set_nodesInfo(0);       // nodesInfo will represent the time when nodes were discovered

    vector<int> earliest = vector<int> (N + 1);        // the earliest time of a node to which a node can go back to
    stack<int> nodes;
    vector<vector<int>> solution;
    int i, K = 0;

    for(i = 1; i <= N; i++)
    {
        if (nodesInfo[i] == 0)
        {
            nodesInfo[i] = earliest[i] = 1;
            nodes.push(i);
            biconnected_utility(i, nodes, earliest, solution, K);
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


void Graph :: DFS_kosaraju(int curr, vector<vector<int>>& reversed, vector<int>& aux)
{
    nodesInfo[curr] = 2;
    int x;
    for(int j = 0; j < reversed[curr].size(); j++)
    {
        x = reversed[curr][j];
        if(nodesInfo[x] == 1)
        {
            DFS_kosaraju(x, reversed, aux);
        }
    }
    aux.push_back(curr);
}


void Graph :: strongly_connected()
{
    read_N();
    read_M();

    init_edges();
    vector<vector<int>> reversed = vector<vector<int>>(N + 1);
    read_edges_oriented_with_reversed(reversed);

    int i;
    set_nodesInfo(0);      //nodesInfo is used as the vector for "visited"

    // kosaraju

    stack<int> nodes;
    for(i = 1 ; i <= N; i++)
    {
        if(nodesInfo[i] == 0)
            top_sort_utility(i, nodes);
    }
 
    int scc = 0;
    vector<int> aux;
    vector<vector<int>> solution;

    while(!nodes.empty())
    {
        if(nodesInfo[nodes.top()] == 1)
        {
            aux = vector<int>();
            DFS_kosaraju(nodes.top(), reversed, aux);
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


void Graph :: top_sort_utility(int curr, stack<int>& nodes)
{
    nodesInfo[curr] = 1;
    int x;
    for(int i = 0; i < edges[curr].size(); i++)
    {
        x = edges[curr][i];
        if(nodesInfo[x] == 0)
            top_sort_utility(x, nodes);
    }

    nodes.push(curr);
}

void Graph :: topological_sort()
{
    read_N();
    read_M();
    init_edges();
    read_edges_oriented();
    set_nodesInfo(0);           // nodesInfo is used as "visited"

    stack<int> nodes;

    for(int i = 1; i <= N; i++)
    {
        if(nodesInfo[i] == 0)
            top_sort_utility(i, nodes);
    }

    print_stack(nodes);
}


void Graph :: havel_hakimi()
{
    read_N();
    int i, x, j;
    for(i = 1; i <= N; i++)
    {
        f >> x;
        nodesInfo.push_back(x);
    }

    while(true)
    {
        sort(nodesInfo.begin(), nodesInfo.end());
        i = nodesInfo.size() - 1;
        if(nodesInfo[i] == 0)     // every node has degree 0 so the graph can be made
        {
            print_message("Yes.");
            break;
        }
        j = i - 1;
        while(j >= 0 && nodesInfo[i] > 0)
        {
            nodesInfo[j]--;
            nodesInfo[i]--;
            if(nodesInfo[j] < 0)
            {
                print_message("No!");
                return;
            }
            j--;
        }
        if(j == -1 && nodesInfo[i] > 0)
        {
            print_message("No!");
            break;
        }
        nodesInfo.pop_back();
    }
}


void Graph :: critical(int curr, int father, vector<vector<int>>& sol, vector<int>& upwards)
{
    int i, x;
    for(i = 0; i < edges[curr].size(); i++)
    {
        x = edges[curr][i];
        if (nodesInfo[x] == 0)
        {
            nodesInfo[x] = upwards[x] = nodesInfo[curr] + 1;
            critical(x, curr, sol, upwards);
            if(upwards[curr] > upwards[x])
                upwards[curr] = upwards[x];
        }
        else
            if(x != father && father != -1)
                if(upwards[curr] > nodesInfo[x])
                    upwards[curr] = nodesInfo[x];
    }
    if(nodesInfo[curr] == upwards[curr] && father != -1)
        sol.push_back(vector<int> {father, curr});
            
}


void Graph :: bridges()
{
    read_N();
    read_M();
    init_edges();
    read_edges();
    set_nodesInfo(0);       // nodesInfo[x] -> the level of node x in DFS tree

    vector<int> upwards = vector<int> (N);
    vector<vector<int>> sol;
    nodesInfo[0] = upwards[0] = 1;
    critical(0, -1, sol, upwards);
    
    for(int i = 0; i < sol.size(); i++)
        g << sol[i][0] << ' ' << sol[i][1] << '\n';
}


void Graph :: kruskal()
{
    read_weightedEdges();
    Disjoint_Set_Forest d(N);
    vector<pair<int, int>> solution;

    int totalCost = 0, j = 0;
    sort(weightedEdges.begin(), weightedEdges.end());
    int i;

    for(i = 1; i <= N - 1; i++)
    {
        while(!(d.represents(weightedEdges[j].second.first) != d.represents(weightedEdges[j].second.second)))
            j++;
        totalCost += weightedEdges[j].first;
        solution.push_back(weightedEdges[j].second);
 
 
        d.unite(d.represents(weightedEdges[j].second.first), d.represents(weightedEdges[j].second.second));
    }
 
    g << totalCost << '\n' << N - 1 << '\n';
    for(i = 0; i < solution.size(); i++)
        g << solution[i].first << ' ' << solution[i].second << '\n';
}


void Graph :: dijkstra(int start)
{
    read_weightedNeighbours();
    set_nodesInfo(MAX);       // nodesInfo[x] == distance to node x

    vector<int> selected = vector<int>(N + 1);
    pair<int, int> edg;
    priority_queue<pair<int,int>> pq;

    nodesInfo[start] = 0;
    pq.push(make_pair(0, start));
 
    int x, c, i;
    while(!pq.empty())
    {
        x = pq.top().second;
        c = -pq.top().first;
        pq.pop();
 
        if(selected[x] == 0)
        {
            selected[x] = 1;
 
            for(i = 0; i < weightedNeighbours[x].size(); i++)
            {
                edg = weightedNeighbours[x][i];
                if(selected[edg.second] == 0)
                {
                    if(c + edg.first < nodesInfo[edg.second])
                    {
                        nodesInfo[edg.second] = c + edg.first;
                        pq.push(make_pair(-nodesInfo[edg.second], edg.second));
                    }
                }
            }
        }
    }
 
    print_nodesInfo(2, MAX, 0);
}


void Graph :: bellman_ford()
{
    read_weightedNeighbours();
    set_nodesInfo(0);

    vector<int> distances = vector<int> (N + 1, MAX);
    distances[1] = 0;
    nodesInfo[1] = 1;       // if nodesInfo[x] is > 0, then x is currently in the Q. otherwise, it's not
    Q.push(1);              //Q contains the nodes that were recently updated and whose neighbours need updates accordingly

    int j, c, u, v;
    while(!Q.empty())
    {
        u = Q.front();
        nodesInfo[u] = -nodesInfo[u];
        Q.pop();

        for(j = 0; j < weightedNeighbours[u].size(); j++)
        {
            c = weightedNeighbours[u][j].first;
            v = weightedNeighbours[u][j].second;
            if(distances[u] + c < distances[v])
            {
                distances[v] = distances[u] + c;
                if(nodesInfo[v] <= 0)       //v is not currently in Q
                {
                    Q.push(v);
                    nodesInfo[v] = -nodesInfo[v] + 1;
                    if(nodesInfo[v] == N)           //nodesInfo[x] = how many times x was added to Q. the maximum length of a chain of vortexes is N - 1. if we have N vortexes
                                                //then we no longer have a chain (we have a cycle somewhere in it). so if we add x N times to Q, something's wrong
                    {
                        print_message("Ciclu negativ!");
                        return;
                    }
                }
            }
        }
    }

    print_array(distances, 2);
}


void Graph :: edmonds_karp()
{
    vector<vector<int>> flow;
    read_edges_flow(flow);
    set_nodesInfo(0);
    vector<int> fathers;
    set_fathers(fathers);

    int maxFlow = 0, iteration = 1, curr, i, mini = MAXCAPACITY, following;    
    while(true)
    {
        Q.push(1);
        nodesInfo[1] = iteration;
        mini = MAXCAPACITY;

        while(!Q.empty())
        {
            curr = Q.front();
            Q.pop();
            for(i = 0; i < edges[curr].size(); i++)
            {
                following = edges[curr][i];
                if(nodesInfo[following] != iteration && flow[curr][following] > 0)
                {
                    Q.push(following);
                    fathers[following] = curr;
                    nodesInfo[following] = iteration;
                    if(following == N)
                    {
                        Q = queue<int>();
                        break;
                    }
                }
            }
        }

        if(nodesInfo[N] != iteration)
            { g << maxFlow; return; }

        curr = N;
        while(curr != 1) 
        {       
            mini = min(mini, flow[fathers[curr]][curr]);
            curr = fathers[curr];
        }
        maxFlow += mini;
        curr = N;
        while(curr != 1)
        {
            flow[fathers[curr]][curr] -= mini;
            flow[curr][fathers[curr]] += mini;
            curr = fathers[curr];
        }
        
        iteration++;     
    }

}


void Graph :: graph_diameter()
{
    read_N();
    M = N - 1;
    init_edges();
    read_edges();
    set_nodesInfo(MAX);

    BFS(1);
    int maxi = 0, nod1 = 1;
    for(int i = 1; i <= N; i++)
        if(nodesInfo[i] > maxi)
        {
            maxi = nodesInfo[i];
            nod1 = i;
        }
    
    set_nodesInfo(MAX);
    BFS(nod1);

    maxi = 0;
    for(int i = 1; i <= N; i++)
        if(nodesInfo[i] > maxi)
        {
            maxi = nodesInfo[i];
            nod1 = i;
        }

    g << maxi + 1;
}


void Graph :: roy_floyd()
{
    read_N();
    init_edges();
    read_edges_matrix();

    int i, j, k;
    for(k = 1; k <= N; k++)
        for(i = 1; i <= N; i++)
        {
            if(i == k) continue;
            for(j = 1; j <= N; j++)
                edges[i][j] = min(edges[i][j], edges[i][k] + edges[k][j]);
        }

    for(i = 1; i <= N; i++)
    {
        for(j = 1; j <= N; j++)
            if(edges[i][j] == MAX)
                g << "0 ";
            else
                g << edges[i][j] << ' ';
        g << '\n';
    }
}


void BFS_infoarena(Graph gr)
{
    gr.read_N();
    gr.read_M();

    int start;
    f >> start;

    gr.set_nodesInfo(MAX);
    gr.init_edges();
    gr.read_edges_oriented();


    gr.BFS(start);
    
    gr.print_nodesInfo(1, MAX, -1);

}


void DFS_infoarena(Graph gr)
{
    gr.read_N();
    gr.read_M();

    gr.set_nodesInfo(0);
    gr.init_edges();
    gr.read_edges();

    int conexElements = 0;
    for(int i = 1; i <= gr.get_N(); i++)
    {
        if (gr.get_node_info(i) == 0)
        {
            gr.set_node_info(i, 1);
            conexElements ++;
            gr.DFS(i);
        }
    }
    g << conexElements;
}


void disjoint_infoarena()
{
    int N, M;
    f >> N >> M;
    Disjoint_Set_Forest d(N);

    int i, op, x, y;
    for(i = 1; i <= M; i++)
    {
        f >> op >> x >> y;
        if(op == 1)
        {
            d.unite(d.represents(x), d.represents(y));
        }
        else
            if(d.represents(x) == d.represents(y))
                g << "DA\n";
            else
                g << "NU\n";
    }
}


int main()
{
    Graph gr;
    DFS_infoarena(gr);
    return 0;
}