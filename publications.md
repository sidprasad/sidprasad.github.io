---
layout: default
title: Publications
---


{% assign grouped_pubs = site.data.publications | group_by: "year" | sort: "name" | reverse %}

{% for group in grouped_pubs %}
### {{ group.name }} <!-- Year as a header -->

{% for pub in group.items %}
{% if pub.paper_url %}
####  [{{ pub.title }}]({{ pub.paper_url }})
{% else %}
####  {{ pub.title }}
{% endif %}

{% if pub.blog_url %}[[Blog Post]]({{ pub.blog_url }}){% endif %}
{% if pub.code_url %}[[Code]]({{ pub.code_url }}){% endif %}

*{{ pub.authors }}*  
**{{ pub.venue }}**, _{{pub.year}}_
{% if pub.status %} **{{ pub.status }}** {% endif %}

{% endfor %}
{% endfor %}