---
layout: default
title: Siddhartha Prasad
---


<img src="/assets/img/me.jpg" alt="Siddhartha Prasad" class="home-photo" />

I am a PhD candidate in Computer Science at Brown University, advised by [Shriram Krishnamurthi](https://cs.brown.edu/~sk/).

I am a PL/FM researcher interested in how formal representations make computational structure inspectable. Across my work, these representations take different forms: specifications, examples, temporal formulas, relational models, and runtime values. I study how people write them, run them, visualize them, learn from them, and revise them when their intent and the system's behavior diverge.

Previously, I was a software engineer at Microsoft, where I worked both on Windows[^1] and Azure[^2]. My research interests are informed by my time as an engineer. I have written code that doesn't do what I want it to, and I want to spare everyone else the indignity.

[^1]: I worked on the [XAML UI Framework](https://github.com/microsoft/microsoft-ui-xaml) from 2016-2018.
[^2]: I worked on [Azure's AI services](https://azure.microsoft.com/en-us/products/ai-services), with a particular focus on containerizing AI from 2018-2021.

<div class="job-market-callout" markdown="1">
**📣 On the job market.** I am seeking academic and research positions for **2027–28**. [Get in touch](mailto:siddhartha_prasad@brown.edu).
</div>


{% assign selected_pubs = site.data.publications | where_exp: "p", "p.selected" | sort: "selected" %}

{% if selected_pubs.size > 0 %}
<section class="selected-publications">
  <h3 class="selected-pubs-heading">Selected Publications</h3>
  <ul class="selected-pub-list">
    {% for pub in selected_pubs %}
    <li class="selected-pub">
      <div class="selected-pub-line1">
        <span class="selected-pub-title">{% if pub.paper_url %}<a href="{{ pub.paper_url }}">{{ pub.title }}</a>{% else %}{{ pub.title }}{% endif %}</span>
        {% if pub.awards %}{% for award in pub.awards %}<span class="award-badge">{{ award }}</span>{% endfor %}{% endif %}
      </div>
      <div class="selected-pub-meta">
        <span class="selected-pub-venue">{% if pub.venue_short %}{{ pub.venue_short }}{% else %}{{ pub.venue }}{% endif %} {{ pub.year }}</span>
        {% if pub.paper_url %}<a href="{{ pub.paper_url }}">PDF</a>{% endif %}
        {% if pub.blog_url %}<a href="{{ pub.blog_url }}">Blog</a>{% endif %}
        {% if pub.code_url %}<a href="{{ pub.code_url }}">Code</a>{% endif %}
        {% if pub.tool_url %}<a href="{{ pub.tool_url }}">Tool</a>{% endif %}
      </div>
    </li>
    {% endfor %}
  </ul>
  <a href="/publications" class="selected-pubs-all">See all publications →</a>
</section>
{% endif %}


{% comment %} Unified Recent News feed: talks + paper acceptances + awards, time-sorted.
   Each entry is "<YYYYMMDD sortkey>@@@<card html>"; we sort the strings (fixed-width
   numeric prefix => chronological) and reverse for newest-first. {% endcomment %}
{% assign today = site.time | date: "%Y-%m-%d" %}
{% assign feed = "" | split: "" %}

{% for talk in site.data.talks %}
  {% assign sortkey = talk.date | date: "%Y%m%d" %}
  {% assign td = talk.date | date: "%Y-%m-%d" %}
  {% capture card %}<article class="talk-card"><div class="talk-meta"><span class="talk-type talk-type-talk">Talk</span><span class="talk-date">{{ talk.date | date: "%b %-d, %Y" }}{% if td >= today %} <span class="talk-upcoming">Upcoming</span>{% endif %}</span></div><div class="talk-title">{{ talk.title }}</div><div class="talk-venue">{% if talk.venue_short %}{{ talk.venue_short }}{% else %}{{ talk.venue }}{% endif %}</div>{% if talk.video_url or talk.slides_url %}<div class="talk-links">{% if talk.video_url %}<a href="{{ talk.video_url }}" class="talk-link">Video</a>{% endif %}{% if talk.slides_url %}<a href="{{ talk.slides_url }}" class="talk-link">Slides</a>{% endif %}</div>{% endif %}</article>{% endcapture %}
  {% capture entry %}{{ sortkey }}@@@{{ card }}{% endcapture %}
  {% assign one = entry | split: "###NEVER###" %}
  {% assign feed = feed | concat: one %}
{% endfor %}

{% assign recent_pubs = site.data.publications | where_exp: "p", "p.year >= 2025" %}
{% for pub in recent_pubs %}
  {% assign sortkey = pub.year | append: "1215" %}
  {% capture card %}<article class="talk-card"><div class="talk-meta"><span class="talk-type talk-type-paper">Paper</span><span class="talk-date">{{ pub.venue_short }} {{ pub.year }}{% if pub.status %} <span class="talk-upcoming">{{ pub.status }}</span>{% endif %}</span></div><div class="talk-title">{% if pub.paper_url %}<a href="{{ pub.paper_url }}">{{ pub.title }}</a>{% else %}{{ pub.title }}{% endif %}</div><div class="talk-venue">{{ pub.venue }}</div>{% if pub.paper_url or pub.blog_url or pub.code_url or pub.tool_url %}<div class="talk-links">{% if pub.paper_url %}<a href="{{ pub.paper_url }}" class="talk-link">PDF</a>{% endif %}{% if pub.blog_url %}<a href="{{ pub.blog_url }}" class="talk-link">Blog</a>{% endif %}{% if pub.code_url %}<a href="{{ pub.code_url }}" class="talk-link">Code</a>{% endif %}{% if pub.tool_url %}<a href="{{ pub.tool_url }}" class="talk-link">Tool</a>{% endif %}</div>{% endif %}</article>{% endcapture %}
  {% capture entry %}{{ sortkey }}@@@{{ card }}{% endcapture %}
  {% assign one = entry | split: "###NEVER###" %}
  {% assign feed = feed | concat: one %}
  {% if pub.awards %}{% for award in pub.awards %}
    {% assign sortkey = pub.year | append: "1220" %}
    {% capture card %}<article class="talk-card"><div class="talk-meta"><span class="talk-type talk-type-award">Award</span><span class="talk-date">{{ pub.venue_short }} {{ pub.year }}</span></div><div class="talk-title">{{ award }}</div><div class="talk-venue">{{ pub.title }}</div></article>{% endcapture %}
    {% capture entry %}{{ sortkey }}@@@{{ card }}{% endcapture %}
    {% assign one = entry | split: "###NEVER###" %}
    {% assign feed = feed | concat: one %}
  {% endfor %}{% endif %}
{% endfor %}

{% assign feed = feed | sort | reverse %}

{% if feed.size > 0 %}
<section class="talks-widget">
  <h3 class="talks-heading">Recent News</h3>
  <div class="talks-carousel">
    <button type="button" class="talks-nav prev" aria-label="Previous">‹</button>
    <div class="talks-track">
      {% for item in feed %}{% assign parts = item | split: "@@@" %}{{ parts[1] }}{% endfor %}
    </div>
    <button type="button" class="talks-nav next" aria-label="Next">›</button>
  </div>
</section>
{% endif %}


<!--
<div class="project-list mb-5">

  <a href="/diagramming" class="project-card-link">
    <div class="project-card">
      <h3 class="project-title">Diagramming and Spatiality</h3>
      <p class="project-description">
      The most important aspect of a diagram is how it is spatially arranged, not its aesthetic rendering. I am interested in understanding the spatial operations that are needed to build useful diagrams.
      </p>
    </div>
  </a>

  <a href="/lineartemporallogic" class="project-card-link">
    <div class="project-card">
      <h3 class="project-title">Linear Temporal Logic</h3>
      <p class="project-description">
        This project involves understanding and addressing misconceptions that
        practioners have when working in LTL.
      </p>
    </div>
  </a>


  <a href="https://forge-fm.org" class="project-card-link">
    <div class="project-card">
      <h3 class="project-title">Forge</h3>
      <p class="project-description">Forge is a sibling of the Alloy language designed with 
      pedagogy in mind. Key features include a gradual progression of (sub)languages,
      unit testing for logical predicates, and support for domain-specific visualizations.

</p>
    </div>
  </a>

  <a href="https://blog.brownplt.org/2024/01/01/examplar.html" class="project-card-link">
    <div class="project-card">
      <h3 class="project-title">Examplar</h3>
      <p class="project-description"> An IDE for Pyret that helps students check their understanding early by letting them write input–output examples and get instant feedback on whether these example suites are valid and thorough.
      </p>
    </div>
  </a>

</div>
-->








<!-- - I'm particularly proud of my formalization of [Kleene Algebra](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Algebra/Order/Kleene.html) as part of the Lean Mathlib project.
- I try to be involved with the New England Programming Languages community(see talks at [NEPLS 2025](https://nepls.org/Events/34/abstracts.html#prasad), [Racket Con 2022](https://con.racket-lang.org/2022/)) -->
