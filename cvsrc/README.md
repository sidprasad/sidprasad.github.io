# CV and resume source

The CV and resume content is shared by the website and the PDFs:

- Edit personal, education, employment, teaching, service, and affiliation data
  in `../_data/cv.yml`.
- Edit the resume's selected publications in the `resume` block of
  `../_data/cv.yml`.
- Edit publication titles, authors, full venue names, acronyms, years, paper
  links, awards, and publication status in `../_data/publications.yml`.
  The `publications` list in `cv.yml` selects and orders the CV entries;
  each must have `publication_state: published` or `publication_state: in press`.
- The CV's Invited Talks come from `../_data/talks.yml`, and Mentorship from
  `mentorship` in `cv.yml`.
- The web CV heading and PDF running header read
  `<family_name>, <given_name> - CV`, from the name fields in `cv.yml`.
- Edit the PDF layouts in `cv.typ` and `resume.typ`, and the web layout in
  `../cv.md`.

Build both `../cv.pdf` and `../resume.pdf` with:

```sh
make
```

Build only one document with `make cv` or `make resume`.

The standard `../cv.pdf` is also the application-ready CV downloaded from the
website. `make application-cv` and `make miller` remain compatibility aliases
for `make cv`; they do not produce separate application PDFs.

Both the web CV and PDF show each publication as a linked title, author list,
full conference or journal name with acronym where useful, and year. The familiar
venue names and abbreviations appear in red; paper titles are black and bold.
The research tagline appears in italics. Publication
awards appear directly below the citation in blue. Publishers and page ranges
are omitted. The PDF separates publication entries by 12 pt and keeps each
entry together; Publications and Invited Talks begin on new pages.

The short research tagline in `cv.yml` appears below the contact details, followed
by Education. The longer shared summary in `cv.yml` is still used by the resume.
Education lists both
institutions and fields of study; Teaching records academic positions, and
Service & Volunteering records service experience. The requested name header
appears at the top of every PDF page. Employment entries stay together across
page breaks.

Older application exports in `output/` are not rebuilt; that directory remains
ignored by Git and excluded from Jekyll builds. The detailed reference metadata
in `../_data/publications.bib` and the older `acm-application.csl` style remain
available for reuse but are not required by the standard CV build.

## Application-specific resumes

`resume.variants` in `../_data/cv.yml` defines alternate cuts of the resume.
A variant may append `additional_publications` to the default
`selected_publications` list, and may set `redact_education_dates: true`, which
shows each education entry's `dates_redacted` value in place of its `dates` —
for applications that ask that dates of attendance and graduation be withheld.
An empty `dates_redacted` omits the dates entirely.

Build one with `--input variant=<name>`; `make microsoft` writes the `microsoft`
variant to `../tmp/resume-microsoft.pdf`, which is not published with the site.

The CV and resume require Typst 0.14.2 or newer. If TeX's XCharter font is installed, the
Makefile finds it through `kpsewhich`; otherwise Typst falls back to a system
Charter-compatible serif.
