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
        <h4 class="publication-title">
          {% if pub.paper_url %}
            <a href="{{ pub.paper_url }}">{{ pub.title }}</a>
          {% else %}
            {{ pub.title }}
          {% endif %}
        </h4>

        <!-- Tags for blog and code -->
        <div class="publication-tags">
          {% if pub.blog_url %}
          <a href="{{ pub.blog_url }}" class="publication-tag blog">Blog Post</a>
          {% endif %}
          {% if pub.code_url %}
          <a href="{{ pub.code_url }}" class="publication-tag code">Code</a>
          {% endif %}
          {% if pub.tool_url %}
          <a href="{{ pub.tool_url }}" class="publication-tag tool">Tool</a>
          {% endif %}
        </div>

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
  </div>
{% endfor %}

</div>
