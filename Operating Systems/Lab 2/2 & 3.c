/******************************************************************************

                            Online C Compiler.
                Code, Compile, Run and Debug C program online.
Write your code in this editor and press "Run" button to compile and execute it.

*******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//EXERCITIUL 2
int count_occurrences(const char* text, const char* word)
{
    int p1 = 0, p2 = 0, occ = 0;
    while(text[p1] != 0)
    {
        if(text[p1] == word[p2])
        {
            p2 = p2 + 1;
            if(word[p2] == 0)
            {
                occ = occ + 1;
                p2 = 0;
            }
        }
        else
        {
            p2 = 0;
            if(text[p1] == word[p2]) //case when word == aab, str = ab
            {
                p2 = p2 + 1;
                if(word[p2] == 0)
                {
                    occ = occ + 1;
                    p2 = 0;
                }
            }
        }
        p1 ++;
    }
    return occ;
}


//EXERCITIUL 3
char* f(char* text)
{
    char cuv1[200], cuv2[200];
    char* aux;
    aux = (char*) malloc(sizeof(char) * strlen(text));      //auxiliary string, same size as text

    fgets(cuv1, 200, stdin);
    fgets(cuv2, 200, stdin);
    cuv1[strlen(cuv1) - 1] = cuv2[strlen(cuv2) - 1] = 0;
    int i = 0;
    while(text[i] != 0)
    {
        //printf("%d %d \n", count_occurrences((const char*) (text + i), cuv1), count_occurrences((const char*) (text + i + 1), cuv1));
        //printf("%s%s", text + i, text + i + 1);
        if(count_occurrences(text + i, cuv1) != count_occurrences(text + i + 1, cuv1))  //text[i] e inceputul unei aparitii a cuv1
        {
            strcpy(aux, cuv2);
            strcpy(text + i, strcat(aux, text + i + strlen(cuv1)));
            i = i + strlen(cuv2) - 1;
        }
        i++;
    }
    return text;
}

int main()
{ //EXERCITIUL 2
    // printf("%d\n", count_occurrences("abcskdnakabsldkaab", "ab"));
    //return 0;

    //EXERCITIUL 3
    char* text;
    int n;
    printf("Nr. maxim de caractere din text: ");
    scanf("%d", &n);
    printf("\nTextul: ");
    text = (char*) malloc(sizeof(char) * n);
    fgets(text, n, stdin);
    fgets(text, n, stdin);
    text[strlen(text) - 1] = 0;
    //printf("\n%s\n", text);
    printf("%s", f(text));
    return 0;
}

