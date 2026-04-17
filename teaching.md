---
layout: default
title: Teaching
---

# Teaching

I have been a teaching assistant for courses on programming languages, formal methods, and algorithms at Brown and Tufts. Much of my research also engages directly with computing education.

## Teaching Experience

### Brown University
- **CSCI 1710** &mdash; Logic for Systems (Teaching Assistant, 2022&ndash;2026)
- **CSCI 1730** &mdash; Programming Languages (Teaching Assistant, 2025)

### Tufts University
- **CS 105** &mdash; Programming Languages (Teaching Assistant, 2015&ndash;2016)
- **CS 160** &mdash; Algorithms (Teaching Assistant, 2014)

## Teaching Certification

- **Sheridan Teaching Seminar Certificate**, Brown University (2023)

## Research in Computing Education

Much of my research engages directly with computing education &mdash; building teaching tools, studying misconceptions, and developing assessment instruments.

{% assign teaching_pubs = site.data.publications | where_exp: "pub", "pub.project == 'forge' or pub.project == 'conceptual-mutation-testing' or pub.project == 'ltl'" %}

<div class="publication-list">
{% for pub in teaching_pubs %}
  <div class="publication-card">
    <h4 class="publication-title">
      {% if pub.paper_url %}
        <a href="{{ pub.paper_url }}">{{ pub.title }}</a>
      {% else %}
        {{ pub.title }}
      {% endif %}
    </h4>

    <p class="publication-authors">
      {{ pub.authors | replace: "Siddhartha Prasad", "<strong>Siddhartha Prasad</strong>" }}
    </p>

    <div class="publication-meta">
      <span class="publication-venue-info">
        {% if pub.venue_short %}
          <span class="publication-venue" title="{{ pub.venue }}">{{ pub.venue_short }}</span>
        {% else %}
          <span class="publication-venue">{{ pub.venue }}</span>
        {% endif %}
        {{ pub.year }}
      </span>

      {% if pub.awards %}
      <span class="publication-awards">
        {% for award in pub.awards %}
          <span class="award-badge"><span class="award-icon">🏆</span>{{ award }}</span>
        {% endfor %}
      </span>
      {% endif %}
    </div>
  </div>
{% endfor %}
</div>
