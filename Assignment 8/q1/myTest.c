#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "list.h"

/**
 * Set *rv = av + 1
 */
/*
 void inc (element_t* rv, element_t av) {
 intptr_t  a = (intptr_t)  av;
 intptr_t* r = (intptr_t*) rv;
 *r = a + 1;
 }
 */

void inc (intptr_t* rp, intptr_t a){
    *rp = a + 1;
}

/**
 * Print the value of *ev
 */
/*
 void print (element_t ev) {
 intptr_t e = (intptr_t) ev;
 printf ("%ld\n", e);
 }
 */

void print (intptr_t v){
    printf("%ld\n", v);
}



void test_map1 (void (*f) (intptr_t*, intptr_t), struct list* out_list, struct list* in_list){
    
}



void test_foreach (void (*f) (intptr_t), struct list* list){
    /*
    for(int i = 0 ; i < list->len; i++)
        f (list->data[i]);
     */
}



/**
 * Test filter, map, foldl, and foreach on two small integer lists.
 */
int main() {
    intptr_t a[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
    struct list* l0 = list_create();
    struct list* l1 = list_create();
    list_append_array (l0, (element_t* ) a, sizeof(a)/sizeof(a[0]));
    test_map1 (inc, l1, l0);
    test_foreach (print, l1);
}
