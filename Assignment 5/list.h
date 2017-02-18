#ifndef __list_h__
#define __list_h__

struct list;
struct element;
typedef struct list*    list_t;
typedef struct element* element_t;

/**
 * Create new list
 */
list_t list_new();

/**
 * Delete the list and all of the elements it contains.
 */
void list_delete (list_t l);

/**
 * Add an element to the list.
 * Returns pointer to new element.
 * NOTE: Returned element is not owned by caller; call inc_ref if reference is saved.
 */
element_t list_add_element (list_t l, char* value);

/**
 * Remove element from list and decrement its reference count.
 */
void list_delete_element (list_t l, element_t e);

/**
 * Get first element of list. 
 * NOTE: Returned element is not owned by caller; call inc_ref if reference is saved.
 */
element_t list_get_first_element (list_t l);

/**
 * Get next element of list.
 * NOTE: Returned element is not owned by caller; call inc_ref if reference is saved.
 */
element_t element_get_next (element_t e);

/**
 * Get element's value
 */
char* element_get_value (element_t e);

/**
 * Increment element's reference count.
 */
void element_inc_ref (element_t e);

/**
 * Decrement element's reference count and free element when count goes to 0.
 */
void element_dec_ref (element_t e);

#endif /* __list_h__ */
