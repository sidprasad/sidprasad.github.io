---
layout: post
title: "Your Diagram Doesn't Know It's a Family Tree"
date: 2026-06-24
tags: [diagram, pl, spatial, visualization, semantics]
---

I picked up *Wuthering Heights* again recently, and — as usual — lost track of who was who. Two houses, two generations of Earnshaws and Lintons, a foundling who marries into both, and, because Brontë shows no mercy, a mother and a daughter who share a name. Somewhere around the second Catherine I gave up and did what anyone would do: I went to draw the family tree.

The obvious tool is Mermaid, and a good one. I wrote out the genealogy the way you write anything in Mermaid — nodes, edges, who is married to whom and who is whose parent:

<style>
.diagram-source-render {
  display: grid;
  grid-template-columns: minmax(0, 1fr) minmax(280px, 1fr);
  gap: 1rem;
  align-items: stretch;
  margin: 1.25rem 0;
}

.diagram-source-render pre {
  margin: 0;
  overflow: auto;
}

.diagram-rendered {
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: auto;
  padding: 0.75rem;
  border: 1px solid #d8dee4;
  border-radius: 6px;
  background: #fff;
}

@media (max-width: 780px) {
  .diagram-source-render {
    grid-template-columns: 1fr;
  }
}
</style>

<div class="diagram-source-render">
<pre><code class="language-mermaid">flowchart TD
  mr_e[Mr. Earnshaw] ---|spouse| mrs_e[Mrs. Earnshaw]
  mr_l[Mr. Linton] ---|spouse| mrs_l[Mrs. Linton]

  mr_e --&gt;|parentOf| hindley[Hindley]
  mrs_e --&gt;|parentOf| hindley
  mr_e --&gt;|parentOf| catherine[Catherine Earnshaw]
  mrs_e --&gt;|parentOf| catherine
  mr_e -.-&gt;|adopts| heathcliff[Heathcliff]

  mr_l --&gt;|parentOf| edgar[Edgar]
  mrs_l --&gt;|parentOf| edgar
  mr_l --&gt;|parentOf| isabella[Isabella]
  mrs_l --&gt;|parentOf| isabella

  hindley ---|spouse| frances[Frances]
  catherine ---|spouse| edgar
  heathcliff ---|spouse| isabella

  hindley --&gt;|parentOf| hareton[Hareton]
  frances --&gt;|parentOf| hareton
  catherine --&gt;|parentOf| cathy[Cathy Linton]
  edgar --&gt;|parentOf| cathy
  heathcliff --&gt;|parentOf| linton[Linton Heathcliff]
  isabella --&gt;|parentOf| linton

  cathy ---|spouse| linton
  cathy ---|spouse| hareton</code></pre>
<div class="diagram-rendered">
<div class="mermaid">
flowchart TD
  mr_e[Mr. Earnshaw] ---|spouse| mrs_e[Mrs. Earnshaw]
  mr_l[Mr. Linton] ---|spouse| mrs_l[Mrs. Linton]

  mr_e -->|parentOf| hindley[Hindley]
  mrs_e -->|parentOf| hindley
  mr_e -->|parentOf| catherine[Catherine Earnshaw]
  mrs_e -->|parentOf| catherine
  mr_e -.->|adopts| heathcliff[Heathcliff]

  mr_l -->|parentOf| edgar[Edgar]
  mrs_l -->|parentOf| edgar
  mr_l -->|parentOf| isabella[Isabella]
  mrs_l -->|parentOf| isabella

  hindley ---|spouse| frances[Frances]
  catherine ---|spouse| edgar
  heathcliff ---|spouse| isabella

  hindley -->|parentOf| hareton[Hareton]
  frances -->|parentOf| hareton
  catherine -->|parentOf| cathy[Cathy Linton]
  edgar -->|parentOf| cathy
  heathcliff -->|parentOf| linton[Linton Heathcliff]
  isabella -->|parentOf| linton

  cathy ---|spouse| linton
  cathy ---|spouse| hareton
</div>
</div>
</div>

And Mermaid drew it — instantly. The source lives with the text, changes in a diff, and renders where the reader already is; that bargain is still a little miraculous, and none of what follows is a complaint about Mermaid.

But look at what it drew: a graph. For a flowchart that is exactly right — the boxes can sit anywhere, and any layout that connects them reads the same. A genealogy is the opposite. The arrangement *is* the content. Mermaid can draw the *Wuthering Heights* family graph; it cannot give you the genealogy — and those are not the same thing.

You know roughly how to read what it should be, and so do I — but we are reading things the source never states. We read the top row as the oldest generation and each row below it as the next. We read Catherine and Edgar as a couple because they sit side by side, and we expect their child to hang below the pair. None of that is in the text. The text says: some nodes, some edges labeled `spouse`, some labeled `parentOf`, draw top-down.

So Mermaid draws top-down. It places each `spouse` edge wherever the ranking happens to allow, which is often not beside the partner and not on the same row. It runs each parent's `parentOf` edge down on its own, so a child lands under whichever parent the layout preferred, not under the couple. With two estates' worth of cousins marrying cousins, the result is a thicket. The picture is not wrong as a graph. It is wrong as a *family tree* — and the source had no way to know the difference, because "generation," "couple," and "child of both" were never things it could say.

A family tree has three commitments, and a flowchart has a word for none of them: generations are rows, spouses are adjacent on the same row, and a child belongs below the pair. You can fight the layout — reorder lines, add invisible edges, guess at ranks — until the picture happens to come out right. But then you are arranging boxes until they resemble a family tree. You are not telling the system that it is one.

That gap is the subject of this post.

## A diagram of a model

The fix is not a better flowchart. It is a different thing for the text to describe.

> Mermaid has a model of a diagram. What I need is a diagram of a model.

The source should name the things being diagrammed — the people, the relations between them — and the obligations those relations carry. For a family tree: which atoms are people, which relation is `parentOf`, which is `spouse`, and what each one asks of the geometry.

Here are the Earnshaws, the Lintons, and Heathcliff in Spytial Graph:

<div class="spytial-graph" data-height="540">
mr_e[Mr. Earnshaw]:::Earnshaw -> mrs_e[Mrs. Earnshaw]:::Earnshaw : spouse
mr_l[Mr. Linton]:::Linton -> mrs_l[Mrs. Linton]:::Linton : spouse

mr_e -> hindley[Hindley]:::Earnshaw : parentOf
mrs_e -> hindley : parentOf
mr_e -> catherine[Catherine Earnshaw]:::Earnshaw : parentOf
mrs_e -> catherine : parentOf
mr_e -> heathcliff[Heathcliff]:::Heathcliff : adopts

mr_l -> edgar[Edgar]:::Linton : parentOf
mrs_l -> edgar : parentOf
mr_l -> isabella[Isabella]:::Linton : parentOf
mrs_l -> isabella : parentOf

hindley -> frances[Frances]:::Earnshaw : spouse
catherine -> edgar : spouse
heathcliff -> isabella : spouse

hindley -> hareton[Hareton]:::Earnshaw : parentOf
frances -> hareton : parentOf
catherine -> cathy[Cathy Linton]:::Linton : parentOf
edgar -> cathy : parentOf
heathcliff -> linton[Linton Heathcliff]:::Heathcliff : parentOf
isabella -> linton : parentOf

cathy -> linton : spouse
cathy -> hareton : spouse

@orientation(selector=parentOf, directions=[below])
@orientation(selector=spouse, directions=[directlyRight])
@orientation(selector=adopts, directions=[below])
</div>

The notation is small. `catherine`, `edgar`, `heathcliff`, and the rest are atoms. `Earnshaw`, `Linton`, and `Heathcliff` are sorts — the two houses and the foundling who unsettles both, which is why he is colored apart. `spouse`, `parentOf`, and `adopts` are named relations. And two lines carry the entire shape of a family tree:

```text
@orientation(selector=parentOf, directions=[below])
@orientation(selector=spouse, directions=[right])
```

Those are not hints about node IDs. They are claims about relations. *Wherever* `parentOf` holds, the parent sits above the child; *wherever* `spouse` holds, the partners sit side by side. Generations become rows not because you placed anyone in a row, but because `parentOf` always points down. The shape is a consequence of what the relations mean.

It also lets the source say something the flowchart could only blur: Heathcliff joins the Earnshaws by `adopts`, not `parentOf`. The diagram encodes the outsider as an outsider — bound to the family, but never of its blood.

## You assert; the system arranges

Once the source carries a model, the work splits. You assert the facts — these people, this `parentOf`, that `spouse`. You assert the spatial obligations — parents above children, spouses side by side. Then you stop arranging things.

The system searches the space of layouts for one that satisfies what you said. You never placed the elder Earnshaws above Catherine or set Cathy beneath her parents; you said `parentOf` points down, and the solver found positions where that holds for every parent at once — even across two estates and a generation of cousins who marry each other. The picture is the output of honoring your constraints, not something you nudged by hand until it looked right.

I want to be exact about the size of this claim. The system does not invent people or guess who is whose parent. It does not know the novel. It searches over *arrangements*, not over *facts*. You bring the model; it finds a geometry the model permits.

Which is also why it can refuse. The diagram below is live — edit the source, drag a character, and the layout re-solves. It also carries one extra fact:

```text
cathy -> catherine : parentOf
```

Brontë gives Catherine Earnshaw a daughter and names her Catherine too; the doubling is half the reason readers get lost. This line goes one step further and makes the daughter her own mother's parent. If `parentOf` always points downward, there is no arrangement in which it does: Catherine would have to sit both above and below her own child.

<div class="spytial-graph-editable" data-height="540">
mr_e[Mr. Earnshaw]:::Earnshaw -> mrs_e[Mrs. Earnshaw]:::Earnshaw : spouse
mr_l[Mr. Linton]:::Linton -> mrs_l[Mrs. Linton]:::Linton : spouse

mr_e -> hindley[Hindley]:::Earnshaw : parentOf
mrs_e -> hindley : parentOf
mr_e -> catherine[Catherine Earnshaw]:::Earnshaw : parentOf
mrs_e -> catherine : parentOf
mr_e -> heathcliff[Heathcliff]:::Heathcliff : adopts

mr_l -> edgar[Edgar]:::Linton : parentOf
mrs_l -> edgar : parentOf
mr_l -> isabella[Isabella]:::Linton : parentOf
mrs_l -> isabella : parentOf

hindley -> frances[Frances]:::Earnshaw : spouse
catherine -> edgar : spouse
heathcliff -> isabella : spouse

hindley -> hareton[Hareton]:::Earnshaw : parentOf
frances -> hareton : parentOf
catherine -> cathy[Cathy Linton]:::Linton : parentOf
edgar -> cathy : parentOf
heathcliff -> linton[Linton Heathcliff]:::Heathcliff : parentOf
isabella -> linton : parentOf

cathy -> catherine : parentOf

cathy -> linton : spouse
cathy -> hareton : spouse

@orientation(selector=parentOf, directions=[below])
@orientation(selector=spouse, directions=[right])
@orientation(selector=adopts, directions=[below])
</div>

In Mermaid this is one more arrow, and the picture absorbs it without comment. Here the constraints have no satisfying layout, and the system says so. The right answer to "draw me a family where the daughter is her own grandmother" is not a cleverer drawing. It is that there isn't one.

That report is the same machinery run the other way. A solver that can find a layout satisfying your constraints can also tell you when none exists. I wouldn't sell it as a feature; it's a consequence. But it is the kind of consequence that shows the representation is doing real work. A drawing you can always produce tells you little. A layout that can fail to exist was constrained by something you actually said.

## What it is, and what it isn't

Spytial Graph is a browser-based notation for graph diagrams: you declare atoms, sorts, relations, and spatial constraints, and a solver lays them out. It borrows its spatial constraints from Spytial.

It is deliberately narrower than Mermaid, and it should be. Mermaid is broad on purpose — flowcharts, sequence diagrams, class diagrams, state diagrams, Gantt charts, and more. Spytial Graph is for the case where the diagram is a graph of domain objects whose arrangement *means* something: family trees, hash rings, dependency cycles, ownership graphs, service topologies, approval chains. When that is what you are drawing, the source should expose the objects, not the drawing of them.

## Why start here

For graph diagrams that mean something, I would start here rather than with Mermaid — not because Mermaid is bad, but because once the diagram is already text, already in the browser, already part of the workflow, the next question is unavoidable: why should the source stop at drawing instructions?

If the arrows mean something, the source should say what they mean. If generations are rows, that should be a constraint, not a coincidence of layout. If you edit the picture, the model should survive the edit. And if the facts cannot be arranged, the diagram should be able to say so.

Mermaid made diagrams cheap enough to keep. Spytial Graph is an attempt to make graph diagrams say enough to be worth trusting.

*The notation, source, and a playground are [on GitHub](https://github.com/sidprasad/spytial-graph).*

<script type="module">
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';
  mermaid.initialize({ startOnLoad: true });
</script>

<!-- One module tag turns every spytial-graph block above into a live diagram. It
     injects its engine (d3 v4 + WebCola + spytial-core) from the CDN on first load. -->
<script type="module" src="https://cdn.jsdelivr.net/npm/spytial-graph@0.0.4/src/auto.js"></script>
