#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "list.h"
#include "refcount.h"

struct list {
    element_t head, tail;
};

struct element {
    char*     value;
    element_t prev, next;
};

/**
 * Create new list
 */
list_t list_new() {
    list_t l = malloc (sizeof (*l));
    l->head = l->tail = NULL;
    return l;
}

/**
 * Delete the list (including its elements).
 */
void list_delete (list_t l) {
    for (element_t e = l->head, n; e != NULL; e = n) {
        n = e->next;
        list_delete_element (l, e);
    }
    free (l);
}

/**
 * Add an element to the list.
 * Returns pointer to new element.
 * NOTE: Returned element is not owned by caller; call inc_ref if reference is saved.
 */
element_t list_add_element (list_t l, char* value) {
    element_t e = rc_malloc (sizeof (*e));
    e->value    = value;//strdup (value);
    e->prev = e->next = NULL;
    if (l->head == NULL)
        l->head = e;
    else {
        l->tail->next = e;
        e->prev       = l->tail;
    }
    l->tail = e;
    return e;
}

/**
 * Remove element from list and free it
 */
void list_delete_element (list_t l, element_t e) {
    if (e == l->head)
        l->head = e->next;
    else
        e->prev->next = e->next;
    if (e == l->tail)
        l->tail = e->prev;
    else
        e->next->prev = e->prev;
    e->next = e->prev = NULL;
    
    rc_free_ref(e);
}

/**
 * Get first element of list.
 * NOTE: Returned element is not owned by caller; call inc_ref if reference is saved.
 */
element_t list_get_first_element (list_t l) {
    return l->head;
}

/**
 * Get next element of list.
 * NOTE: Returned element is not owned by caller; call inc_ref if reference is saved.
 */
element_t element_get_next (element_t e) {
    return e->next;
}

/**
 * Get element's value
 */
char* element_get_value (element_t e) {
    return e->value;
}
