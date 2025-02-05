#lang forge

open "bst.frg"
//// Do not edit anything above this line ////


// Number of left and right children must be the same
//assert (all n: Node | #(n.left) = #(n.right)) is necessary for binary_search_tree

// This is a test that is not pertinent.
// assert {all n: Node | (n.left).key < (n.key)} is necessary for binary_search_tree

// example two_node is binary_search_tree for {
//     Node = `N1 + `N2
//     key = `N1-> 1 + `N2-> 1
//     left = `N1-> `N2
// }

// pred same_key_child[n: Node] {

//   some n.(left + right)
//   (n.left).key = n.key or (n.right).key = n.key
// }

// // Can left be leq right?
// //assert some n : Node | right_same_as_key[n]  is consistent with binary_search_tree


assert (some n1, n2 : Node | ((n1 != n2) and n1.key = n2.key)) is consistent with binary_search_tree