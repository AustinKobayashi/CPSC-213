import static java.lang.System.out;

/**
 * A runnable class that implements and tests an ordered binary tree of integer values.
 */
public class BinaryTree {

  /**
   * A node of the binary tree containing the node's integer value 
   * and pointers to its right and left children (or null).
   */
  static class Node {
    int  value;
    Node left;
    Node right;
    
    /**
     * Create a new node with no children.
     */
    Node (int value) {
      this.value = value;
      this.left  = null;
      this.right = null;
    }
    
    /**
     * Insert the node n into the binary tree rooted by this node.
     */
    void insert (Node n) {
      if (n.value <= value) {
        if (left==null)
          left = n;
        else
          left.insert (n);
      } else {
        if (right==null)
          right = n;
        else
          right.insert (n);
      }
    }
    
    /**
     * Print the contents entire binary tree in order of ascending integer value.
     */
    void printInOrder() {
      if (left != null)
        left.printInOrder();
      out.printf ("%d\n", value);
      if (right != null)
        right.printInOrder();
    }
    
  }
  
  /**
   * Create a new tree populated with values provided on the command line and 
   * print it in depth-first order.
   */
  public static void main (String[] args) {
    Node root = null;
    // read values from command line and add them to the tree
    for (String arg: args) {
      int value = Integer.parseInt (arg);
      Node n = new Node (value);
      if (root == null)
        root = n;
      else
        root.insert (n);
    }
    root.printInOrder();
  }

}