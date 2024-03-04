#include <stdio.h>
#include <stdlib.h>

int PGCD(int a, int b){
    int r,c;
    c = a * b;
    r = a % b;
    while(r != 0)
    {
        a = b;
        b = r;
        r = a%b;
    }
    return b;
}

int main()
{
    printf("Hello world!\n");
    int a,b;
    printf("entrer un entier : \t");
    scanf("%d",&a);
    printf("entrer un entier : \t");
    scanf("%d",&b);
    printf("%d",PGCD(a,b));
}
