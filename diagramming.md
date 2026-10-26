---
layout: default
title: "Spytial: Diagramming By Refinement"
---

# Spytial: Diagramming By Refinement

Spytial is a language for diagram-guided inspection built around the observation that structured values already have an implicit graph structure. Their constituent values become nodes, and relationships among them become edges. That graph determines what there is to draw, so programmers can get a complete structural view before writing any diagramming rules. This turns diagramming into a specification problem over how those elements should be laid out.

{% assign research_pub = site.data.publications | where: "bib_key", "spytial2026" | first %}
{% include publication-card.html pub=research_pub %}

Informed by cognitive science research, the language's vocabulary lets programmers constrain relative spatial relationships between diagram elements rather than specify explicit coordinates. A constraint solver fills in the rest. The value remains the source of truth, so information cannot disappear unless explicitly hidden. Rules refine a shared space of possible layouts, so they compose without ordering effects. When requirements conflict, the system reports the conflict and presents a counterfactual diagram that shows it in the context of the rest of the value.

Spytial is used in many diagramming contexts. Learn about them below.

<details class="project-context" id="making-diagrams-as-cheap-as-printf" markdown="1">
<summary><h2>Making diagrams as cheap as printf.</h2></summary>

Every time you inspect a value (at the REPL, in a debugger, in a print statement) you should have the *option* of seeing a diagram.

Spytial is currently integrated with:

| Language | Try / install |
| --- | --- |
| [Python](https://www.siddharthaprasad.com/spytial/) | [Try it online](https://www.siddharthaprasad.com/spytial/playground/) or install via `pip install spytial-diagramming` |
| [Rust](https://sidprasad.github.io/spytial-rust/) | Install via `cargo add spytial` |
| [Lean](https://github.com/sidprasad/spytial-lean) | [Install as a Lake dependency](https://github.com/sidprasad/spytial-lean#installation) |
| [Pyret](https://github.com/sidprasad/spyret) | [Try it online](https://www.siddharthaprasad.com/spyret-ide/#draft=f8ee4ca7-3668-459a-a61f-2ff44814894a) |
{: .integration-links}

[Full list of integrations + how to integrate with your language →](https://www.siddharthaprasad.com/spytial-core/#/integrations)

You can also see Spytial at work in a collection of data-structure visualizations drawn from the classic algorithms textbook *Introduction to Algorithms* by Cormen, Leiserson, Rivest, and Stein: [spytial-clrs.netlify.app](https://spytial-clrs.netlify.app/).
{: .callout}

</details>

<details class="project-context" id="cope-and-drag-spytial-for-lightweight-formal-methods" markdown="1">
<summary><h2>Lightweight Diagramming for Lightweight Formal Methods</h2></summary>

Formal methods tools like [Alloy](https://alloytools.org/) and [Forge](https://forge-fm.org/) help users define, explore, verify, and diagnose specifications for complex systems incrementally. A crucial feature of these tools is their visualizer, which lets users explore generated models through graphical representations.

In some cases, they suffer from familiar usability issues—such as overlapping lines, unclear labels, or cluttered layouts—that make it hard to understand what the model represents. But even when the diagrams are clean and well-organized, they can still be confusing if the layout doesn’t reflect the structure **that users expect**.

[Cope and Drag](https://www.siddharthaprasad.com/copeanddrag/) is a visualizer built atop Spytial that lets users express those expectations as spatial requirements. Users can specify that children appear below their parents, related objects align, or a collection of objects forms a group. The visualizer finds a layout that satisfies these requirements, starting from the atoms and relations already supplied by the model.

Users can refine the view as they explore their specification, without writing a custom visualizer. When spatial requirements conflict with a model, Cope and Drag reports the conflict, helping users investigate why the model cannot be arranged as expected.

{% assign research_pub = site.data.publications | where: "bib_key", "cnd2025" | first %}
{% include publication-card.html pub=research_pub %}

Cope and Drag is available as a visualizer for both [Forge](https://marketplace.visualstudio.com/items?itemName=SiddharthaPrasad.forge-fm) and [Alloy](https://marketplace.visualstudio.com/items?itemName=SiddharthaPrasad.cope-and-drag-alloy). See the [guide](https://www.siddharthaprasad.com/copeanddrag/) or explore the [source code](https://github.com/sidprasad/copeanddrag).

</details>

<details class="project-context" id="graph-drawing-in-the-browser-with-semantics" markdown="1">
<summary><h2>Graph Drawing in the Browser (With Semantics!)</h2></summary>

Have you ever described a Mermaid or DOT graph, only to have it laid out all wrong?

Spytial-GDL pairs the familiar node-and-edge syntax of these graph description languages with lightweight layout requirements. Generated graphs are interactive, letting you drag nodes anywhere that does not violate your layout requirements.

<div class="project-actions">
  <strong>Try it out!</strong>
  <a class="project-action project-action-tool" href="https://www.siddharthaprasad.com/spytial-gdl/playground/">Open the playground →</a>
  <a class="project-action project-action-more" href="https://www.siddharthaprasad.com/spytial-gdl/">Explore Spytial-GDL →</a>
</div>

</details>
