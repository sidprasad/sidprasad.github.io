#lang forge


// Define the Binary Tree signature
sig Node {
    parent : lone Node,
    children : set Node
}

pred root [ r : Node ] {
    // All Nodes are reachable from the root
    Node in r.*children

    // No parent
    no p : Node | r in p.children

}


pred noSharedDecendants {
    all n : Node | lone children.n
}


pred tree {
    all p, c : Node | {
        // all c : n.children | c.parent = n
        (c in p.children) <=> (c.parent = p)
    }
    no (parent & iden)

    (some Node) => (one r : Node | root[r])
    no n: Node | n in n.^children
    noSharedDecendants
}


pred binaryTree {
    tree

    all n : Node | #(n.children) <= 2
}

pred oneLevelTernary {
    all n : Node | #(n.children) <= 3
    one n : Node | #(n.children) = 3
    tree
}

run binaryTree for exactly 9 Node

//run oneLevelTernary for exactly 9 Node