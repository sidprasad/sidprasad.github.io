---
layout: default
title: "CV : Siddhartha Prasad"
permalink: /cv/
---

{% assign cv = site.data.cv %}

<article class="cv-page">
  <div class="cv-download-rail">
    <div class="cv-download-stack">
      <a href="{{ '/cv.pdf' | relative_url }}" class="cv-download" download="cv-siddhartha-prasad.pdf">Download Full Academic CV as PDF</a>
      <a href="{{ '/resume.pdf' | relative_url }}" class="cv-download" download="resume-siddhartha-prasad.pdf">Download Resume as PDF</a>
    </div>
  </div>
  <header class="cv-document-header">
    <div class="cv-heading-row">
      <div>
        <h1>{{ cv.name }}</h1>
        <p class="cv-contact">
          <a href="mailto:{{ cv.email }}">{{ cv.email }}</a>
        </p>
      </div>
      <div class="cv-actions">
        <span class="cv-updated">Updated <time datetime="{{ cv.updated_iso }}">{{ cv.updated }}</time></span>
      </div>
    </div>
    <p class="cv-summary">{{ cv.summary }}</p>
  </header>

  <section class="cv-section" aria-labelledby="cv-education">
    <h2 id="cv-education">Education</h2>
    {% for entry in cv.education %}
      <div class="cv-entry cv-education-entry">
        <div class="cv-entry-heading">
          <h3>{{ entry.institution }}</h3>
          <span class="cv-location">{{ entry.location }}</span>
          <span class="cv-dates">{{ entry.dates }}</span>
        </div>
        <p>{{ entry.degree }}</p>
        {% if entry.notes %}<p class="cv-note">{{ entry.notes }}</p>{% endif %}
      </div>
    {% endfor %}
  </section>

  <section class="cv-section" aria-labelledby="cv-employment">
    <h2 id="cv-employment">Employment</h2>
    {% for employer in cv.employment %}
      <div class="cv-employer">
        <div class="cv-entry-heading cv-employer-heading">
          <h3>{{ employer.organization }}</h3>
          <span class="cv-location">{{ employer.location }}</span>
        </div>
        {% for role in employer.roles %}
          <div class="cv-entry cv-role">
            <div class="cv-role-heading">
              <p><em>{{ role.title }}{% if role.team %} <span aria-hidden="true">·</span> {{ role.team }}{% endif %}</em></p>
              <span class="cv-dates">{{ role.dates }}</span>
            </div>
            {% if role.description %}<p>{{ role.description }}</p>{% endif %}
            {% if role.bullets %}
              <ul>
                {% for item in role.bullets %}<li>{{ item }}</li>{% endfor %}
              </ul>
            {% endif %}
          </div>
        {% endfor %}
      </div>
    {% endfor %}
  </section>

  <section class="cv-section" aria-labelledby="cv-publications">
    <h2 id="cv-publications">Publications</h2>
    <ol class="cv-publications">
      {% for title in cv.publications %}
        {% assign matches = site.data.publications | where: "title", title %}
        {% assign publication = matches | first %}
        {% if publication %}
          {% capture highlighted_name %}<em class="cv-me">{{ cv.name }}</em>{% endcapture %}
          {% assign author_list = publication.authors | replace: cv.name, highlighted_name %}
          <li class="cv-publication">
            <h3>
              {% if publication.paper_url %}<a href="{% if publication.paper_url contains '://' %}{{ publication.paper_url }}{% else %}{{ '/' | append: publication.paper_url | relative_url }}{% endif %}">{{ publication.title }}</a>{% else %}{{ publication.title }}{% endif %}, <strong class="cv-venue">{{ publication.venue_short }} {{ publication.year }}</strong>
            </h3>
            {% if publication.awards %}<p class="cv-award">[{{ publication.awards | join: "; " | replace: " Award", "" }}]</p>{% endif %}
            <p class="cv-authors">{{ author_list }}</p>
          </li>
        {% endif %}
      {% endfor %}
    </ol>
  </section>

  <section class="cv-section" aria-labelledby="cv-teaching">
    <h2 id="cv-teaching">Teaching</h2>
    {% for institution in cv.teaching %}
      <div class="cv-employer cv-teaching-institution">
        <div class="cv-entry-heading cv-employer-heading">
          <h3>Teaching Assistant, <strong>{{ institution.institution }}</strong></h3>
        </div>
        {% for course in institution.courses %}
          <div class="cv-entry cv-role">
            <div class="cv-role-heading">
              <p>{{ course.course }}</p>
              <span class="cv-dates">{{ course.years }}</span>
            </div>
          </div>
        {% endfor %}
      </div>
    {% endfor %}
  </section>

  <section class="cv-section" aria-labelledby="cv-service">
    <h2 id="cv-service">Service</h2>
    <div class="cv-rows">
      {% for entry in cv.service %}
        <div class="cv-row cv-row-two-column">
          <span class="cv-row-date">{{ entry.years }}</span>
          <span>{{ entry.description }}</span>
        </div>
      {% endfor %}
    </div>
  </section>

  <section class="cv-section" aria-labelledby="cv-affiliations">
    <h2 id="cv-affiliations">Affiliations &amp; Certifications</h2>
    <div class="cv-rows">
      {% for entry in cv.affiliations %}
        <div class="cv-row cv-row-affiliation">
          <span>{{ entry.description }}</span>
          <span class="cv-row-institution">{{ entry.institution }}</span>
        </div>
      {% endfor %}
    </div>
  </section>
</article>
