---
layout: post
title: "Your Diagram Doesn't Know What It's Drawing"
date: 2026-06-24
tags: [diagram, pl, spatial, visualization, semantics]
---

Somewhere in your repository there is a diagram of your system. It is probably quite good. Someone redrew it after the last refactor; someone else fixed a typo in it during review. It renders in your README, it diffs in your PRs, and you trust it.

You should not. Not because it's out of date — though it is — but because of something worse: *it has no way of being right.* It doesn't know what it's drawing. It never has.

Let me give the tools their due, because they earned it. For years a diagram was a dead PNG: you drew it by hand, screenshotted it, pasted it, and three weeks later redrew it from scratch because one box moved. Mermaid fixed a real thing about that. It turned the diagram into *text*. You write `A --> B`, you get an arrow, and the picture now lives in the repo and survives. That is a genuine victory and I won't undersell it.

But it is a *smaller* victory than we let ourselves believe — and we have been quietly charging it to the wrong account.

Look at what the text actually says. `graph TD`. `A --> B`. `TD` means "top-down." `-->` means "draw an arrow." This is not a description of your system. It is a *program* — a tiny imperative program whose output is a picture. You thought you were writing down your architecture. You were writing instructions for a layout engine. The renderer never learns that `A` and `B` are services, or courses, or people. It learns that they are boxes, and that you would like a line between them.

Here is one, rendered live, looking every bit as authoritative as the one on your wall. (Drag it. It doesn't mind. It has no opinion about where anything goes.)

<div class="spytial-graph" data-height="300">
intro[CS 101]:::Course -> data[CS 201]:::Course   : prereq
data                   -> algo[CS 301]:::Course   : prereq
data                   -> sys[CS 305]:::Course    : prereq
algo                   -> theory[CS 401]:::Course : prereq
</div>

## A picture cannot be wrong

Point at any box in that diagram and ask the only question that matters: *how would I know if it were wrong?*

You can't, and neither can it. There is no fact the box is accountable to. The arrow from `CS 201` to `CS 301` doesn't *assert* that 201 is a prerequisite for 301 — it *depicts* two rectangles and a line, and it would depict them with exactly the same serenity if the relationship ran the other way, or didn't exist, or was a lie told by a registrar. A picture cannot be false.

And — this is the part that should bother you — a thing that cannot be false cannot be true either. It makes no claim, so it carries no information. Your diagram does not agree with your system. It agrees with *whatever you drew*. It is a yes-man with good typography.

Popper had a word for theories that survive no matter what the world does: *unfalsifiable*, and he taught us to distrust them. Somehow we never extended the courtesy to diagrams. We draw the unfalsifiable thing on a whiteboard and then make architectural decisions standing in front of it, as though it were evidence rather than a mirror.

## A model of a diagram, or a diagram of a model

Here is the slogan I keep coming back to:

> Mermaid has a model of a diagram. I want a diagram of a model.

Mermaid's little universe *is* the picture — boxes, arrows, a layout direction. Its nouns are graphical nouns. Turn the whole thing inside out. Put the *model* underneath — atoms with identity, sorts, named relations, the actual things — and let the picture be a *consequence* of it. The text stops being a drawing program and becomes a small, honest description: `data[CS 201]:::Course` says there is an atom, its identity is `data`, you'd display it as "CS 201," and its sort is `Course`. `data -> algo : prereq` says there is a *prereq* relation between two of them. None of that mentions the picture. The picture is what you get when you stop talking.

And when you *do* want to talk about the picture, you say it in the vocabulary of the model, not of the pixels — because now there is a model to refer to. `selector=prereq` means *every prereq edge*; `selector=Course` means *every Course* — because `prereq` and `Course` are real things in the model, not spellings on a box.

Watch what that buys. Here are the *same four facts*, twice. The only thing I change between them is one annotation — `directions=[right]` becomes `directions=[below]`. I never touch a single relationship:

<div class="spytial-graph" data-height="240">
intro[CS 101]:::Course -> data[CS 201]:::Course   : prereq
data                   -> algo[CS 301]:::Course   : prereq
algo                   -> theory[CS 401]:::Course : prereq

@orientation(selector=prereq, directions=[right])
@atomColor(selector=Course, value='#e7f0ff')
</div>

<div class="spytial-graph" data-height="300">
intro[CS 101]:::Course -> data[CS 201]:::Course   : prereq
data                   -> algo[CS 301]:::Course   : prereq
algo                   -> theory[CS 401]:::Course : prereq

@orientation(selector=prereq, directions=[below])
@atomColor(selector=Course, value='#e7f0ff')
</div>

One reads as "take these in order," left to right. The other reads as a dependency tree, top to bottom. Same facts; different *question* asked of them. A drawing can't tell those two operations apart — to Mermaid, rotating the picture and re-stating the truth are the same edit, because the picture is all there is. A model can. The layout is a consequence you can argue with, not a thing you nudge.

## Now it can be wrong — and that's the point

This is the move a drawing can never make.

Because there is a model with claims under the picture, you are now allowed to claim *too much*. State an invariant you believe about your system — *every prerequisite comes before the course that needs it* — and ask for a layout that honors it. If the data can honor it, you get your picture. If it can't, you do not get a tasteful arrangement that quietly hides the problem. You get a refusal, and a finger pointed at the exact claims that cannot coexist.

Watch. Here is the same chart with one edge a real registrar once actually shipped — `algo -> intro` — and the standing request that prerequisites flow left to right:

<div class="spytial-graph-editable" data-height="340">
intro[CS 101]:::Course -> data[CS 201]:::Course : prereq
data                   -> algo[CS 301]:::Course : prereq
algo                   -> intro                  : prereq

@orientation(selector=prereq, directions=[right])
</div>

- This course has a prerequisite.
- Fine. Which?
- CS 301.
- And 301's prerequisite?
- CS 201.
- And 201's?
- ...CS 301.

No student can ever take any of these three courses. The cycle makes "everything flows left-to-right" *impossible* — and the model says so, naming the precise `prereq` edges that are fighting, rather than drawing a confident loop and letting someone enroll. Delete the registrar's mistake in the editor above and watch the picture fall into a clean line. A Mermaid diagram would have drawn the loop, beautifully, and said nothing. *Yours just caught you.*

That is the whole argument. A picture-with-claims can be wrong, which is the only way anything can ever be *right*.

## The arrow goes both ways

One more, quickly, because it falls out for free. Since the text is a model and not a drawing, you can run it backwards: render it into an editor, drag the nodes, add one, draw an edge — then ask for the source back. That's what the **⧉ notation** button in the corner of the editable diagram above does: it hands you your edited graph as text, annotations and all. The picture and the source are not two artifacts you sweat to keep in sync. They are one object seen from two sides. Edit either; the other is a projection away.

## Small on purpose

This is a small language, deliberately — nodes, edges, sorts, a handful of spatial annotations; no swimlanes, no Gantt charts, no sequence diagrams. The smallness is not a roadmap apology. It is the price of meaning. What you buy with it is a diagram that *means something*: a model under the picture, a layout you can argue with, claims that can fail.

A diagram you cannot query, cannot constrain, and cannot be *wrong* with is not a model of your system. It is a drawing of one — and you should grant it exactly the authority you grant any other drawing, which is to say, none that you wouldn't grant a napkin.

Every diagram on this page is live; the one tag below did that. Go make a diagram that can disagree with you.

*The notation, source, and a playground are [on GitHub](https://github.com/sidprasad/spytial-graph).*

<!-- One module tag turns every spytial-graph block above into a live diagram. It
     injects its engine (d3 v4 + WebCola + spytial-core) from the CDN on first load. -->
<script type="module" src="https://cdn.jsdelivr.net/npm/spytial-graph/src/auto.js"></script>
