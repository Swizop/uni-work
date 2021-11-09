#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    if(argc < 2)
    {
        return -1;
    }
    
    printf("Starting parent %d\n", getpid());
    int i = 1;
    int x;
    
    for(i = 1; i < argc; i++)
    {
        pid_t p = fork();
        
        //for(i = 1; i < argc; i++)
            //p = fork();
        
        //if(p > 0)
        //{
            //wait(NULL);
            //printf("Done parent %d ME %d\n", getppid(), getpid());
        //}
        if(p == 0)
        {
            x = atoi(argv[i]);
            i += 1;
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
            printf("Done parent %d me %d\n", getppid(), getpid());
            return 0;
        }
        else if(p < 0)
            return -1;
    }
    wait(NULL);
    printf("Done parent %d ME %d\n", getppid(), getpid());
    return 0;
}