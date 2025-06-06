---
layout: default
title: Linear Temporal Logic
---

# Misconceptions in Linear Temporal Logic

I am part of a multi-year project to improve education in Linear Temporal Logic (LTL).
This has involved building a detailed understanding of 
typical misconceptions that learners and even experts have, building a [set of instruments](https://cs.brown.edu/~sk/Publications/Papers/Published/gpdzdkmnz-miscon-finite-infinite-ltl/) (think “quizzes”) that instructors can deploy in their classes to understand how well their students understand the logic and what weaknesses they have.


> *Eventually, I will understand LTL* 
{:.callout}

However, it isn’t always easy to add new materials to classes. Furthermore, your students make certain mistakes—now what? They need explanations of what went wrong, need additional drill problems, and need checks whether they got the additional ones right. It’s hard for an educator to make time for all that. And if one is an independent learner, they don’t even have access to such educators. Recognizing these practical difficulties, we have distilled our group’s expertise in LTL into an online tutor:

<div style="text-align: center; margin: 20px 0;">
  <a href="https://ltl-tutor.xyz" style="font-size: 1.2em; font-weight: bold; text-decoration: none; color: #007bff; padding: 10px 20px; border-radius: 8px; display: inline-block;">
    ltl-tutor.xyz
  </a>
</div>


This tutor leverages the idea of **Conceptual Mutation Testing** [^1] to generate questions by mutating LTL formulae modulo our understanding of LTL misconceptions.


[^1]: [Here's some work on conceptual mutation testing in a programming context](https://cs.brown.edu/~sk/Publications/Papers/Published/pgnk-conceptual-examplar/))

## Related Publications

{% assign filtered_pubs = site.data.publications | where_exp: "pub", "pub.project == 'ltl' or pub.project == 'conceptual-mutation-testing'" %}

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

