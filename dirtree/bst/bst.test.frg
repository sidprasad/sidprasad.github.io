#lang forge

open "bst.wheat"
//// Do not edit anything above this line ////

// pred invariant_v2[n: Node] {
//   -- "Every node's immediate children..."
//   some n.left implies n.left.key < n.key
//   some n.right implies n.right.key > n.key
// }
// pred binary_search_tree_v2 {
//   binary_tree  -- a binary tree, with an added invariant
//   all n: Node | invariant_v2[n]
// }

