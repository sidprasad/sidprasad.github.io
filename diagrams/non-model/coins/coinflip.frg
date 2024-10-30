#lang forge


abstract sig Side {}
one sig Heads, Tails extends Side {}

sig Coin {
    showing : set Side
}


pred physicalConstraints {
    all c : Coin | c.showing in Heads + Tails
}

pred validGame {
    all c : Coin | one c.showing
}

pred invalidGame {
    all c : Coin | {
        some c.showing

        (Tails in c.showing) implies (Heads in c.showing)
    }


}

run {invalidGame} for exactly 9 Coin