#include <stdlib.h>
#include <stdio.h>

int* val;

void sort (int n) {
    int t;
    
    for (int i=n-1; i>0; i--){
        int *ipointer = val + i * sizeof(int);
        for (int j=i-1; j>=0; j--){
            int*jpointer = val + j * sizeof(int);
            if (*ipointer < *jpointer) {
                t = *ipointer;
                *ipointer = *jpointer;
                *jpointer = t;
            }
        }
    }
}

int main (int argc, char** argv) {
    char* ep;
    int   n;
    n = argc - 1;
    val = malloc (n*sizeof(int));
    
    for (int i=0; i<n; i++) {
        int *pointer = val + i * sizeof(int);
        *pointer = strtol (*(argv + (i+1)*sizeof(char)), &ep, 10);
        if (*ep) {
            fprintf (stderr, "Argument %d is not a number\n", i);
            return -1;
        }
    }
    
    sort (n);
    for (int i=0; i<n; i++){
        int *pointer = val + i*sizeof(int);
        printf ("%d\n", *pointer);
    }
}
