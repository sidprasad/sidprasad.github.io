#lang forge


abstract sig FacePart {
    below : set FacePart,
    aligned : set FacePart
}

abstract sig Color {}
one sig Brown, Blue extends Color {}

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
    Nose = `Nose
    Mouth = `Mouth
    FacePart = Eye + Nose + Mouth


    below = `Eye1->`Nose + `Eye2->`Nose + `Nose->`Mouth
    aligned = `Eye1->`Eye2

    color = `Eye1->`Brown + `Eye2->`Blue

    parts = `Face -> (`Eye1 + `Eye2 + `Nose + `Mouth)

}

inst nonface {
    Brown = `Brown
    Blue = `Blue
    Color = `Brown + `Blue

    Face = `Face
    Eye = `Eye1 + `Eye2
    Nose = `Nose
    Mouth = `Mouth
    FacePart = Eye + Nose + Mouth

    below = `Eye1->`Eye2 + `Nose->`Mouth
    aligned = `Eye2->`Nose 

    color = `Eye1->`Blue + `Eye2->`Brown

    parts = `Face -> (`Eye1 + `Eye2 + `Nose + `Mouth)

}

run {} for nonface