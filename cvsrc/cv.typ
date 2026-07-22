// CV — Siddhartha Prasad
// Compile from this directory with: make

#let cv = yaml("../_data/cv.yml")
#let all-publications = yaml("../_data/publications.yml")
#let publications = cv.publications.map(title => {
  let publication = all-publications.find(item => item.title == title)
  assert(publication != none, message: "CV publication not found: " + title)
  publication
})

#let accent = rgb("#7b1f1f")
#let rule-color = rgb("#b8b0a8")
#let muted = rgb("#6b6b6b")

#set document(
  title: [Siddhartha Prasad — Curriculum Vitae],
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
#set par(justify: true, leading: 0.72em)
#set list(indent: 1.1em, body-indent: 0.6em, spacing: 3pt)
#show link: set text(fill: accent)
#show title: it => text(size: 19pt, weight: "bold", cv.name)

#show heading.where(level: 1): it => {
  block(above: 1.5em, below: 0.9em, width: 100%, breakable: false)[
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

#let role(entry) = {
  v(3pt)
  grid(
    columns: (1fr, auto),
    column-gutter: 1em,
    emph(entry.title + if entry.at("team", default: "") != "" {
      " · " + entry.team
    } else { "" }),
    emph(entry.dates),
  )
  if "description" in entry {
    v(2pt)
    entry.description
  }
  if "bullets" in entry {
    v(3pt)
    list(..entry.bullets.map(item => list.item(item)))
  }
}

#let education(entry) = {
  v(7pt)
  grid(
    columns: (1fr, auto, auto),
    column-gutter: 1.25em,
    entry-title(entry.institution),
    text(fill: muted, entry.location),
    emph(entry.dates),
  )
  entry.degree
  if "notes" in entry {
    linebreak()
    text(fill: muted, style: "italic", entry.notes)
  }
}

#let authors(names) = {
  names.split(", ").map(name => {
    if name == cv.name {
      text(fill: accent, style: "italic", name)
    } else {
      text(fill: muted, name)
    }
  }).join([, ])
}

#let publication(entry) = {
  let awards = entry.at("awards", default: ())
  block(above: 13pt, breakable: false)[
    #heading(level: 2, outlined: false, bookmarked: false)[
      #entry.title, #strong(entry.venue_short + " " + str(entry.year))
    ]
    #if awards.len() > 0 {
      linebreak()
      text(fill: accent, weight: "bold")[
        [#awards.map(award => award.replace(" Award", "")).join("; ")]
      ]
    }
    #linebreak()
    #authors(entry.authors)
  ]
}

#let three-column-row(left, center, right) = block(above: 4pt)[
  #text(fill: muted, left)
  #h(0.55em)#text(fill: rule-color)[·]#h(0.55em)
  #center
  #if right != "" [
    #h(0.55em)#text(fill: rule-color)[·]#h(0.55em)
    #text(fill: muted, right)
  ]
]

#let two-column-row(left, right) = block(above: 4pt)[
  #left
  #h(0.55em)#text(fill: rule-color)[·]#h(0.55em)
  #text(fill: muted, right)
]

// Header
#grid(
  columns: (1fr, auto),
  column-gutter: 1em,
  title(),
  align(right, text(size: 8.5pt, style: "italic", fill: muted)[
    Updated #cv.updated
  ]),
)
#v(2pt)
#link("mailto:" + cv.email)[#cv.email]
#h(0.8em) | #h(0.8em)
#link(cv.website.url)[#cv.website.label]

#v(0.8em)
#cv.summary

#section-title[Education]
#for entry in cv.education {
  education(entry)
}

#section-title[Employment]
#for employer in cv.employment {
  organization(employer.organization, employer.location)
  for entry in employer.roles {
    role(entry)
  }
}

#pagebreak()
#section-title[Publications]
#for entry in publications {
  publication(entry)
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

#section-title[Service]
#for entry in cv.service {
  three-column-row(entry.years, entry.description, "")
}

#section-title[Affiliations & Certifications]
#for entry in cv.affiliations {
  two-column-row(entry.description, entry.institution)
}
