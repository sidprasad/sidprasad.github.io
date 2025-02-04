#lang forge
 option run_sterling off

sig Node {edges: set Node}

pred isDirectedTree
 {
 {
 edges.~edges in iden 
 lone edges.Node - Node.edges 
 no (^edges & iden) 
 lone Node or Node in edges.Node + Node.edges 
} 
}

pred isRoot_inner_1[n: Node]
 {
 {

 no edges.n
 lone Node or (Node in n.*edges)
} 
}

pred isRoot[n: Node]
 {
 all  n : Node |  (isRoot_inner_1[n] or ((some edges.n))) 
}

test expect {
  injective : {isDirectedTree implies (edges.~edges in iden)} is checked
  injective_insufficient : {(edges.~edges in iden) and !isDirectedTree} is sat

  root : {isDirectedTree implies (lone edges.Node - Node.edges) } is checked
  loopless : {isDirectedTree implies (no (^edges & iden))} is checked
  connected : {isDirectedTree implies (lone Node or Node in edges.Node + Node.edges) } is checked

  roottest : {all r : Node | isRoot[r] implies (no edges.r)} is checked
}


example twoNodeTree is isDirectedTree for {
  Node = `Node1 + `Node2
  edges = `Node1->`Node2
}

example notJustInjective is {not isDirectedTree} for {

	Node =`Node1 + `Node2 + `Node3
    edges = `Node1->`Node3 + `Node2->`Node2 + `Node3->`Node1
}

