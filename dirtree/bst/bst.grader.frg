#lang forge

open "bst.frg"

pred left_inv[n : Node] {
      some n.left => {
        n.left.key < n.key
        all d: Node | reachable[d, n.left, left, right] => d.key < n.key
    }
}

pred right_inv[n: Node] {
      -- "Every node's right-descendants..." (if any)
  some n.right => {
    n.right.key < n.key
    all d: Node | reachable[d, n.right, left, right] => d.key > n.key
  }
}





test expect {

  left_inv_test: {all n: Node | binary_search_tree implies left_inv[n]} is checked
  right_inv_test: {all n : Node | binary_search_tree implies right_inv[n]} is checked

  //// Here we do some well-formedness ////
  empty_test: {(no Node) implies binary_search_tree} is checked


  // Left and right different
  tree_not_dag : {  binary_search_tree implies   (all n: Node | some n.left => n.left != n.right) } is checked
  max_one_parent: { binary_search_tree implies (all n: Node | lone parent: Node | n in parent.(left+right)) } is checked


  // Connected
    -- no cycles (modified)
  no_cycles_test : {binary_search_tree implies (all n: Node |  n not in descendantsOf[n] )} is checked
  -- connected via finite chain of left, right, and inverses
  connected : {binary_search_tree implies (all disj n1, n2: Node | n1 in n2.^(left + right + ~left + ~right)) } is checked


  // Now want some POSITIVE tests
  one_node_tree : {binary_search_tree and (one Node)} is sat
  two_node_tree : {binary_search_tree and (some (left+right)) } is sat

  unbalanced_tree : {binary_search_tree and (some left) and (no right)} is sat

}