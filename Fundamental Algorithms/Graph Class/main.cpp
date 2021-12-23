#include <iostream>
#include <fstream>
#include <vector>
#include <utility>
#include <string>
#include <queue>
#include <stack>

#define MAX 1000000000
#define MAXCAPACITY 200000
using namespace std;

ifstream f("file.in");
ofstream g("file.out");


class Graph
{
    int N, M;

    vector<int> nodesInfo;
    queue<int> Q;
    vector<pair<int, pair<int, int>>> weightedEdges;            //first -> edge cost, second -> nodes in edge
    vector<vector<pair<int, int>>> weightedNeighbours;          // first -> edge weight ; second -> 2nd node in edge
    vector<vector<int>> edges;

    vector<int> distances;

    public:
        Graph() = default;

        void set_unoriented_edge(int, int);
        void set_oriented_edge(int, int);

        void init_edges();

        void set_nodesInfo(int);
        void set_distances();
        void set_fathers(vector<int>&);

        void read_N();
        void read_M();

        void read_edges();      // use when edges are given in the form of adjacency list
        void read_edges_matrix();       // edges are given in the form of adjacency matrix
        void read_weightedEdges();
        void read_weightedNeighbours();
        void read_edges_flow(vector<vector<int>>&);

        void print_message(string);
        void print_solution(vector<int>, int);

        void BFS(int);
        void bellman_ford();
        void edmonds_karp();
        void graph_diameter();
        void roy_floyd();
        void euler_cycle();
};


void Graph :: init_edges() { edges = vector<vector<int>> (N + 1);}
void Graph :: set_nodesInfo(int value) { nodesInfo = vector<int> (N + 1, value); }
void Graph :: set_distances() { distances = vector<int> (N + 1, MAX); }
void Graph :: set_fathers(vector<int>& fathers) { fathers = vector<int> (N + 1);}


void Graph :: set_unoriented_edge(int x, int y) { edges[x].push_back(y); edges[y].push_back(x); }
void Graph :: set_oriented_edge(int x, int y) { edges[x].push_back(y); }


void Graph :: read_N() { f >> N; }
void Graph :: read_M() { f >> M; }


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


void Graph :: read_weightedEdges()
{
    f >> N >> M;

    int i, x, y, c;
    for(i = 1; i <= M; i++)
    {
        f >> x >> y >> c;
        weightedEdges.push_back(make_pair(c, make_pair(x, y)));
    }
}


void Graph :: read_weightedNeighbours()
{
    f >> N >> M;
    weightedNeighbours = vector<vector<pair<int, int>>> (N + 1);

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


void Graph :: print_solution(vector<int> solution, int start)
{
    for(int i = start; i < solution.size(); i ++)
    {
        g << solution[i] << ' ';
    }
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


void Graph :: bellman_ford()
{
    read_weightedNeighbours();
    set_distances();
    set_nodesInfo(0);

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

    print_solution(distances, 2);
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


void Graph :: euler_cycle()
{
    read_N();
    read_M();

    init_edges();

    int i, x, y, curr;
    vector<pair<int, int>> multigraphEdges = vector<pair<int, int>> (M + 1);
    vector<int> isEdgeVisited = vector<int> (M + 1);

    set_nodesInfo(0);           //nodesInfo will store the degree of each node

    for(i = 1; i <= M; i++)
    {
        f >> x >> y;
        multigraphEdges[i] = make_pair(x, y);
        set_oriented_edge(x, i);
        set_oriented_edge(y, i);

        nodesInfo[x]++;
        nodesInfo[y]++;
    }

    for(i = 1; i <= N; i++)
        if(nodesInfo[i] % 2 != 0)
        {
            g << -1;
            return;
        }
    
    int e, start = 1;                  //nodes can have degree 0 in an eulerian graph, we don't want to start from one
    while(nodesInfo[start] == 0)
        start++;
    
    stack<int> dfsStack, solution;
    dfsStack.push(start);

    while(!dfsStack.empty())
    {
        curr = dfsStack.top();
        // if(nodesInfo[curr] == 0)
        // {
            solution.push(curr);
            dfsStack.pop();
            nodesInfo[curr] = 0;
        // }
        // else
        // {
            for(i = 0; i < edges[curr].size(); i++)
            {
                e = edges[curr][i];
                if(isEdgeVisited[e] == 0)
                {
                    isEdgeVisited[e] = 1;
                    // nodesInfo[multigraphEdges[e].first]--;
                    // nodesInfo[multigraphEdges[e].second]--;
                    if(multigraphEdges[e].first != curr)
                        dfsStack.push(multigraphEdges[e].first);
                    else
                        dfsStack.push(multigraphEdges[e].second);
                }
            }
        //}
    }

    for(i = 1; i <= N; i++)
        if(nodesInfo[i] > 0)
        {
            g << -1;
            return;
        }

    while(!solution.empty())
    {
        g << solution.top() << ' ';
        solution.pop();
    }
}


int main()
{
    Graph gr;
    gr.euler_cycle();
    return 0;
}