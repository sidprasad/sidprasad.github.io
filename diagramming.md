---
layout: default
title: Diagramming by Refinement
---


# Diagramming by Refinement



## Cope and Drag

https://www.siddharthaprasad.com/copeanddrag/


### Related Publications

{% assign filtered_pubs = site.data.publications | where_exp: "pub", "pub.project == 'diagramming'" %}

{% for pub in filtered_pubs %}
#### {% if pub.paper_url %}
[{{ pub.title }}]({{ pub.paper_url }})
{% else %}
{{ pub.title }}
{% endif %}

{% if pub.blog_url %}[[Blog Post]]({{ pub.blog_url }}){% endif %}
{% if pub.code_url %}[[Code]]({{ pub.code_url }}){% endif %}

*{{ pub.authors }}*  
{% if pub.status %} {{ pub.status }} {% endif %} {{ pub.venue }}, _{{ pub.year }}_

{% endfor %}



