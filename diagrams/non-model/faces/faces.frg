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

pred onewayaligned[e1, e2 : FacePart] {
    (e1 -> e2) in aligned or e1 -> e2 in aligned
}

pred valid[ f : Face] {

    # (f.parts & Eye) = 2
    one (f.parts & Nose)
    one (f.parts & Mouth)

    all disj e1, e2 : (f.parts & Eye) | {
        (e1.aligned = e2) or (e2.aligned = e1) 
    
        (e1.aligned = e2) => (no e2.aligned)
        (e2.aligned = e1) => (no e1.aligned)
    }

    no (f.parts & Nose).aligned
    no (f.parts & Mouth).aligned
  


    ((f.parts) & Eye).below in ((f.parts) & Nose)
    ((f.parts & Nose)).below in ((f.parts) & Mouth)
    no ((f.parts & Mouth).below)

    all fp : f.parts | {
        f.parts in fp.^(below + ~below)
    }

}

pred picasso [f : Face] {
    # (f.parts & Eye) = 2
    one (f.parts & Nose)
    one (f.parts & Mouth)

    all fp : f.parts | {
        f.parts in fp.^(below + ~below)
    }



    // We want Eye below Eye (aligned with node) below mouth

    // One eye is below the other
    all disj e1, e2 : (f.parts & Eye) | {
        (e2 in e1.below ) or (e1 in e2.below)

        

        (e2 in e1.below) => {
            (no e1.aligned)
            e1.below = e2 + ((f.parts) & Nose)
        }
        
        (e1 in e2.below) => {
            (no e2.aligned)
            e2.below = e1 + ((f.parts) & Nose)
        }
    }

    // One eye is aligned with the Nose
    one e : (f.parts & Eye) | e.aligned = (f.parts & Nose)

    ((f.parts & Nose)).below in ((f.parts) & Mouth)
    no ((f.parts & Mouth).below)


}


pred physicalconstraints {

    no (aligned & ~aligned)
    no (below & ~below)

    all disj f1, f2 : Face | {
       no  (f1.parts & f2.parts )
    }

    FacePart = Eye + Nose + Mouth
    Face.parts = FacePart


    // Alignment and below are constrained to faces
    all f1, f2 : FacePart | {
        (f1->f2) in (aligned + below) => {
            one f : Face | (f1 + f2) in f.parts
        }
    }

}



pred validFaces {
    all f : Face | valid[f]
    physicalconstraints
}



pred invalidFace {
    one f : Face | valid[f]
    one f : Face | picasso [f]
    physicalconstraints
}


run invalidFace for exactly 2 Face, exactly 4 Eye, exactly 2 Nose, exactly 2 Mouth

