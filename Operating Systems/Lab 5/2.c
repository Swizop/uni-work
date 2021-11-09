#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    if(argc != 2)
    {
        return -1;
    }
    
    int x = atoi(argv[1]);
    
    pid_t p = fork();
    if(p > 0)
    {
        wait(NULL);
        printf("Child %d finished\n", p);
    }
    else if(p == 0)
    {
        printf("%d: ", x);
        while(x != 1)
        {
            printf("%d ", x);
            if(x % 2 == 0)
                x = x / 2;
            else
                x = 3 * x + 1;
        }
        printf("1\n");
    }
    else
        return -1;
    return 0;
}