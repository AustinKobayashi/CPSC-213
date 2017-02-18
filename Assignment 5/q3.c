#include <stdio.h>
#include "list.h"
#include "tree.h"
#include "refcount.h"

/**
 * Your solution can not depend in any way on the implemenation of this function.
 * That is, your program must work with any arbitrary selection function.
 */
int includeElement() {
    static int count=0;
    return (++count) % 2;
}

int main (int argc, char** argv) {
    tree_t t = tree_new();
    list_t l = list_new();
    element_t arr[5];
    
    for (int i=0; i<argc-1; i++)
        arr[i] = list_add_element (l, argv[i+1]);
    
    //rc_print(arr[0]);

    int j=0;
    for (element_t e = list_get_first_element (l); e != NULL; e = element_get_next (e)) {
        if (includeElement()) //true for even indexs
            tree_insert_node (t, e);
    }
    
    //rc_print(arr[0]);

    printf ("Before deleting list:\n");
    tree_ordered_suffix_print (t);
    list_delete (l);
    
    //rc_print(arr[0]);

    printf ("After deleting list:\n");
    tree_ordered_suffix_print (t);
    
    //rc_print(arr[0]);

    tree_delete (t);
    
    
    //for(int i = 0; i < 5; i++)
     // rc_print(arr[i]);
}
