//
// This is the solution to CPSC 213 Assignment 5.
// Do not distribute this code or any portion of it to anyone in any way.
// Do not remove this comment.
//

#include <stdlib.h>
#include <stdio.h>

////////////
/// definition of struct's accessed by q1.s
///

struct B {
  int    y[4];
  struct A* a;
};

struct A {
  int*     x;
  struct B b;
};

////////////
/// declaratoin of global variables found in q1.s
///

struct A* a;
int    i, v0, v1, v2, v3;


///////////
/// your implementatoin of code found in q1.s
///

void q1() {
    
    v0 = a->x[i];
    v1 = a->b.y[i];
    v2 = a->b.a->x[i];
    a->b.a = a;
    v3 = a->b.a->b.y[i];
}

////////////
/// test harness (run with no args for default values; you code must work for arbitrary)
///

int main (int ac, char** av) {
  /* dynamic allocatoin and default values for variables and objects found in q1.s */
  a         = malloc (sizeof (struct A));
  a->b.a    = malloc (sizeof (struct A));
  a->x      = malloc (4 * sizeof (int));
  a->b.a->x = malloc (4 * sizeof (int));
  i = 0;
  a->x[0]        = 10; a->x[1]        = 11; a->x[2]        = 12; a->x[3]        = 13;
  a->b.y[0]      = 20; a->b.y[1]      = 21; a->b.y[2]      = 22; a->b.y[3]      = 23;
  a->b.a->x[0]   = 30; a->b.a->x[1]   = 31; a->b.a->x[2]   = 32; a->b.a->x[3]   = 33;
  a->b.a->b.y[0] = 40; a->b.a->b.y[1] = 41; a->b.a->b.y[2] = 42; a->b.a->b.y[3] = 43;

  /* alternate initializatoin from command line (for marking) */
  if (ac == 18) {
    i = atoi(av[1]);
    a->x[0]        = atoi(av[2]);  a->x[1]        = atoi(av[3]);  a->x[2]        = atoi(av[4]);  a->x[3]        = atoi(av[5]);
    a->b.y[0]      = atoi(av[6]);  a->b.y[1]      = atoi(av[7]);  a->b.y[2]      = atoi(av[8]);  a->b.y[3]      = atoi(av[9]);
    a->b.a->x[0]   = atoi(av[10]); a->b.a->x[1]   = atoi(av[11]); a->b.a->x[2]   = atoi(av[12]); a->b.a->x[3]   = atoi(av[13]);
    a->b.a->b.y[0] = atoi(av[14]); a->b.a->b.y[1] = atoi(av[15]); a->b.a->b.y[2] = atoi(av[16]); a->b.a->b.y[3] = atoi(av[17]);
  }

  /* run your code for q1.s */
  q1();

  /* print some results for marking */
  printf ("%d %d %d %d\n", v0, v1, v2, v3);
}
