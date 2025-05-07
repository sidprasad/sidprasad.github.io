---
layout: default
title: Publications
---

# Publications

{% for pub in site.data.publications %}

#### {% if pub.paper_url %}
[{{ pub.title }}]({{ pub.paper_url }})
{% else %}
{{ pub.title }}
{% endif %}

{% if pub.blog_url %}[[Blog Post]]({{ pub.blog_url }}){% endif %}
{% if pub.code_url %}[[Code]]({{ pub.code_url }}){% endif %}

*{{ pub.authors }}*  
_{{ pub.venue }}, {{ pub.year }}_
{% if pub.status %} **{{ pub.status }}** {% endif %}

{% endfor %}