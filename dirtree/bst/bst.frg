#lang forge


sig Node {
  key: one Int,     -- every node has some key 
  left: lone Node,  -- every node has at most one left-child
  right: lone Node  -- every node has at most one right-child
}

fun descendantsOf[ancestor: Node]: set Node {
  ancestor.^(left + right) -- nodes reachable via transitive closure
}

pred binary_tree {
  -- no cycles (modified)
  all n: Node | 
    n not in descendantsOf[n] 
  -- connected via finite chain of left, right, and inverses
  all disj n1, n2: Node | n1 in n2.^(left + right + ~left + ~right)
  -- left+right differ (unless both are empty)
  all n: Node | some n.left => n.left != n.right 
  -- nodes have a unique parent (if any)
  all n: Node | lone parent: Node | n in parent.(left+right)
}


// NOW ~BST~
pred invariant_v1[n: Node] {
  -- "Every node's left-descendants..." (if any)
  some n.left => {
    n.left.key < n.key
    all d: Node | reachable[d, n.left, left, right] => d.key < n.key
  }
  -- "Every node's right-descendants..." (if any)
  some n.right => {
    n.right.key < n.key
    all d: Node | reachable[d, n.right, left, right] => d.key > n.key
  }
}
pred binary_search_tree {
  binary_tree  -- a binary tree, with an added invariant
  all n: Node | invariant_v1[n]  
}


run binary_search_tree for exactly 6 Node


// This is a test that is not pertinent.
// assert {all n: Node | (n.left).key < (n.key)} is necessary for binary_search_tree




// Number of left and right children must be the same
//assert (all n: Node | #(n.left) = #(n.right)) is necessary for binary_search_tree


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


//assert (some n1, n2 : Node | ((n1 != n2) and n1.key = n2.key)) is consistent with binary_search_tree