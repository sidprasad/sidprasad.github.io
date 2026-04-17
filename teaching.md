---
layout: default
title: Teaching
---

# Teaching

I have been a teaching assistant for courses on programming languages, formal methods, and algorithms at Brown and Tufts. Much of my research also engages directly with computing education.


## Teaching Certification

- **Sheridan Teaching Seminar Certificate**, Brown University (2023)

## Teaching Experience

### Brown University

<div class="course-list">
  <div class="course-entry">
    <a class="course-code" href="https://csci1710.github.io/2026/" target="_blank" rel="noopener">CSCI 1710</a>
    <span class="course-title">Logic for Systems</span>
    <span class="course-meta">Teaching Assistant &middot; 2022&ndash;2026</span>
  </div>
  <div class="course-entry">
    <a class="course-code" href="https://cs.brown.edu/courses/cs173/" target="_blank" rel="noopener">CSCI 1730</a>
    <span class="course-title">Programming Languages</span>
    <span class="course-meta">Teaching Assistant &middot; 2025</span>
  </div>
</div>

### Tufts University

<div class="course-list">
  <div class="course-entry">
    <a class="course-code" href="https://www.cs.tufts.edu/comp/105/" target="_blank" rel="noopener">CS 105</a>
    <span class="course-title">Programming Languages</span>
    <span class="course-meta">Teaching Assistant &middot; 2015&ndash;2016</span>
  </div>
  <div class="course-entry">
    <a class="course-code" href="https://www.cs.tufts.edu/comp/160/" target="_blank" rel="noopener">CS 160</a>
    <span class="course-title">Introduction to Algorithms</span>
    <span class="course-meta">Teaching Assistant &middot; 2014</span>
  </div>
</div>



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
          <span class="award-badge">{{ award }}</span>
        {% endfor %}
      </span>
      {% endif %}
    </div>
  </div>
{% endfor %}
</div>
