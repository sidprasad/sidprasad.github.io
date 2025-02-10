#lang forge

open "bst.frg"
//// Do not edit anything above this line ////

// For every node, left child < right child. That isn't a leaf.
// Every node should have at most two children.

// For every child a node left child < node value, right child greater.

example two_node_tree is {not binary_search_tree} for {

    Node = `N1 + `N2
    key = `N1-> 1 + `N2-> 1
    left = `N1->`N2
    no right
}

assert {one c : Node | all c2 : Node {c != c2 implies reachable[c2, c, left, right]}  }
 is necessary for binary_search_tree



