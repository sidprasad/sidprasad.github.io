#lang forge


abstract sig FacePart {
    below : set FacePart,
    aligned : set FacePart
}


sig EyeBrow extends FacePart {}

sig Eye extends FacePart {}
sig Nose extends FacePart {}
sig Mouth extends FacePart {}
sig Chin extends FacePart {}
sig Hair extends FacePart {}

sig Face {
    parts : set FacePart
}


inst face {
    Face = `Face
    Eye = `Eye1 + `Eye2
    Hair = `Hair
    Chin = `Chin
    EyeBrow = `EyeBrowA + `EyeBrowB

    Nose = `Nose
    Mouth = `Mouth
    FacePart = Eye + Nose + Mouth + EyeBrow + Chin + Hair


    below = Hair->EyeBrow + `EyeBrowA -> `Eye1 + `EyeBrowB->`Eye2 + Eye->Nose + Nose->Mouth + Mouth->Chin
    aligned = `Eye1->`Eye2 + `EyeBrowA->`EyeBrowB
    
    parts = `Face -> (Eye + Nose + Mouth + EyeBrow + Chin + Hair)
}

inst nonface {
    Face = `Face
    Eye = `Eye1 + `Eye2
    Hair = `Hair
    Chin = `Chin
    EyeBrow = `EyeBrowA + `EyeBrowB

    Nose = `Nose
    Mouth = `Mouth
    FacePart = Eye + Nose + Mouth + EyeBrow + Chin + Hair

    below = `EyeBrowA->`Eye1 + Eye->Nose + `EyeBrowB->Nose + Nose->Mouth + Mouth->Chin + Hair->EyeBrow    
    aligned = `Eye1 ->`Eye2 + `Eye2 -> `EyeBrowB

    parts = `Face -> (Eye + Nose + Mouth + EyeBrow + Chin + Hair)
}

run {} for nonface