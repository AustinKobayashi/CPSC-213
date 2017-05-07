#include <stdlib.h>
#include <stdio.h>
#include "list.h"

int isEven (element_t av) {
  int* a = av;
  return ! (*a & 1);
}

void add (element_t* rv, element_t av, element_t bv) {
  int* a = av;
  int* b = bv;
  if (*rv == NULL)
    *rv = malloc (sizeof (int));
  int* r = *rv;
  *r = *a + *b;
}

void inc (element_t* rv, element_t av) {
  int* a = av;
  if (*rv == NULL)
    *rv = malloc (sizeof (int));
  int* r = *rv;
  *r = *a + 1;
}

void print (element_t ev) {
  int* e = ev;
  printf ("%d\n", *e);
}

int main() {
  int a[]   = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
  int b[]   = {11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1};
  int* ap[] = {&a[0],&a[1],&a[2],&a[3],&a[4],&a[5],&a[6],&a[7],&a[8],&a[9],&a[10]};
  int* bp[] = {&b[0],&b[1],&b[2],&b[3],&b[4],&b[5],&b[6],&b[7],&b[8],&b[9],&b[10]};

  struct list* l0 = list_create();
  list_append_array (l0, (element_t*) ap, sizeof(ap)/sizeof(ap[0]));
  
  struct list* l1 = list_create();
  list_append_array (l1, (element_t*) bp, sizeof(bp)/sizeof(bp[0]));
  
  struct list* l2 = list_create();
  list_filter (isEven, l2, l0);
  printf ("filter:\n");
  list_foreach (print, l2);
  
  struct list* l3 = list_create();
  list_map1 (inc, l3, l0);
  printf ("map1:\n");
  list_foreach (print, l3);
  
  struct list* l4 = list_create();
  list_map2 (add, l4, l3, l2);
  printf ("map2:\n");
  list_foreach (print, l4);
  
  int* sp = malloc (sizeof (*sp));
  list_foldl (add, (element_t*) &sp, l4);
  printf ("fold: %d\n", *sp);
  
  list_foreach (free, l3);
  list_foreach (free, l4);
  free (sp);
  
  list_destroy (l0);
  list_destroy (l1);
  list_destroy (l2);
  list_destroy (l3);
  list_destroy (l4);
}