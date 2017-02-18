#ifndef __tree_h__
#define __tree_h__

#include "list.h"

struct tree;
struct node;
typedef struct tree* tree_t;
typedef struct node* node_t;

/**
 * Create a new, empty tree
 */

tree_t tree_new();

/**
 * Delete tree and all of its nodes
 */
void   tree_delete (tree_t t);

/**
 * Insert a new list element into the tree
 */
node_t tree_insert_node (tree_t t, element_t e);

/**
 * Perform depth-first traversal of tree, printing the values
 * in the linked list rooted at each node.
 */
void tree_ordered_suffix_print (tree_t t);

#endif /* __tree_h__ */