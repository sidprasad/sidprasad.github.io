---
layout: default
title: "Misconceptions in LTL and LTLf"
---
## "Does this formula mean what I think it means?"

As part of a broader project on improving Linear Temporal Logic (LTL) education, I used grounded-theory methods to identify recurring misconceptions in how users reason about the logic. Each corresponds to a coherent alternative interpretation of LTL's semantics. This has real-world consequences: an engineer specifying a train's behavior might fall prey to a common misconception, writing l UNTIL s for “keep the doors locked until the train reaches the station” and expecting the doors to unlock once the station is reached. LTL imposes no such requirement. The specification therefore permits the train to sit at the station with its passengers still locked inside.

{% assign research_pub = site.data.publications | where: "bib_key", "ltl2024" | first %}
{% include publication-card.html pub=research_pub %}

Educators are well positioned to address these misconceptions, but they cannot rebuild a curriculum around every new empirical finding or diagnose and remediate each learner's mistakes individually. Any intervention therefore has to support existing instruction, generate its own exercises, and adapt them to the misconceptions a learner exhibits.

The [LTL Tutor](https://ltl-tutor.xyz) is a curriculum-agnostic, misconception-first adaptive learning system that can complement existing instruction with little disruption. It tailors instruction to a learner's mental model of the logic's semantics.

{% assign research_pub = site.data.publications | where: "bib_key", "ltltutor2025" | first %}
{% include publication-card.html pub=research_pub %}

Its design rests on the insight that semantic misconceptions can be expressed through syntactic mutation. Mutation rules rewrite a formula into one that, under the semantics entailed by a particular misconception, behaves as the original does under LTL's actual semantics. These mutants serve as distractors in automatically generated multiple-choice questions. When chosen, they reveal how the learner is interpreting the logic. The Tutor can then use distinguishing traces to explain the difference and generate subsequent exercises targeting that misconception.

Analysis of over 6,000 questions answered by over 600 learners shows that learners become more likely to answer correctly with continued use and show corresponding improvements in their misconception profiles.


[PICK](/pick) approaches the question from another direction: helping people check whether a generated formula captures their intent by judging concrete examples.
