#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <errno.h>

int main(int argc, char *argv[])
{
    if(argc < 2)
    {
        return -1;
    }

    printf("Starting parent %d\n", getpid());
    int i = 1;
    int x;

    char name[] = "shm1";
    int descriptor;

    descriptor = shm_open(name, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);

    if(descriptor < 0)
    {
        perror(NULL);
        return errno;
    }

    size_t shm_size = getpagesize() * (argc - 1);
    if(ftruncate(descriptor, shm_size) == -1)
    {
        perror(NULL);
        shm_unlink(name);
        return errno;
    }

    int *shm_ptr;
    shm_ptr = (int*) mmap(0, shm_size, PROT_READ | PROT_WRITE, MAP_SHARED, descriptor, 0);

    if(shm_ptr == MAP_FAILED)
    {
        perror(NULL);
        shm_unlink(name);
        return errno;
    }

    int j;
    for(i = 1; i < argc; i++)
    {
        pid_t p = fork();
        if(p == 0)
        {
            int *shmchild_ptr = (int*) mmap(0, getpagesize(), PROT_WRITE,
             MAP_SHARED, descriptor, (i - 1) * getpagesize());
            if(shmchild_ptr == MAP_FAILED)
            {
                perror(NULL);
                shm_unlink(name);
                return errno;
            }
            x = atoi(argv[i]);
            i += 1;
            j = 0;
            while(x != 1)
            {
                shmchild_ptr[j] = x;
                j += 1;
                if(x % 2 == 0)
                    x = x / 2;
                else
                    x = 3 * x + 1;
            }
            shmchild_ptr[j] = 1;
            printf("Done parent %d me %d\n", getppid(), getpid());
            munmap(shmchild_ptr, getpagesize());
            return 0;
        }
        else if(p < 0)
            return -1;
    }
    wait(NULL);


    int* i_ptr;
    for(i = 1; i < argc; i++)
    {
        i_ptr = (void*) shm_ptr + (i - 1) * (getpagesize());
        j = 0;
        printf("%d: ", i_ptr[j]);
        while(i_ptr[j] != 1)
        {
            printf("%d ", i_ptr[j]);
            j += 1;
        }
        printf("%d\n", 1);
    }

    printf("Done parent %d ME %d\n", getppid(), getpid());
    shm_unlink(name);
    munmap(shm_ptr, shm_size);
    return 0;
}
