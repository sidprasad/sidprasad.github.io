// Resume - Siddhartha Prasad
// A shorter version of the CV. Compile with: make resume

#let cv = yaml("../_data/cv.yml")
#let all-publications = yaml("../_data/publications.yml")
#let publications = cv.resume.selected_publications.map(title => {
  let publication = all-publications.find(item => item.title == title)
  assert(publication != none, message: "Resume publication not found: " + title)
  publication
})

#let accent = rgb("#7b1f1f")
#let rule-color = rgb("#b8b0a8")
#let muted = rgb("#6b6b6b")

#set document(
  title: [Siddhartha Prasad - Resume],
  author: cv.name,
  description: [Resume],
  keywords: (
    "Siddhartha Prasad",
    "Resume",
    "Computer Science",
    "Programming Languages",
    "Formal Methods",
    "Human-Computer Interaction",
  ),
)
#set page(
  paper: "us-letter",
  margin: (x: 0.78in, y: 0.7in),
  header: align(right, text(size: 8.5pt, style: "italic", fill: muted, cv.updated)),
  footer: context {
    align(right, text(size: 8.5pt, fill: muted)[#counter(page).display()])
  },
)
#set text(
  font: ("XCharter", "Charter", "Libertinus Serif"),
  size: 10.25pt,
  lang: "en",
  hyphenate: false,
)
#set par(justify: true, leading: 0.68em)
#set list(indent: 1.1em, body-indent: 0.6em, spacing: 3pt)

#show heading.where(level: 1): it => {
  block(above: 1.35em, below: 0.8em, width: 100%, breakable: false)[
    #stack(
      dir: ttb,
      spacing: 2pt,
      text(size: 10.25pt, weight: "bold", fill: accent, smallcaps(it.body)),
      line(length: 100%, stroke: 0.5pt + rule-color),
    )
  ]
}

#let section-title(body) = heading(level: 1, outlined: false)[#body]

#let organization(name, location) = {
  v(8pt)
  grid(
    columns: (1fr, auto),
    column-gutter: 1em,
    strong(name),
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
  text(size: 9.25pt, fill: muted)[Advisor: #entry.advisor]
  if "notes" in entry {
    h(0.55em)
    text(size: 9.25pt, fill: rule-color)[·]
    h(0.55em)
    text(size: 9.25pt, fill: muted, style: "italic", entry.notes)
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
  block(above: 11pt, breakable: false)[
    #let destination = entry.at("paper_url", default: none)
    #let title = if destination == none {
      entry.title
    } else {
      link(destination)[#text(fill: black, entry.title)]
    }
    #title#if awards.len() == 0 {
      text(fill: black, weight: "bold")[, #entry.venue_short #entry.year]
    }
    #if awards.len() > 0 {
      let distinction = awards.map(award => award.replace(" Award", "")).join(" and ")
      linebreak()
      text(fill: accent, weight: "bold", distinction)
      text(fill: black)[ at ]
      text(fill: black, weight: "bold")[#entry.venue_short #entry.year]
    }
    #linebreak()
    #authors(entry.authors)
  ]
}

// Header
#text(size: 19pt, weight: "bold", cv.name)
#v(2pt)
#link("mailto:" + cv.email)[#text(fill: accent, cv.email)]
#h(0.8em) | #h(0.8em)
#link(cv.website.url)[#text(fill: accent, cv.website.label)]

#v(0.8em)
#cv.summary

#section-title[Education]
#for entry in cv.education {
  education(entry)
}

#section-title[Employment]
#for employer in cv.employment {
  employer-block(employer)
}

#pagebreak()
#v(12pt)
#section-title[Selected Publications]
#for entry in publications {
  publication(entry)
}
