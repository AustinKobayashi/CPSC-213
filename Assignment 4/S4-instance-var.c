#include <stdlib.h>

struct D {
  int e;
  int f;
};

struct D  d0;
struct D* d1;

void foo () {
  d1 = (struct D*) malloc (sizeof(struct D));
  d0.e = d0.f;
  d1->e = d1->f;
}
