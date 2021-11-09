#include <stdio.h>
#include <unistd.h>

int main()
{
    pid_t p = fork();
    if(p > 0)
    {
        wait(NULL);
        printf("Child %d finished\n", p);
    }
    else if(p == 0)
    {
        printf("MY PID=%d ", getppid());
        printf("Child PID=%d\n", getpid());
        char *argv[] = {"ls", NULL};
        execve("/bin/ls", argv, NULL);
        perror(NULL);
    }
    else
        return -1;
    return 0;
}