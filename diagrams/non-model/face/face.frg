#lang forge


abstract sig FacePart {
    below : set FacePart,
    aligned : set FacePart
}

abstract sig Color {}
one sig Brown, Blue extends Color {}

sig EyeBrow extends FacePart {}

sig Eye extends FacePart {
    color : one Color
}
sig Nose extends FacePart {}
sig Mouth extends FacePart {}

sig Face {
    parts : set FacePart
}


inst face {
    Brown = `Brown
    Blue = `Blue
    Color = `Brown + `Blue
    Face = `Face
    Eye = `Eye1 + `Eye2

    EyeBrow = `EyeBrowA + `EyeBrowB

    Nose = `Nose
    Mouth = `Mouth
    FacePart = Eye + Nose + Mouth + EyeBrow


    below = `Eye1->`Nose + `Eye2->`Nose + `Nose->`Mouth + `EyeBrowA->`Eye1 + `EyeBrowB->`Eye2
    aligned = `Eye1->`Eye2 + `EyeBrowA->`EyeBrowB

    color = `Eye1->`Brown + `Eye2->`Blue

    parts = `Face -> (`Eye1 + `Eye2 + `Nose + `Mouth + `EyeBrowA + `EyeBrowB)

}

inst nonface {
    Brown = `Brown
    Blue = `Blue
    Color = `Brown + `Blue

    Face = `Face
    Eye = `Eye1 + `Eye2
    Nose = `Nose
    Mouth = `Mouth

    EyeBrow = `EyeBrowA + `EyeBrowB
    FacePart = Eye + Nose + Mouth + EyeBrow

    below = `EyeBrowA->`Eye1 + Eye->Nose + `EyeBrowB->Nose + Nose->Mouth
    
    aligned = `Eye1 ->`Eye2 + `Eye2 -> `EyeBrowB

    color = `Eye1->`Blue + `Eye2->`Brown

    parts = `Face -> (`Eye1 + `Eye2 + `Nose + `Mouth + `EyeBrowA + `EyeBrowB)

}

run {} for nonface