---
layout: default
title: Publications
---

<div class="publications-container">

{% assign grouped_pubs = site.data.publications | group_by: "year" | sort: "name" | reverse %}

{% for group in grouped_pubs %}
  {% for pub in group.items %}
  <div class="publication-card">
    <!-- Year on the left -->
    <div class="publication-year">
      {{ pub.year }}
    </div>

    <!-- Publication details -->
    <div>
      <h4 class="publication-title">
        {% if pub.paper_url %}
        <a href="{{ pub.paper_url }}">{{ pub.title }}</a>
        {% else %}
        {{ pub.title }}
        {% endif %}
      </h4>

      <p class="publication-details">
        *{{ pub.authors }}*  
        {% if pub.status %} {{ pub.status }} {% endif %} {{ pub.venue }}
      </p>

      <!-- Tags for blog and code -->
      <div class="publication-tags">
        {% if pub.blog_url %}
        <a href="{{ pub.blog_url }}" class="publication-tag blog">Blog Post</a>
        {% endif %}
        {% if pub.code_url %}
        <a href="{{ pub.code_url }}" class="publication-tag code">Code</a>
        {% endif %}
      </div>
    </div>
  </div>
  {% endfor %}
{% endfor %}

</div>