#include <stdlib.h>
#include <stdio.h>

// YOU: Allocate these global variables, using these names
int  a[3];
int  s[5];
int  tos;
int  tmp;

int main (int argv, char** argc) {
  // Ignore this block of code
  if (argv != 4) {
    fprintf (stderr, "usage: a b c\n");
    exit (EXIT_FAILURE);
  }
  for (int k=0; k<3; k++)
    a[k] = atol (argc[1 + k]);
  for (int k=0; k<5; k++) s[k] = 0;

  // YOU: Implement this code
  tmp = 0;
  tos = 0;
  s[tos] = a[0];
  tos++;
  s[tos] = a[1];
  tos++;
  s[tos] = a[2];
  tos++;
  tos--;
  tmp = s[tos];
  tos--;
  tmp = tmp + s[tos];
  tos--;
  tmp = tmp + s[tos];

  // Ignore this block of code
  printf ("a[0]=%d a[1]=%d a[2]=%d\n", a[0],a[1],a[2]);
  printf ("tos=%d tmp=%d \n", tos, tmp);
  for (int k=0; k<5; k++)
    printf("s[%d]=%d, ",k,s[k]);
  printf("\n");
}