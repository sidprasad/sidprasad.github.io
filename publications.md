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

{% if pub.blog_url %}[[Blog Post]]({{ pub.blog_url }}){% endif %}
{% if pub.code_url %}[[Code]]({{ pub.code_url }}){% endif %}

*{{ pub.authors }}*  
{% if pub.status %} {{ pub.status }} {% endif %} {{ pub.venue }}, _{{ pub.year }}_

{% if pub.project %}
<span style="display: inline-block; background-color: #e0e0e0; color: #333; padding: 2px 6px; border-radius: 12px; font-size: 0.8em; margin-left: 5px;">
  {{ pub.project }}
</span>
{% endif %}

{% endfor %}
{% endfor %}