#lang forge


one sig Dealer {}

sig Card {}

 sig Player {
    left : one Player,
    right : one Player,
    holding : lone Dealer,
    hand : set Card
}



pred wellformed {
    all p : Player |   {
        Player in p.^left // The table is a closed loop
    }
    one holding // One dealer

    right = ~left // Everyone is sitting next to someone
}


pred badlyformed {
    all p : Player |   {
        Player in p.^left // The table is a closed loop
    }

    one holding // One dealer

    // right != ~left // Everyone is sitting next to someone
    
    // I want right to be slightly different from ~left
    one p : Player | {
        p.right != p.~left
    }
    no (right & iden)

}


pred withCards {
    all p : Player | {
        some (p.hand)
    }

    // Cards cannot be in two hands
    all p1, p2 : Player | {
        (p1 != p2) => no (p1.hand & p2.hand)
    }

    // All cards are in someone's hand
    all c : Card | {
        some p : Player | c in p.hand
    }
}



run {
    //wellformed
    badlyformed
    withCards
} for exactly 5 Player, exactly 5 Card, 1 Dealer

