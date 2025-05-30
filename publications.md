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
        <!-- Publication details -->
        <div>
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
      </div>
      {% endfor %}
    </div>
  </div>
{% endfor %}

</div>