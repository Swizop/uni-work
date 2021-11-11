#include <iostream>
#include <fstream>
#include <stack>
#include <string>
#include <cstdlib>

using namespace std;

ifstream f("queue.in");
ofstream g("queue.out");

int n, j, k, p;
string in;

int main()
{
    f >> n;
    getline(f, in);
    stack<int> s1, s2;
    char numar[10];
    int i;
    for(i = 1; i <= n; i++)
    {
        getline(f, in);
        if(in[1] == 'u')    //push
        {
            j = 10;
            k = 0;
            while(isdigit(in[j]))
            {
                numar[k] = in[j];
                k++;
                j++;
            }
            numar[k]='\0';
            g << i << ": read(" << numar << ") push(1," << numar <<")\n";
            s1.push(atoi(numar));
        }
        else                //pop
        {
            if(!s2.empty())
            {
                g << i << ": pop(2) write(" << s2.top() << ")\n";
                s2.pop();
            }
            else
            {
                g << i << ": ";
                while(!s1.empty())
                {
                    p = s1.top();
                    g << "pop(1) push(2," << p << ") ";
                    s2.push(p);
                    s1.pop();
                }
                g << "pop(2) write(" << s2.top() <<")\n";
                s2.pop();
            }
        }
    }
    return 0;
}