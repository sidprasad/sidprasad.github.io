---
layout: default
title: "CV : Siddhartha Prasad"
permalink: /cv/
---

{% assign cv = site.data.cv %}

<article class="cv-page">
  <div class="cv-download-rail">
    <div class="cv-download-stack">
      <a href="{{ '/cv.pdf' | relative_url }}" class="cv-download" download="cv-siddhartha-prasad.pdf" aria-label="Download Academic CV as a PDF"><span class="cv-download-icon" aria-hidden="true">↓</span>Academic CV</a>
      <a href="{{ '/resume.pdf' | relative_url }}" class="cv-download" download="resume-siddhartha-prasad.pdf" aria-label="Download Resume as a PDF"><span class="cv-download-icon" aria-hidden="true">↓</span>Resume</a>
    </div>
  </div>
  <header class="cv-document-header">
    <div class="cv-heading-row">
      <div>
        <h1>{{ cv.family_name }}, {{ cv.given_name }} - CV</h1>
        <p class="cv-contact">
          <a href="mailto:{{ cv.email }}">{{ cv.email }}</a>
        </p>
      </div>
      <div class="cv-actions">
        <span class="cv-updated">Updated <time datetime="{{ cv.updated_iso }}">{{ cv.updated }}</time></span>
      </div>
    </div>
    <p class="cv-tagline">{{ cv.tagline }}</p>
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
        {% if entry.advisor or entry.notes %}
          <p>
            {% if entry.advisor %}<span class="cv-advisor">Advisor: {{ entry.advisor }}</span>{% endif %}
            {% if entry.advisor and entry.notes %}<span class="cv-detail-separator" aria-hidden="true"> · </span>{% endif %}
            {% if entry.notes %}<span class="cv-note">{{ entry.notes }}</span>{% endif %}
          </p>
        {% endif %}
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
        {% if publication.publication_state == 'published' or publication.publication_state == 'in press' %}
          {% capture highlighted_name %}<em class="cv-me">{{ cv.name }}</em>{% endcapture %}
          {% assign author_list = publication.authors | replace: cv.name, highlighted_name %}
          <li class="cv-publication">
            <h3>
              {% if publication.paper_url %}<a href="{% if publication.paper_url contains '://' %}{{ publication.paper_url }}{% else %}{{ '/' | append: publication.paper_url | relative_url }}{% endif %}">{{ publication.title }}</a>{% else %}{{ publication.title }}{% endif %}
            </h3>
            <p class="cv-authors">{{ author_list }}</p>
            {% assign acronym = publication.venue_short | replace: '‹', '' | replace: '›', '' | replace: 'IEEE BigData', 'Big Data' %}
            {% capture highlighted_acronym %}<span class="cv-venue-short">{{ acronym }}</span>{% endcapture %}
            <p class="cv-venue">{% if publication.venue contains acronym %}{{ publication.venue | replace: acronym, highlighted_acronym }}{% else %}{{ publication.venue }} ({{ highlighted_acronym }}){% endif %}, {{ publication.year }}{% if publication.publication_state == 'in press' %} (in press){% endif %}</p>
            {% if publication.awards %}
              <p class="cv-award">[{% for award in publication.awards %}{% unless forloop.first %}; {% endunless %}{% assign award_label = award | replace: " Award", "" %}{% if award contains 'Distinguished Paper' %}<span class="cv-award-paper">{{ award_label }}</span>{% elsif award contains 'Distinguished Artifact' %}<span class="cv-award-artifact">{{ award_label }}</span>{% else %}{{ award_label }}{% endif %}{% endfor %}]</p>
            {% endif %}
          </li>
        {% endif %}
      {% endfor %}
    </ol>
  </section>

  <section class="cv-section" aria-labelledby="cv-talks">
    <h2 id="cv-talks">Invited Talks</h2>
    {% assign talk_groups = site.data.talks | group_by: "title" %}
    {% for group in talk_groups %}
      <div class="cv-employer cv-teaching-institution">
        <div class="cv-entry-heading cv-employer-heading">
          <h3>{{ group.name }}</h3>
        </div>
        {% for talk in group.items %}
          <div class="cv-entry cv-role">
            <div class="cv-role-heading">
              <p>{{ talk.venue }}</p>
              <span class="cv-dates">{{ talk.date | date: "%b %Y" }}</span>
            </div>
          </div>
        {% endfor %}
      </div>
    {% endfor %}
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

  <section class="cv-section" aria-labelledby="cv-mentorship">
    <h2 id="cv-mentorship">Mentorship</h2>
    <div class="cv-rows">
      {% for entry in cv.mentorship %}
        <div class="cv-row cv-row-two-column">
          <span class="cv-row-date">{{ entry.years }}</span>
          <span><strong>{{ entry.name }}</strong>, {{ entry.project }}<br><span class="cv-note">{{ entry.institution }}</span></span>
        </div>
      {% endfor %}
    </div>
  </section>

  <section class="cv-section" aria-labelledby="cv-service">
    <h2 id="cv-service">Service &amp; Volunteering</h2>
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
