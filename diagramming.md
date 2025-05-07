---
layout: default
title: Diagramming by Refinement
---


# Diagramming by Refinement

*I will be a very happy camper once I can describe this well.*
For now, check out [Cope and Drag](https://www.siddharthaprasad.com/copeanddrag/), a system for diagramming by refinement for Forge.


## Related Publications

{% assign filtered_pubs = site.data.publications | where_exp: "pub", "pub.project == 'diagramming'" %}

<div class="publication-list">
{% for pub in filtered_pubs %}


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

        <p class="publication-details">
            <p class="publication-authors">
                {{ pub.authors | replace: "Siddhartha Prasad", "<strong>Siddhartha Prasad</strong>" }}
            </p>  
            <p>
                {% if pub.status %} <span class="publication-status">{{ pub.status }}</span> {% endif %}
                <span class="publication-venue">{{ pub.venue }}</span> {{pub.year}}
            </p>
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
</div>

