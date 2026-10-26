// CV — Siddhartha Prasad
// Compile from this directory with: make

#let cv = yaml("../_data/cv.yml")
#let all-publications = yaml("../_data/publications.yml")
#let talks = yaml("../_data/talks.yml")
#let publications = cv.publications.map(title => {
  let publication = all-publications.find(item => item.title == title)
  assert(publication != none, message: "CV publication not found: " + title)
  assert(publication.publication_state == "published" or publication.publication_state == "in press",
    message: "CV publication is neither published nor in press: " + title)
  publication
})

// Running header, in the "Last Name, First Name - CV" form that application
// portals ask for.
#let running-header = cv.family_name + ", " + cv.given_name + " - CV"

#let accent = rgb("#7b1f1f")
#let award-text-color = rgb("#145b75")
#let rule-color = rgb("#b8b0a8")
#let muted = rgb("#6b6b6b")
#let header-color = rgb("#3a3a3a")
#let date-column = 7em

#set document(
  title: running-header,
  author: cv.name,
  description: [Curriculum Vitae],
  keywords: (
    "Siddhartha Prasad",
    "Curriculum Vitae",
    "Computer Science",
    "Programming Languages",
    "Formal Methods",
    "Human-Computer Interaction",
  ),
)
#set page(
  paper: "us-letter",
  margin: (x: 0.85in, y: 0.8in),
  header: grid(
    columns: (1fr, auto),
    column-gutter: 1em,
    text(size: 9pt, fill: header-color, running-header),
    text(size: 8.5pt, style: "italic", fill: muted)[Updated #cv.updated],
  ),
  footer: context {
    align(right, text(size: 8.5pt, fill: muted)[#counter(page).display()])
  },
)
#set text(
  font: ("XCharter", "Charter", "Libertinus Serif"),
  size: 10.5pt,
  lang: "en",
  hyphenate: false,
)
#set par(justify: true, leading: 0.55em, spacing: 0.65em)
#set list(indent: 1.1em, body-indent: 0.6em, spacing: 3pt)
#show link: set text(fill: accent)
#show title: it => text(size: 19pt, weight: "bold", cv.name)

#show heading.where(level: 1): it => {
  block(above: 16pt, below: 8pt, width: 100%, breakable: false)[
    #stack(
      dir: ttb,
      spacing: 2pt,
      text(size: 10.5pt, weight: "bold", fill: accent, smallcaps(it.body)),
      line(length: 100%, stroke: 0.5pt + rule-color),
    )
  ]
}
#show heading.where(level: 2): it => {
  set text(size: 10.5pt, weight: "regular", hyphenate: false)
  it.body
}

#let section-title(body) = heading(level: 1, outlined: false)[#body]
#let entry-title(body) = heading(
  level: 2,
  outlined: false,
  bookmarked: false,
)[#strong(body)]

#let organization(name, location) = {
  v(8pt)
  grid(
    columns: (1fr, auto),
    column-gutter: 1em,
    entry-title(name),
    text(fill: muted, location),
  )
}

#let bullet-list(items) = {
  set par(justify: false, leading: 0.48em)
  pad(left: 1em)[
    #stack(
      dir: ttb,
      spacing: 9pt,
      ..items.map(item => grid(
        columns: (0.5em, 1fr),
        column-gutter: 0.4em,
        [•],
        item,
      )),
    )
  ]
}

#let role-details(entry) = {
  if "description" in entry {
    v(2pt)
    entry.description
  }
  if "bullets" in entry {
    v(3pt)
    bullet-list(entry.bullets)
  }
}

#let role(entry) = {
  v(3pt)
  let team = entry.at("team", default: "")
  grid(
    columns: (1fr, auto),
    column-gutter: 1em,
    {
      entry.title
      if team != "" {
        text(fill: muted, " · " + team)
      }
    },
    emph(entry.dates),
  )
  role-details(entry)
}

#let employer-block(employer) = {
  if employer.roles.len() == 1 {
    let entry = employer.roles.first()
    let team = entry.at("team", default: "")
    v(8pt)
    grid(
      columns: (1fr, auto),
      column-gutter: 1em,
      [
        #strong(employer.organization)
        #text(fill: rule-color)[ · ]
        #entry.title
        #if team != "" {
          text(fill: muted, " · " + team)
        }
        #text(fill: rule-color)[ · ]
        #text(fill: muted, employer.location)
      ],
      emph(entry.dates),
    )
    role-details(entry)
  } else {
    organization(employer.organization, employer.location)
    for entry in employer.roles {
      role(entry)
    }
  }
}

#let education(entry) = {
  v(7pt)
  grid(
    columns: (1fr, auto),
    column-gutter: 1em,
    [
      #entry.degree, #strong(entry.institution), #text(fill: muted, entry.location)
    ],
    emph(entry.dates),
  )
  v(1pt)
  text(fill: muted)[Advisor: #entry.advisor]
  if "notes" in entry {
    h(0.55em)
    text(fill: rule-color)[·]
    h(0.55em)
    text(fill: muted, style: "italic", entry.notes)
  }
}

// A row with a date column on the left, used for mentorship and service. `detail` is an optional muted second line.
#let dated-entry(years, body, detail: none) = block(above: 6pt, breakable: false)[
  #grid(
    columns: (date-column, 1fr),
    column-gutter: 1em,
    text(fill: muted, years),
    {
      body
      if detail != none {
        linebreak()
        text(fill: muted, detail)
      }
    },
  )
]

#let two-column-row(left, right) = block(above: 4pt)[
  #left
  #h(0.55em)#text(fill: rule-color)[·]#h(0.55em)
  #text(fill: muted, right)
]

// talks.yml stores dates as YYYY-MM-DD; show them as "Apr 2026".
#let month-names = (
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
)
#let talk-date(date) = {
  if type(date) == datetime {
    date.display("[month repr:short] [year]")
  } else {
    let parts = str(date).split("-")
    month-names.at(int(parts.at(1)) - 1) + " " + parts.at(0)
  }
}

// Header
#title()
#v(2pt)
#text(fill: muted)[
  #show link: set text(fill: muted)
  #link("mailto:" + cv.email)[#cv.email]
  #h(0.8em) | #h(0.8em)
  #link(cv.website.url)[#cv.website.label]
]
#block(above: 8pt)[
  #set par(justify: false, linebreaks: "optimized")
  #text(fill: black, style: "italic", costs: (runt: 10000%), cv.tagline)
]

#section-title[Education]
#for entry in cv.education {
  education(entry)
}

#section-title[Employment]
#for employer in cv.employment {
  block(breakable: false)[#employer-block(employer)]
}

#pagebreak(weak: true)
#section-title[Publications]
#for entry in publications {
  block(above: 12pt, below: 0pt, breakable: false)[
    #set par(justify: false, leading: 0.5em, spacing: 0pt)
    #show link: set text(fill: black)
    #let paper-url = entry.at("paper_url", default: none)
    #strong(if paper-url == none {
      entry.title
    } else {
      let url = if paper-url.contains("://") { paper-url } else {
        cv.website.url + "/" + paper-url
      }
      link(url, entry.title)
    })
    #linebreak()
    #entry.authors.split(", ").map(name => {
      if name == cv.name {
        text(fill: accent, style: "italic", name)
      } else {
        text(fill: muted, name)
      }
    }).join([, ])
    #linebreak()
    #let acronym = entry.venue_short.replace("‹", "").replace("›", "").replace("IEEE BigData", "Big Data")
    #let venue = if entry.venue.contains(acronym) { entry.venue } else {
      entry.venue + " (" + acronym + ")"
    }
    #{
      show acronym: name => text(fill: accent, name)
      venue + ", " + str(entry.year)
    }#if entry.publication_state == "in press" { [ (in press)] }
    #let awards = entry.at("awards", default: ())
    #if awards.len() > 0 {
      linebreak()
      text(fill: award-text-color, weight: "bold", awards.join("; "))
    }
  ]
}

#pagebreak(weak: true)
#section-title[Invited Talks]
// One entry per talk title, in the order talks.yml first lists them (newest
// first), with each place the talk was given beneath it.
#let talk-titles = talks.map(talk => talk.title).dedup()
#for title in talk-titles {
  block(above: 8pt, breakable: false)[
    #heading(level: 2, outlined: false, bookmarked: false)[
      #strong(title)
    ]
    #v(-1pt)
    #pad(
      left: 0.75em,
      stack(
        dir: ttb,
        spacing: 3pt,
        ..talks.filter(talk => talk.title == title).map(talk =>
        grid(
          columns: (1fr, auto),
          column-gutter: 1em,
          talk.venue,
          text(fill: muted, talk-date(talk.date)),
        )
        ),
      ),
    )
  ]
}

#section-title[Teaching]
#for institution in cv.teaching {
  block(above: 8pt, breakable: false)[
    #heading(level: 2, outlined: false, bookmarked: false)[
      Teaching Assistant, #strong(institution.institution)
    ]
    #v(-1pt)
    #pad(
      left: 0.75em,
      stack(
        dir: ttb,
        spacing: 3pt,
        ..institution.courses.map(course =>
        grid(
          columns: (1fr, auto),
          column-gutter: 1em,
          course.course,
          text(fill: muted, course.years),
        )
        ),
      ),
    )
  ]
}

#section-title[Mentorship]
#for entry in cv.mentorship {
  dated-entry(
    entry.years,
    [#strong(entry.name), #entry.project],
    detail: entry.institution,
  )
}

#section-title[Service & Volunteering]
#for entry in cv.service {
  dated-entry(entry.years, entry.description)
}

#section-title[Affiliations & Certifications]
#for entry in cv.affiliations {
  two-column-row(entry.description, entry.institution)
}
