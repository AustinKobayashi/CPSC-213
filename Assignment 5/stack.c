#include <stdlib.h>
#include <stdio.h>
#include <string.h>

struct Element {
    char   name[200];
    struct Element *next;
};

struct Element *top = 0;

void push (char* aName) {
    struct Element* e = malloc (sizeof (*e));    // Not the bug: sizeof (*e) == sizeof(struct Element)
    strncpy (e->name, aName, sizeof (e->name));  // Not the bug: sizeof (e->name) == 200
    e->next  = top;
    top = e;
}


char* pop() {
    struct Element* e = top;    
    char* name = malloc(sizeof(e->name));
    strncpy (name, e->name, sizeof (e->name));  
    top = e->next;    
    free (e);
    return name;
}

int main (int argc, char** argv) {
    push ("A");
    push ("B");
    char* w = pop();
    push ("C");
    push ("D");
    char* x = pop();
    char* y = pop();
    char* z = pop();
    printf ("%s %s %s %s\n", w, x, y, z);
    free(w);
    free(x);
    free(y);
    free(z);
}
