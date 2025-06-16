---
layout: default
title: Publications
---

<div class="publications-container">

{% assign grouped_pubs = site.data.publications | group_by: "year" | sort: "name" | reverse %}

{% for group in grouped_pubs %}
  <div class="publication-year-section">
    <!-- Sticky year on the left -->
    <div class="publication-year-sticky">
      {{ group.name }}
    </div>

    <!-- Publications for the year -->
    <div class="publication-list">
      {% for pub in group.items %}
      <div class="publication-card">
        <!-- Publication details -->
        <div>
          {% if pub.paper_url %}
            <h4 class="publication-title">
              <a href="{{ pub.paper_url }}">{{ pub.title }}</a>
              {% if pub.award %}
                <span class="award-medal"
                      tabindex="0"
                      onclick="this.nextElementSibling.classList.toggle('show-award');"
                      onkeypress="if(event.key==='Enter'||event.key===' '){this.click();}"
                      style="cursor:pointer;"
                      title="{{ pub.award | escape }}">
                  🏅
                </span>
                <span class="award-text">{{ pub.award }}</span>
              {% endif %}
            </h4>
          {% else %}
            <h4 class="publication-title">
              {{ pub.title }}
              {% if pub.award %}
                <span class="award-medal"
                      tabindex="0"
                      onclick="this.nextElementSibling.classList.toggle('show-award');"
                      onkeypress="if(event.key==='Enter'||event.key===' '){this.click();}"
                      style="cursor:pointer;"
                      title="{{ pub.award | escape }}">
                  🏅
                </span>
                <span class="award-text">{{ pub.award }}</span>
              {% endif %}
            </h4>
          {% endif %}
          <!-- Tags for blog and code -->
          <div class="publication-tags">
            {% if pub.blog_url %}
            <a href="{{ pub.blog_url }}" class="publication-tag blog">Blog Post</a>
            {% endif %}
            {% if pub.code_url %}
            <a href="{{ pub.code_url }}" class="publication-tag code">Code</a>
            {% endif %}

          </div>

          <p class="publication-details">
            <p class="publication-authors">
              {{ pub.authors | replace: "Siddhartha Prasad", "<strong>Siddhartha Prasad</strong>" }}
            </p>  
            <p>
            {% if pub.status %} <span class="publication-status">{{ pub.status }}</span> {% endif %}
            <span class="publication-venue">{{ pub.venue }}</span> {{pub.year}}
            </p>
          </p>


        </div>
      </div>
      {% endfor %}
    </div>
  </div>
{% endfor %}

</div>

<style>
.award-medal {
  margin-left: 0.4em;
  font-size: 1em;
  vertical-align: middle;
  transition: transform 0.2s;
}
.award-medal:hover, .award-medal:focus {
  transform: scale(1.2) rotate(-10deg);
  outline: none;
}
.award-text {
  display: none;
  margin-left: 0.5em;
  color: #b8860b;
  font-weight: 500;
  font-size: 0.95em;
}
.award-text.show-award {
  display: inline;
}
</style>