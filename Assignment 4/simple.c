#include <stdlib.h>
#include <stdio.h>

void foo (char* s) {
    printf ("%s World\n", s);
}

int main (int argc, char** argv) {
    foo ("Hello");
}
