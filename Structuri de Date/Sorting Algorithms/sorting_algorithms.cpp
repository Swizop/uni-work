/*
11
100 100000000000
58552019 26480774 
100000000  100
*/
#include <iostream>
#include <algorithm>
#include <ctime>
#include <fstream>
#include <chrono>
#include <random>

using namespace std;
using namespace std::chrono;

long long N, Maxi;
int t, Tests;
std::mt19937 generator(time(NULL));

void mergesort(long long*, int, int);   //Classic merge sort. O(n logn)
void IPmergesort(long long*, int, int);   //In-place merge sort. O(n^2) because shifting all elements to the right is o(n^2)
void bubble(long long*);    //bubble sort. O(n^2)
void radix(long long*);     //radix sort. O(n * log Maxi)
void count_sort(long long*);    //count sort. O(n + Maxi)
void shells(long long*);        //shell sort. O(n * n)
void shell(long long*);         //shell sort. O(n sqrt(n))

void gen(int g, long long* p)
{
    int val, i;
    val = generator() % Maxi + 1;
    switch(g){
        case 1:                         //all values of array are equal
            cout<<"Vector egal. ";
            for(i = 0; i < N; i++)
                p[i] = val;
            break;
        case 2:                         //sorted in ascending order
            cout<<"Vector crescator. ";
            p[0] = val;
            for(i = 1; i < N; i++)
                p[i] = min(p[i-1] + 1, Maxi);
            break;
        case 3:                         //sorted in descending order
            cout<<"Vector descrescator. ";
            p[0] = val;
            for(i = 1; i < N; i++)
                p[i] = max(p[i-1] - 1, (long long) 0);
            break;
        case 4:                         //pseudo-random values
            cout<<"Vector random. ";
            for(i = 0; i < N; i++)
                p[i] = rand() % Maxi + 1;
            break;
    }
}


void init_copy(long long* p, long long* pcopy)
{
    for(int i = 0; i < N; i++)
        pcopy[i] = p[i];
}


void write_array(long long* p)
{
    for(int i = 0; i < N; i++)
        cout<<p[i]<<" ";
    cout<<endl;
}


bool is_sorted(long long *p)
{
    for(int i=1; i < N ; i++)
        if (p[i] < p[i-1])
            return false;
    return true;
}
int main()
{
    ifstream f("input.txt");
    int g, i;
    long long* p;
    long long* pcopy;
    f>>Tests;

    for (t = 1; t <= Tests; t++)
    {
        f>>N>>Maxi;                     //generate array
        p = new long long[N];        
        srand(time(0));
        g = rand() % 4 + 1; 
        cout<<"N = "<<N<<" Maxi = "<<Maxi<<endl;
        gen(g, p);
        cout<<"First value in generated array: "<<p[0]<<endl;
        //write_array(p);
        
        pcopy = new long long[N];
       
        init_copy(p, pcopy);            //C++ STL sort function
        auto inceput = high_resolution_clock::now();
        sort(pcopy, pcopy+N);
        auto final = high_resolution_clock::now();
        double elapsed_time = duration<double, std::milli>(final-inceput).count(); //https://stackoverflow.com/questions/728068/how-to-calculate-a-time-difference-in-c
        //write_array(pcopy)
        if(is_sorted(pcopy))
            cout<<"Sortare corecta."<<endl<<"Pentru sortarea din <algorithm>, a durat: "<<elapsed_time<<" millisecunde."<<endl;
        else
            cout<<"Sortare incorecta!"<<endl;


        init_copy(p, pcopy);            //simple merge sort
        inceput = high_resolution_clock::now();
        mergesort(pcopy, 0, N-1);
        final = high_resolution_clock::now();
        elapsed_time = duration<double, std::milli>(final-inceput).count(); //https://stackoverflow.com/questions/728068/how-to-calculate-a-time-difference-in-c
        //write_array(pcopy)
        if(is_sorted(pcopy))
            cout<<"Sortare corecta."<<endl<<"Pentru simple merge sort, a durat: "<<elapsed_time<<" millisecunde."<<endl;
        else
            cout<<"Sortare incorecta!"<<endl;


        init_copy(p, pcopy);            //in-place merge sort
        inceput = high_resolution_clock::now();
        IPmergesort(pcopy, 0, N-1);
        final = high_resolution_clock::now();
        elapsed_time = duration<double, std::milli>(final-inceput).count(); //https://stackoverflow.com/questions/728068/how-to-calculate-a-time-difference-in-c
        //write_array(pcopy)
        if(is_sorted(pcopy))
            cout<<"Sortare corecta."<<endl<<"Pentru in-place merge sort, a durat: "<<elapsed_time<<" millisecunde."<<endl;
        else
            cout<<"Sortare incorecta!"<<endl;
        

        init_copy(p, pcopy);            //bubble sort
        inceput = high_resolution_clock::now();
        bubble(pcopy);
        final = high_resolution_clock::now();
        elapsed_time = duration<double, std::milli>(final-inceput).count(); //https://stackoverflow.com/questions/728068/how-to-calculate-a-time-difference-in-c
        //write_array(pcopy);
        if(is_sorted(pcopy))
            cout<<"Sortare corecta."<<endl<<"Pentru bubble sort, a durat: "<<elapsed_time<<" millisecunde."<<endl;
        else
            cout<<"Sortare incorecta!"<<endl;
        

        init_copy(p, pcopy);            //radix sort
        inceput = high_resolution_clock::now();
        radix(pcopy);
        final = high_resolution_clock::now();
        elapsed_time = duration<double, std::milli>(final-inceput).count(); //https://stackoverflow.com/questions/728068/how-to-calculate-a-time-difference-in-c
        //write_array(pcopy);
        if(is_sorted(pcopy))
            cout<<"Sortare corecta."<<endl<<"Pentru radix sort, a durat: "<<elapsed_time<<" millisecunde."<<endl;
        else
            cout<<"Sortare incorecta!"<<endl;


        init_copy(p, pcopy);            //count sort
        inceput = high_resolution_clock::now();
        count_sort(pcopy);
        final = high_resolution_clock::now();
        elapsed_time = duration<double, std::milli>(final-inceput).count(); //https://stackoverflow.com/questions/728068/how-to-calculate-a-time-difference-in-c
        //write_array(pcopy);
        if(is_sorted(pcopy))
            cout<<"Sortare corecta."<<endl<<"Pentru count sort, a durat: "<<elapsed_time<<" millisecunde."<<endl;
        else
            cout<<"Sortare incorecta!"<<endl;


        init_copy(p, pcopy);            //shell sort with gap N / (2 ^ k)
        inceput = high_resolution_clock::now();
        shells(pcopy);
        final = high_resolution_clock::now();
        elapsed_time = duration<double, std::milli>(final-inceput).count(); //https://stackoverflow.com/questions/728068/how-to-calculate-a-time-difference-in-c
        //write_array(pcopy);
        if(is_sorted(pcopy))
            cout<<"Sortare corecta."<<endl<<"Pentru shell sort cu gap-ul N / (2 ^ k), a durat: "<<elapsed_time<<" millisecunde."<<endl;
        else
            cout<<"Sortare incorecta!"<<endl;


        init_copy(p, pcopy);            //shell sort with gap (3 ^ k - 1) / 2
        inceput = high_resolution_clock::now();
        shell(pcopy);
        final = high_resolution_clock::now();
        elapsed_time = duration<double, std::milli>(final-inceput).count(); //https://stackoverflow.com/questions/728068/how-to-calculate-a-time-difference-in-c
        //write_array(pcopy);
        if(is_sorted(pcopy))
            cout<<"Sortare corecta."<<endl<<"Pentru shell sort cu gap-ul (3 ^ k - 1) / 2, a durat: "<<elapsed_time<<" millisecunde."<<endl;
        else
            cout<<"Sortare incorecta!"<<endl;    

        cout<<endl;
        delete[] p;
    }

    return 0;
}


void mergesort(long long *p, int l, int r)
{
    if(l < r)
    {
        int m = l + (r-l) / 2;
        mergesort(p, l, m);
        mergesort(p, m+1, r);
        int i = l, j = m+1;
        vector<long long> aux;
        while(i <= m && j <= r)
            if(p[i] < p[j])
            {
                aux.push_back(p[i]);
                i++;
            }
            else
             {
                aux.push_back(p[j]);
                j++;
            }
        while(i <= m)
        {
            aux.push_back(p[i]);
            i++;
        }
        while(j <= r)
        {
            aux.push_back(p[i]);
            i++;
        }
        int k = l;
        m = 0;
        while(k <= r)
        {
            p[k] = aux[m];
            k++;
            m++;
        }
    }
}


void IPmergesort(long long* p, int l, int r)
{
    if(l < r)
    {
        int m = l + (r - l) / 2; // avoids overflow by not calculating l + r
        IPmergesort(p, l, m);
        IPmergesort(p, m+1, r);
        
        //in-place merge the 2 sorted arrays
        if(p[m] <= p[m+1])   //array is already sorted
            return;
        int j = m+1, i, aux;
        while(l<=m && j<= r)
        {
            if(p[l] > p[j])
            {
                aux = p[j];
                for(i = j; i > l; i--)
                    p[i] = p[i-1];
                p[l] = aux;
                l++;
                m++;
                j++;
            }
            else
                l++;
        }
    }
}


void bubble(long long *p)
{
    bool is_sorted = false;
    int j = N - 1, i;
    while(is_sorted == false && j >= 1)
    {
        is_sorted = true;
        for(i = 0; i < j; i++)
            if (p[i]> p[i+1])
            {
                swap(p[i], p[i+1]);
                is_sorted = false;
            }
        j--;
    }
}


void radix(long long *p)
{
    int i, maxi = p[0], k = 1, fr0, fr1;
    long long *r = new long long[N];
    for(i = 1; i < N; i++)
        if(p[i] > maxi)
            maxi = p[i];
    while(k <= maxi)
    {
        fr0 = fr1 = 0;
        for(i = 0; i < N; i++)
            if(!(p[i] & k))
                fr0++;
        fr1 = N-1;
        fr0--; 
        for(i = N - 1; i >=0; i--)
            if(p[i] & k)
            {
                r[fr1] = p[i];
                fr1--;
            }
            else
                r[fr0--] = p[i];
        for(i = 0; i < N; i++)
            p[i] = r[i];
        k<<=1;
    }
}


void count_sort(long long* p)
{
    long long* fr = new long long[Maxi];
    int i, j, k = 0;
    for(i = 0; i < N; i++)
        fr[p[i]]++;
    for(i = 0; i <= Maxi; i++)
        while(fr[i])
        {
            p[k++] = i;
            fr[i]--;
        }
}


void shell(long long *p)
{
    int k = 0, i, j;
    while (k < N)
        k = k * 3 + 1;
    k = k / 3;
    while (k > 0)
    {
        for(i = k; i < N; i ++)
            for(j = i; j >= k && p[j] < p[j - k] ; j-=k)
                swap(p[j], p[j-k]);
        k = k / 3;
    }
}


void shells(long long *p)
{
    int k = 0, i, j;
    for(k = N / 2; k > 0 ; k = k / 2)
    {
        for(i = k; i < N; i += 1)
        {
            for(j = i; j >= k && p[j] < p[j - k] ; j-=k)
                swap(p[j], p[j-k]);
        }
    }
}
