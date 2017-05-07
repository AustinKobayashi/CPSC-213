#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "list.h"


void Print (element_t ev) {
    char* e = (char*) ev;
    printf ("%s\n", e);
}

void StringToNumber(element_t* rv, element_t av){

    char* a = (char*) av;
    intptr_t* r = (intptr_t*) rv;
    char* pEnd;
    
    *r = strtol (a, &pEnd, 10);
    
    if(pEnd == a)
        *r = -1;
}


// If the number is negative, r* = a
// Else r* = Null
void ReplaceWithNull(element_t* rv, element_t av, element_t bv){

    char** r = (char**) rv;
    char* a = (char*) av;
    intptr_t b = (intptr_t) bv;
    
    if(b < 0)
        *r = a;
    else
        *r = NULL;
}


// Return 1 if a is positive, else return 0
int Positive(element_t av){
    
    intptr_t a = (intptr_t) av;
    
    if(a >= 0)
        return 1;
    
    return 0;
}


// Return 1 if a is not null, else return 0
int NotNull (element_t av){
    
    char* a = (char*) av;
    
    if(a != NULL)
        return 1;
    
    return 0;
}


void Truncate (element_t* rv, element_t av, element_t bv){
    
    char** r = (char**) rv;
    char* a = (char*) av;
    intptr_t b = (intptr_t) bv;
    
    if(strlen(a) > b)
        a[(int)b] = 0;
    
    *r = a;
}


void Max (element_t* rv, element_t av, element_t bv){

    intptr_t* r = (intptr_t*) rv;
    intptr_t a = (intptr_t) av;
    intptr_t b = (intptr_t) bv;
    
    if(a >= b)
        *r = a;
    else
        *r = b;
}


/**
 * Test filter, map, foldl, and foreach on two small integer lists.
 */
int main(int argc, char *argv[]) {
    
    struct list* list = list_create();
    
    for(int i = 1; i < argc; i++)
        list_append (list, (element_t) argv[i]);
        
    struct list* listOfNum = list_create ();
    list_map1 (StringToNumber, listOfNum, list);
        
    struct list* listWithNull = list_create();
    list_map2 (ReplaceWithNull, listWithNull, list, listOfNum);
    
    struct list* listPositive = list_create();
    list_filter (Positive, listPositive, listOfNum);

    struct list* listNoNull = list_create();
    list_filter (NotNull, listNoNull, listWithNull);

    struct list* listTruncated = list_create();
    list_map2 (Truncate, listTruncated, listNoNull, listPositive);
    
    list_foreach (Print, listTruncated);

    element_t maxValue = 0;
    list_foldl (Max, &maxValue, listOfNum);
    
    printf("%i\n", maxValue);
    
    list_destroy (list);
    list_destroy (listOfNum);
    list_destroy (listWithNull);
    list_destroy (listPositive);
    list_destroy (listNoNull);
    list_destroy (listTruncated);
}







