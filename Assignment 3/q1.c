#include <stdlib.h>
#include <stdio.h>

// YOU: Allocate these global variables, using these names
int  i,j;
int* p;
int  a[10];

int main (int argv, char** argc) {
  // Ignore this block of code
  if (argv != 11) {
    fprintf (stderr, "usage: a[0] ... a[9]\n");
    exit (EXIT_FAILURE);
  }
  for (int k=0; k<10; k++)
    a[k] = atol (argc[1 + k]);

  // YOU: Implement this code
  i  = a[3];
  i  = a[i];
  p  = &j;
  *p = 4;
  p  = &a[a[2]];
  *p = *p + a[4];

  // Ignore this block of code
  printf ("i=%d j=%d a={", i, j, p);
  for (int k=0; k<10; k++)
    printf("%d%s ", a[k], k<9? ",": "}\n");
}