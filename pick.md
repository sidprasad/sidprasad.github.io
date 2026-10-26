---
layout: default
title: "PICK: Human-in-the-Loop Checking of GenAI Synthesis"
---

## "What should my system do?"

Programmers increasingly rely on GenAI to translate informal requirements into logical formulae, security policies, and other formal specifications. This is convenient but risky: natural language is ambiguous, relevant domain knowledge is often unstated, and repeated prompts can yield different plausible outputs. PICK is a system for building confidence in these generated specifications by taking advantage of that variability. Rather than ask a model for a single answer, it collects several candidates and guides the programmer through an interactive process to determine which, if any, captures their intended behavior. For that interaction to be worthwhile, it must ask programmers questions they can understand, and it must not ask too many of them.

PICK's design rests on two observations. First, many of these specification languages are closed under negation and intersection, or have good heuristics for approximating these operations. This lets PICK compute the semantic differences between candidates and sample from them, so every scenario it shows is one on which plausible interpretations actually disagree. The questions stay few, and each one is decisive. Second, cognitive science shows that people reason more effectively about concrete instances than about abstract rules. So instead of comparing abstract formulae, programmers upvote and downvote these concrete scenarios. It is easier to decide whether a string should be accepted by your parser than to compare two complex grammars.


<table id="pick-tools" class="integration-links">
  <caption>Try PICK in VS Code</caption>
  <thead>
    <tr>
      <th scope="col">Domain</th>
      <th scope="col">VS Code Marketplace Link</th>
      <th scope="col">GitHub Link</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">Regex</th>
      <td><a href="https://marketplace.visualstudio.com/items?itemName=SiddharthaPrasad.pick-regex">VS Code Marketplace</a></td>
      <td><a href="https://github.com/sidprasad/pick-regex">GitHub</a></td>
    </tr>
    <tr>
      <th scope="row">LTL</th>
      <td><a href="https://marketplace.visualstudio.com/items?itemName=SiddharthaPrasad.pick-ltl">VS Code Marketplace</a></td>
      <td><a href="https://github.com/sidprasad/pick-ltl-vscode">GitHub</a></td>
    </tr>
  </tbody>
</table>

Across studies on regular expressions and access-control policies, PICK users identified the correct candidate, or recognized that none was correct, more accurately than those choosing among candidates directly. Even more strikingly, novices using PICK for Linear Temporal Logic performed as well as experts not using the tool.

{% assign research_pub = site.data.publications | where: "bib_key", "pick2026" | first %}
<div class="project-actions">
  <a class="project-action project-action-more" href="{{ research_pub.paper_url }}">Read the paper (ECOOP 2026)</a>
  <a class="project-action project-action-blog" href="{{ research_pub.blog_url }}">Main blog post: Human Judgment as a Specification</a>
</div>

