---
layout: default
title: Publications
---

<div class="publications-container">

{% assign grouped_pubs = site.data.publications | group_by: "year" | sort: "name" | reverse %}

{% for group in grouped_pubs %}
  <div class="publication-year-section">
    <!-- Sticky year on the left -->
    <div class="publication-year-sticky">
      {{ group.name }}
    </div>

    <!-- Publications for the year -->
    <div class="publication-list">
      {% for pub in group.items %}
      <div class="publication-card">
        {% if pub.awards %}
        <div class="publication-awards">
          {% for award in pub.awards %}
            <span class="award-badge">{{ award }}</span>
          {% endfor %}
        </div>
        {% endif %}

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
            {% if pub.status %}<span class="publication-status">{{ pub.status }}</span>{% endif %}
            {% if pub.venue_short %}
              <span class="publication-venue" title="{{ pub.venue }}">{{ pub.venue_short }}</span>
            {% else %}
              <span class="publication-venue">{{ pub.venue }}</span>
            {% endif %}
            <span class="publication-year">{{ pub.year }}</span>
          </span>
        </div>

        {% if pub.blog_url or pub.code_url or pub.tool_url %}
        <div class="publication-tags">
          {% if pub.blog_url %}
          <a href="{{ pub.blog_url }}" class="publication-tag">Blog</a>
          {% endif %}
          {% if pub.code_url %}
          <a href="{{ pub.code_url }}" class="publication-tag">Code</a>
          {% endif %}
          {% if pub.tool_url %}
          <a href="{{ pub.tool_url }}" class="publication-tag">Tool</a>
          {% endif %}
        </div>
        {% endif %}
      </div>
      {% endfor %}
    </div>
  </div>
{% endfor %}

</div>
