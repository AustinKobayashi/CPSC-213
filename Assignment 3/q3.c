#include <stdlib.h>
#include <stdio.h>

// YOU: Allocate these global variables, using these names
int i;
int a[10];

int main (int argv, char** argc) {

    for(int n = 0; n < 10; n++)
        a[n] = n;
    
    
    printf("%d\n", *(a+3));     //3
    
    i = (int)(&a[7] - &a[2]);   //5
    printf("%i\n", i);
    
    printf("%i\n", *(a + (&a[7] - a+2)));   //9


}
