#include <stdio.h>
#include <unistd.h>
#include <string.h>

int main()
{
    char* hello = "hello world!\n";
    write(1, hello, strlen(hello));
    return 0;
}
