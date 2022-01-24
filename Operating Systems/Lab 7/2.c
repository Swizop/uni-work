#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define SIZE 5
#define SIZE2 5

int mat1[SIZE][SIZE] = {
    {1,3,5,7,0},
    {1,3,5,7,0},
    {1,3,5,7,1},
    {1,3,5,7,1},
    {2,3,5,7,0}
};

int mat2[SIZE][SIZE2] = {
    {1,0,0,0,0},
    {0,1,0,0,0},
    {0,0,1,0,0},
    {0,0,0,1,0},
    {0,0,0,0,1}
};

int result[SIZE][SIZE2];

struct pos {
    int i, j;
};


void* prod(void* pos_void) {
    struct pos* index = (struct pos*) pos_void;
    result[index->i][index->j] = 0;
    for(int k = 0; k < SIZE; k++)
    {
        result[index->i][index->j] += mat1[index->i][k] * mat2[k][index->j];
    }
    return NULL;
}

int main()
{
    pthread_t *threads = malloc(sizeof(pthread_t) * SIZE * SIZE2);
    for(int i = 0; i < SIZE; i++)
        for(int j = 0; j < SIZE2; j++)
        {
            struct pos* index = malloc(sizeof(struct pos));
            index->i = i;
            index->j = j;
            pthread_create(threads + (i * SIZE2 + j), NULL, prod, index);
        }

    for(int i = 0; i < SIZE * SIZE2; i++)
    {
        pthread_join(threads[i], NULL);
    }

    for(int i = 0; i < SIZE; i++) {
        for(int j = 0 ; j < SIZE2; j++)
            printf("%d ", result[i][j]);
        printf("\n");
    }
    return 0;
}
