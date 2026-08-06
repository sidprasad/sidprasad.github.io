# CV and resume source

The CV and resume content is shared by the website and the PDFs:

- Edit personal, education, employment, teaching, service, and affiliation data
  in `../_data/cv.yml`.
- Edit the resume's selected publications in the `resume` block of
  `../_data/cv.yml`.
- Edit publication details in `../_data/publications.yml`; the `publications`
  list in `cv.yml` selects and orders the entries shown on the CV.
- Edit the PDF layouts in `cv.typ` and `resume.typ`, and the web layout in
  `../cv.md`.

Build both `../cv.pdf` and `../resume.pdf` with:

```sh
make
```

Build only one document with `make cv` or `make resume`.

## Application-specific resumes

`resume.variants` in `../_data/cv.yml` defines alternate cuts of the resume.
A variant may append `additional_publications` to the default
`selected_publications` list, and may set `redact_education_dates: true`, which
shows each education entry's `dates_redacted` value in place of its `dates` —
for applications that ask that dates of attendance and graduation be withheld.
An empty `dates_redacted` omits the dates entirely.

Build one with `--input variant=<name>`; `make microsoft` writes the `microsoft`
variant to `../tmp/resume-microsoft.pdf`, which is not published with the site.

This requires Typst 0.14.2 or newer. If TeX's XCharter font is installed, the
Makefile finds it through `kpsewhich`; otherwise Typst falls back to a system
Charter-compatible serif.
