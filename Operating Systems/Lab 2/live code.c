#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void ch(int* p)
{
    *p = *p *2;
}

struct bo {
    int x;
    int y;
};

int main()
{
    //LAB CODE
    /* PARTEA 1
    int x, *a, b, *c;
    x = 23;
    a = &x;
    b = *a;
    c = a;
    printf("%d %d %d\n", x,*a, *c);
    printf("%x %x %x %x %x\n", &x,&a, &b, &c, a, c);
    */
    
    /*
    int *p, x;
    p = (int*) malloc(sizeof(int));        //malloc returns void*
    //scanf("%d", &x); //in mod normal, trb adresa variabilei, dar p e
    //                    //deja o adresa
                        
    scanf("%d", p);
    ch(p); ch(&x);
    printf("%d\n", *p);
    */
    
    /* PARTEA 3
    int x[3], *p;
    x[0] = 1; x[1] = 7; x[2] = 5;
    p = &(x[0]);
    printf("%d\n", *p);
    p = p + 1;   // x[1]
    printf("%d\n", *p);
    p = p + 100;    //segm fault
    */
    
    /*
    struct bo a, *p;        //trb neaparat sa pui si bo
    p = &a;
    (*p).x = 7;
    p->y = 2;
    printf("%d %d\n", p->x, p->y);
    */
    
    /*
    char h[10] = "sirul";
    h[9] = 'a';
    printf("%s\n", h);
    int i;
    for(i = 0; i < 10; i++)
        printf("%d\n", h[i]);
    */
    return 0;
}