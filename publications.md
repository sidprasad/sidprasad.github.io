---
layout: default
title: Publications
---

<h1>Publications</h1>

<ul class="list-group">
  {% for pub in site.data.publications %}
    <li class="list-group-item">
      <strong>{{ pub.title }}</strong><br>
      {% if pub.paper_url %}<a href="{{ pub.paper_url }}">[Paper]</a>{% endif %}
      {% if pub.blog_url %}<a href="{{ pub.blog_url }}">[Blog Post]</a>{% endif %}
      {% if pub.code_url %}<a href="{{ pub.code_url }}">[Code]</a>{% endif %}
      <em>{{ pub.authors }}</em><br>
      {{ pub.venue }}, {{ pub.year }}<br>

    </li>
  {% endfor %}
</ul>