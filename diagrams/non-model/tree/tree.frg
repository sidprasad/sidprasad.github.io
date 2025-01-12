#lang forge


sig Node {
    parent : set Node,
    left: lone Node,  -- every node has at most one left-child
    right: lone Node  -- every node has at most one right-child

}
fun descendantsOf[ancestor: Node]: set Node {
  ancestor.^(left + right) -- nodes reachable via transitive closure
}



pred isRoot[ r : Node] {
    no r.parent
}


pred b_dag {

    parent = ~left + ~right
    
    // Left and right differ, unless both are empty
    all n: Node | some n.left => n.left != n.right 

    -- connected via finite chain of left, right, and inverses
    all disj n1, n2: Node | n1 in n2.^(left + right + parent)

    -- no cycles
    all n : Node | n not in descendantsOf[n]
}




pred binary_tree {

    b_dag
    all n: Node | (lone n.parent)
    one r : Node | isRoot[r]
}


pred two_roots {
    b_dag

    one c: Node | {

        #(c.parent) = 2
        all p : c.parent | (no p.parent)

        all c2 : Node - c | lone c2.parent
    }
}



run {binary_tree} for exactly 10 Node
