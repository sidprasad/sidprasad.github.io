#lang forge



sig Node {
  left: lone Node,  -- every node has at most one left-child
  right: lone Node  -- every node has at most one right-child
}
fun descendantsOf[ancestor: Node]: set Node {
  ancestor.^(left + right) -- nodes reachable via transitive closure
}
pred dag {

  all n: Node |  n not in descendantsOf[n] 
  -- connected via finite chain of left, right, and inverses
  all disj n1, n2: Node | n1 in n2.^(left + right + ~left + ~right)
  -- left+right differ (unless both are empty)
  all n: Node | some n.left => n.left != n.right 

  
}

pred binary_tree {
    dag
      -- nodes have a unique parent (if any)
    all n: Node | lone parent: Node | n in parent.(left+right)
}

pred two_roots {
    dag

    some p1, p2 : Node | {
        p1 != p2
        no n : Node | p1 in n.(left+right)
        no n : Node | p2 in n.(left+right)
        
        all c : Node - (p1 + p2) | {
            
            c in p1.left or c in p2.right or {one parent : Node | c in parent.(left+right)}

        }
    }

}

run {two_roots} for exactly 10 Node

--run {binary_tree} for 7 Node



-- run {binary_tree} for exactly 10 Node
