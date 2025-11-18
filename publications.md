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
        <div class="publication-card-inner">
          <!-- Left side: main publication info -->
          <div class="publication-main">
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
            </div>

            <p class="publication-details">
              <p class="publication-authors">
                {{ pub.authors | replace: "Siddhartha Prasad", "<strong>Siddhartha Prasad</strong>" }}
              </p>  
              <p>
              {% if pub.status %} <span class="publication-status">{{ pub.status }}</span> {% endif %}
              <span class="publication-venue">{{ pub.venue }}</span> {{pub.year}}
              </p>
            </p>
          </div>

          <!-- Right side: awards (if any) -->
          {% if pub.awards %}
          <div class="publication-awards-sidebar">
            {% for award in pub.awards %}
              <div class="award-item">{{ award }}</div>
            {% endfor %}
          </div>
          {% endif %}
        </div>
      </div>
      {% endfor %}
    </div>
  </div>
{% endfor %}

</div>

<style>
.publication-card-inner {
  display: flex;
  gap: 24px;
  align-items: flex-start;
}

.publication-main {
  flex: 1;
  min-width: 0; /* allows text to wrap properly */
}

.publication-awards-sidebar {
  flex-shrink: 0;
  width: 200px;
  padding: 8px 12px;
  background: #fff8e6;
  border-left: 3px solid #b8860b;
  border-radius: 4px;
  font-size: 0.9em;
}

.award-item {
  color: #7a5c00;
  font-weight: 500;
  margin: 4px 0;
  line-height: 1.4;
}
</style>