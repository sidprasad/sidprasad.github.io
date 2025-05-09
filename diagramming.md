---
layout: default
title: Diagramming by Refinement
---


# Diagramming by Spatial Refinement

I am very interested in **diagrams**, especially
when it comes to how they enable [thinking](https://www.researchgate.net/publication/232083479_Thinking_with_Sketches), [theorizing](https://www.activityanalysis.net/method-diagramming-as-theorizing/), [exploration](https://onlinelibrary.wiley.com/doi/epdf/10.1111/j.1551-6708.1987.tb00863.x),  and communication. 

> “Spatial thinking is the foundation of abstract thought” - B Tversky

The most important part of a diagram deals with how it is spatially laid out, 
not finer details of aesthetic rendering. This project involves identifying, exploring, and implementing a set of core **spatial** operations that can be combined to refine default system output into *useful* (not pretty) diagrams. I believe that this core ethos broadly applies across various contexts, including:


**Lightweight Formal Methods** : The [Cope and Drag](https://www.siddharthaprasad.com/copeanddrag/) allows users to refine [Forge](https://forge-fm.org/) output into domain specific diagrams.


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

