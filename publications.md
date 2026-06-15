---
layout: default
title: Publications
---

<div class="publications-container">

{% assign grouped_pubs = site.data.publications | group_by: "year" | sort: "name" | reverse %}

{% for group in grouped_pubs %}
  <div class="publication-year-section">
    <div class="publication-year-sticky">{{ group.name }}</div>

    <div class="publication-list">
      {% for pub in group.items %}
      {% include publication-card.html pub=pub %}
      {% endfor %}
    </div>
  </div>
{% endfor %}

</div>
