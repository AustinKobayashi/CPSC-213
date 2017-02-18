#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "list.h"
#include "tree.h"
#include "refcount.h"

struct tree {
    node_t root;
};

struct node {
    element_t e;
    node_t    left, right;
};

/**
 * Create a new, empty tree
 */

tree_t tree_new() {
    tree_t t = malloc (sizeof (*t));
    t->root  = NULL;
    return t;
}

static void tree_delete_helper (node_t n) {
    
    if (n != NULL) {
        tree_delete_helper (n->left);
        tree_delete_helper (n->right);

        rc_free_ref(n->e);
        free(n);
    }
}

/**
 * Delete tree and all of its nodes
 */
void tree_delete (tree_t t) {
    
    tree_delete_helper (t->root);
    free(t);
}

static node_t tree_insert_node_helper (node_t* np, element_t e) {
    
    if (*np != NULL) {
        if (strcmp (element_get_value (e), element_get_value ((*np)->e)) <= 0)
            return tree_insert_node_helper (&(*np)->left, e);
        else
            return tree_insert_node_helper (&(*np)->right, e);
    } else {
        *np = malloc (sizeof (**np));
        (*np)->e    = e;
        (*np)->left = (*np)->right = NULL;
        return *np;
    }
}

/**
 * Insert a new list element into the tree
 */
node_t tree_insert_node (tree_t t, element_t e) {
    
    rc_keep_ref(e);
    
    return tree_insert_node_helper (&t->root, e);
}

static void tree_ordered_suffix_print_helper (node_t n) {
    if (n != NULL) {
        tree_ordered_suffix_print_helper (n->left);
        for (element_t e = n->e; e != NULL; e = element_get_next (e))
            printf ("%s ", element_get_value (e));
        printf ("\n");
        tree_ordered_suffix_print_helper (n->right);
    }
}

/**
 * Perform depth-first traversal of tree, printing the values
 * in the linked list rooted at each node.
 */
void tree_ordered_suffix_print (tree_t t) {
    tree_ordered_suffix_print_helper (t->root);
}
