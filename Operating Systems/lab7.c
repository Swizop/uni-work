#include <stdio.h>
#include <pthread.h>
#include <string.h>

void* f(void *s)
{
    char* q = (char*) s;
    int i = 0, j = strlen(q) - 1;
    char aux;
    while(i < j)
    {
        aux = q[i];
        q[i] = q[j];
        q[j] = aux;
        i++;
        j--;
    }
    return (void*) q;
}
int main(int argc, char *argv[])
{
    char *s = argv[1];
    void* rez;
    pthread_t thr;
    pthread_create(&thr, NULL, f, s);
    pthread_join(thr, &rez);
    printf("%s\n", (char*) rez);
    return 0;
}