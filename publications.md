---
layout: default
title: Publications
---

{% assign grouped_pubs = site.data.publications | group_by: "year" | sort: "name" | reverse %}

{% for group in grouped_pubs %}
### {{ group.name }} <!-- Year as a header -->

{% for pub in group.items %}
{% if pub.paper_url %}
#### [{{ pub.title }}]({{ pub.paper_url }})
{% else %}
#### {{ pub.title }}
{% endif %}



{% if pub.blog_url %}
<span style="display: inline-block; background-color: #d1e7dd; color: #0f5132; padding: 2px 6px; border-radius: 12px; margin-left: 5px;">
  <a href="{{ pub.blog_url }}" style="text-decoration: none; color: inherit;">Blog Post</a>
</span>
{% endif %}

{% if pub.code_url %}
<span style="display: inline-block; background-color: #cfe2ff; color: #084298; padding: 2px 6px; border-radius: 12px; margin-left: 5px;">
  <a href="{{ pub.code_url }}" style="text-decoration: none; color: inherit;">Code</a>
</span>
{% endif %}

*{{ pub.authors }}*  
{% if pub.status %} {{ pub.status }} {% endif %} {{ pub.venue }}, _{{ pub.year }}_

{% endfor %}
{% endfor %}