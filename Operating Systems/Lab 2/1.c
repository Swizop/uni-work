/* Se  citesc    de la  tastură   un număr    natural    n ce  reprezintă dimensiunea unei   matrice pătratice ṣielementele unei   matrice pătratice. 
Folosind pointeri, să  se  afiṣeze elementele matricei,elementul de la  intersecţia diagonalelor (pentru n impar), iar  apoi  elementele de pe cele   
două diagonale. */

/******************************************************************************

                            Online C Compiler.
                Code, Compile, Run and Debug C program online.
Write your code in this editor and press "Run" button to compile and execute it.

*******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
    //EXERCITIUL 1
    int n, *p, i, *inceput, j;
    scanf("%d", &n);
    int **a;
    a = (int**) malloc(sizeof(int*) * n);
    for(i = 0; i < n; i++)
    {
        a[i] = (int*) malloc(n * sizeof(int));
    }
    
    for(i = 0; i < n; i++)
    {
        //p = &(*q[0]);
        for(j= 0 ;j < n; j++)
        {
            scanf("%d", (*(a + i) + j));
        }
    }
    for(i = 0; i < n; i++)
    {
        //p = &(*q[0]);
        for(j= 0 ;j < n; j++)
        {
            printf("%d ", *((*(a + i) + j)));
        }
        printf("\n");
    }
    
    if(n % 2 != 0)
        printf("Elem de la mij: %d\n", *((*(a + n / 2) + n / 2)));
    
    printf("Diag principala: ");
    for(i = 0; i < n; i++)
    {
            printf("%d ", *((*(a + i) + i)));
    }
    
    printf("\nDiag secundara: ");
    for(i = 0; i < n; i++)
    {
            printf("%d ", *((*(a + i) + n - i - 1)));
    }
    printf("\n");
    
    return 0;
}