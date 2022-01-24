#include <stdio.h>
#include <pthread.h>
#include <errno.h>
#include <time.h>
#include <string.h>
#define MAX_RESOURCES 5

int available_resources = MAX_RESOURCES;
pthread_mutex_t mtx;


int increase_count(int count)
{
    pthread_mutex_lock(&mtx);
    available_resources += count;
    pthread_mutex_unlock(&mtx);
    printf("Released %d resources %d remaining\n", count, available_resources);
    return 0;
}


int decrease_count(int count)
{
    pthread_mutex_lock(&mtx);
    if(available_resources < count) {
        pthread_mutex_unlock(&mtx);
        return -1;
    }
    available_resources -= count;
    pthread_mutex_unlock(&mtx);
    printf("Got %d resources %d remaining\n", count, available_resources);
    return 0;
}

void* f()
{
    int c = rand() % MAX_RESOURCES + 1;
    if(decrease_count(c) != -1)
        increase_count(c);
    return NULL;
}

int main()
{
    srand(time(0));
    if(pthread_mutex_init(&mtx, NULL)) {
        perror(NULL);
        return errno;
    }
    printf("MAX_RESOURCES=%d\n", available_resources);
    
    
    pthread_t thr[5];
    for(int i = 0 ; i < 5; i++)
    {
        pthread_create(&thr[i], NULL, f, NULL);
    }
    for(int i = 0 ; i < 5; i++)
    {
        pthread_join(thr[i], NULL);
    }
    pthread_mutex_destroy(&mtx);
    return 0;
}