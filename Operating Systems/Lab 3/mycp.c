#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#define S_IRWXU 0000700
int main(int argc, char **argv)
{
    if (argc != 3) return 0;
    int x = open(argv[1], O_RDONLY);
    if(x < 0){
        printf("fara fisier sursa");
        return 0;}
    char st[2000];
    int y = read(x, st, 2000); //sau iau dimensiunea fisierului
            //ca in exemplul de la laborator, in loc de 2000
    write(open(argv[2], O_WRONLY | O_CREAT | O_TRUNC), st, y);
//O_trunc ->mai intai truncheaza fisierul apoi scrie
    return 0;
}
