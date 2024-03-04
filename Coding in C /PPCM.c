#include <stdio.h>
#include <stdlib.h>

int PGCD(int a, int b){
    int r,c;
    c = a * b;
    r = a % b;
    while(r != 0){
        a = b;
        b = r;
        r = a%b;
    }
    return b;
}


int PPCM(int a,int b){
    int c,ppcm;
    c = a * b;
    ppcm = c/(PGCD(a,b));
    return ppcm;
}


int main(){
    printf("Hello world!\n");
    int a,b;
    printf("la valeur de A doit etre supperieur a B\n");
        printf("entrer un entier : \t");
        scanf("%d",&a);
        printf("entrer un entier : \t");
        scanf("%d",&b);
    while(a<b){
        printf("entrer un entier : \t");
        scanf("%d",&a);
        printf("entrer un entier : \t");
        scanf("%d",&b);
    }
    printf("le PPCM est : %d",PPCM(a,b));
    return 0;
}
