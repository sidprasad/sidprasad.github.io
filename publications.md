---
layout: default
title: Publications
---

<div style="display: flex; flex-direction: column; gap: 20px;">

{% assign grouped_pubs = site.data.publications | group_by: "year" | sort: "name" | reverse %}

{% for group in grouped_pubs %}
  {% for pub in group.items %}
  <div style="display: flex; align-items: flex-start; gap: 20px; border: 1px solid #ddd; border-radius: 8px; padding: 10px; background-color: #f9f9f9;">
    <!-- Year on the left -->
    <div style="flex-shrink: 0; font-size: 1.2em; font-weight: bold; color: #555; width: 60px; text-align: center;">
      {{ pub.year }}
    </div>

    <!-- Publication details -->
    <div>
      <h4 style="margin: 0;">
        {% if pub.paper_url %}
        <a href="{{ pub.paper_url }}" style="text-decoration: none; color: #007bff;">{{ pub.title }}</a>
        {% else %}
        {{ pub.title }}
        {% endif %}
      </h4>

      <p style="margin: 5px 0; font-size: 0.9em; color: #555;">
        *{{ pub.authors }}*  
        {% if pub.status %} {{ pub.status }} {% endif %} {{ pub.venue }}
      </p>

      <!-- Tags for blog and code -->
      <div style="margin-top: 5px;">
        {% if pub.blog_url %}
        <span style="display: inline-block; background-color: #d1e7dd; color: #0f5132; padding: 5px 10px; border-radius: 12px; margin-right: 10px;">
          <a href="{{ pub.blog_url }}" style="text-decoration: none; color: inherit;">Blog Post</a>
        </span>
        {% endif %}
        {% if pub.code_url %}
        <span style="display: inline-block; background-color: #cfe2ff; color: #084298; padding: 5px 10px; border-radius: 12px;">
          <a href="{{ pub.code_url }}" style="text-decoration: none; color: inherit;">Code</a>
        </span>
        {% endif %}
      </div>
    </div>
  </div>
  {% endfor %}
{% endfor %}

</div>